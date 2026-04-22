'use server';

import { db } from "@/db";
import { months, transactions, globalBanks } from "@/db/schema";
import {
  desc,
  eq,
  and,
  or,
  not,
  like,
  sql,
  notInArray,
  inArray,
} from "drizzle-orm";
import { revalidatePath } from "next/cache";
import { BANK_CATEGORIES } from "./constants";

export async function getMonths() {
  try {
    return await db.query.months.findMany({
      orderBy: [desc(months.year), desc(months.id)],
    });
  } catch (error) {
    console.error('Failed to fetch months:', error);
    return [];
  }
}

export async function addMonth(name: string, year: number, openingBalance: number = 0) {
  try {
    const result = await db.insert(months).values({
      name,
      year,
      openingBalance,
      income: 0,
      costing: 0,
      netBalance: openingBalance,
    }).returning({ id: months.id });
    revalidatePath('/dashboard');
    return { success: true, id: result[0].id };
  } catch (error) {
    console.error('Failed to add month:', error);
    return { success: false, error: 'Failed to create month entry' };
  }
}

export async function getMonthById(id: number) {
  try {
    const result = await db.query.months.findFirst({
      where: eq(months.id, id),
    });
    return result || null;
  } catch (error) {
    console.error('Failed to fetch month details:', error);
    return null;
  }
}

async function syncMonthTotals(monthId: number) {
  try {
    const incomeResult = await db.select({ 
      total: sql<number>`sum(${transactions.amount})` 
    })
    .from(transactions)
    .where(and(
      eq(transactions.monthId, monthId), 
      eq(transactions.type, 'income'),
      notInArray(transactions.category, BANK_CATEGORIES)
    ));

    const costingResult = await db.select({ 
      total: sql<number>`sum(${transactions.amount})` 
    })
    .from(transactions)
    .where(and(
      eq(transactions.monthId, monthId), 
      eq(transactions.type, 'costing'),
      notInArray(transactions.category, BANK_CATEGORIES),
      not(or(
        like(transactions.category, 'স্টাফদের বেতন প্রধান (ব্যাংক)%'),
        like(transactions.category, 'পরিচালকগণের সম্মানী প্রদান (ব্যাংক)%')
      ))
    ));

    const totalIncome = Number(incomeResult[0]?.total || 0);
    const totalCosting = Number(costingResult[0]?.total || 0);

    const month = await db.query.months.findFirst({
      where: eq(months.id, monthId),
    });

    if (month) {
      const netBalance = (month.openingBalance || 0) + totalIncome - totalCosting;
      await db.update(months)
        .set({ income: totalIncome, costing: totalCosting, netBalance })
        .where(eq(months.id, monthId));
    }
  } catch (err) {
    console.error('Failed to sync totals:', err);
  }
}

export async function getTransactions(monthId: number, category: string) {
  try {
    return await db.query.transactions.findMany({
      where: and(eq(transactions.monthId, monthId), eq(transactions.category, category)),
      orderBy: [desc(transactions.date)],
    });
  } catch (error) {
    console.error('Failed to fetch transactions:', error);
    return [];
  }
}

export async function getBankTransactions(monthId: number, category: string) {
  try {
    return await db.query.transactions.findMany({
      where: and(eq(transactions.monthId, monthId), eq(transactions.category, category)),
      orderBy: [desc(transactions.date)],
    });
  } catch (error) {
    console.error('Failed to fetch bank transactions:', error);
    return [];
  }
}

export async function addTransaction(data: {
  monthId: number;
  type: 'income' | 'costing';
  category: string;
  date: Date;
  description: string;
  amount: number;
  weight?: string;
}) {
  try {
    await db.insert(transactions).values(data);
    await syncMonthTotals(data.monthId);
    revalidatePath(`/month/${data.monthId}`, 'layout');
    return { success: true };
  } catch (error) {
    console.error('Failed to add transaction:', error);
    return { success: false };
  }
}

export async function updateTransaction(id: number, monthId: number, data: {
  description: string;
  amount: number;
  date: Date;
  type?: 'income' | 'costing';
  weight?: string;
}) {
  try {
    await db.update(transactions)
      .set(data)
      .where(eq(transactions.id, id));
    await syncMonthTotals(monthId);
    revalidatePath(`/month/${monthId}`);
    return { success: true };
  } catch (error) {
    console.error('Failed to update transaction:', error);
    return { success: false };
  }
}

export async function deleteTransaction(id: number, monthId: number) {
  try {
    await db.delete(transactions).where(eq(transactions.id, id));
    await syncMonthTotals(monthId);
    revalidatePath(`/month/${monthId}`);
    return { success: true };
  } catch (error) {
    console.error('Failed to delete transaction:', error);
    return { success: false };
  }
}

export async function updateMonthStats(id: number, income: number, costing: number) {
  try {
    await db.update(months)
      .set({ income, costing })
      .where(eq(months.id, id));
    revalidatePath(`/month/${id}`, 'layout');
    revalidatePath('/dashboard');
    return { success: true };
  } catch (error) {
    console.error('Failed to update month stats:', error);
    return { success: false };
  }
}

export async function updateOpeningBalance(id: number, openingBalance: number) {
  try {
    await db.update(months)
      .set({ openingBalance })
      .where(eq(months.id, id));
    revalidatePath(`/month/${id}`, 'layout');
    revalidatePath('/dashboard');
    return { success: true };
  } catch (error) {
    console.error('Failed to update opening balance:', error);
    return { success: false };
  }
}

export async function getMonthlyStatsUpToDate(monthId: number, dateStr: string) {
  try {
    const selectedDate = new Date(dateStr);
    selectedDate.setHours(23, 59, 59, 999);

    // Sum of income and costing up to the selected date
    const incomeResult = await db.select({ 
      total: sql<number>`sum(${transactions.amount})` 
    })
    .from(transactions)
    .where(and(
        eq(transactions.monthId, monthId), 
        eq(transactions.type, 'income'),
        notInArray(transactions.category, BANK_CATEGORIES),
        sql`${transactions.date} <= ${selectedDate.toISOString()}`
    ));

    const costingResult = await db.select({ 
      total: sql<number>`sum(${transactions.amount})` 
    })
    .from(transactions)
    .where(and(
        eq(transactions.monthId, monthId), 
        eq(transactions.type, 'costing'),
        notInArray(transactions.category, BANK_CATEGORIES),
        not(or(
          like(transactions.category, 'স্টাফদের বেতন প্রধান (ব্যাংক)%'),
          like(transactions.category, 'পরিচালকগণের সম্মানী প্রদান (ব্যাংক)%')
        )),
        sql`${transactions.date} <= ${selectedDate.toISOString()}`
    ));

    return {
      totalIncome: Number(incomeResult[0]?.total || 0),
      totalCosting: Number(costingResult[0]?.total || 0)
    };
  } catch (error) {
    console.error('Failed to fetch stats up to date:', error);
    return { totalIncome: 0, totalCosting: 0 };
  }
}

export async function getMonthlyStatsBeforeDate(monthId: number, dateStr: string) {
  try {
    const startOfDay = new Date(dateStr);
    startOfDay.setHours(0, 0, 0, 0);

    // Sum of income and costing strictly BEFORE the selected date
    const incomeResult = await db.select({ 
      total: sql<number>`sum(${transactions.amount})` 
    })
    .from(transactions)
    .where(and(
        eq(transactions.monthId, monthId), 
        eq(transactions.type, 'income'),
        notInArray(transactions.category, BANK_CATEGORIES),
        sql`${transactions.date} < ${startOfDay.toISOString()}`
    ));

    const costingResult = await db.select({ 
      total: sql<number>`sum(${transactions.amount})` 
    })
    .from(transactions)
    .where(and(
        eq(transactions.monthId, monthId), 
        eq(transactions.type, 'costing'),
        notInArray(transactions.category, BANK_CATEGORIES),
        not(or(
          like(transactions.category, 'স্টাফদের বেতন প্রধান (ব্যাংক)%'),
          like(transactions.category, 'পরিচালকগণের সম্মানী প্রদান (ব্যাংক)%')
        )),
        sql`${transactions.date} < ${startOfDay.toISOString()}`
    ));

    return {
      totalIncome: Number(incomeResult[0]?.total || 0),
      totalCosting: Number(costingResult[0]?.total || 0)
    };
  } catch (error) {
    console.error('Failed to fetch stats before date:', error);
    return { totalIncome: 0, totalCosting: 0 };
  }
}

export async function getDailyTransactions(monthId: number, dateStr: string) {
  try {
    const startOfDay = new Date(dateStr);
    startOfDay.setHours(0, 0, 0, 0);
    const endOfDay = new Date(dateStr);
    endOfDay.setHours(23, 59, 59, 999);

    return await db.query.transactions.findMany({
      where: and(
        eq(transactions.monthId, monthId),
        notInArray(transactions.category, BANK_CATEGORIES),
        sql`${transactions.date} >= ${startOfDay.toISOString()} AND ${transactions.date} <= ${endOfDay.toISOString()}`
      ),
      orderBy: [desc(transactions.type), transactions.category],
    });
  } catch (error) {
    console.error('Failed to fetch daily transactions:', error);
    return [];
  }
}

export async function getMonthlyDailyBreakdown(monthId: number) {
  try {
    const month = await getMonthById(monthId);
    if (!month) return [];

    const allTransactions = await db.query.transactions.findMany({
      where: and(
        eq(transactions.monthId, monthId),
        notInArray(transactions.category, BANK_CATEGORIES),
        not(or(
          like(transactions.category, 'স্টাফদের বেতন প্রধান (ব্যাংক)%'),
          like(transactions.category, 'পরিচালকগণের সম্মানী প্রদান (ব্যাংক)%')
        ))
      ),
      orderBy: [transactions.date],
    });

    const dailyBreakdown: Record<string, { date: Date; income: number; costing: number }> = {};
    
    allTransactions.forEach((t) => {
      const dateKey = new Date(t.date).toISOString().split('T')[0];
      if (!dailyBreakdown[dateKey]) {
        dailyBreakdown[dateKey] = { date: new Date(t.date), income: 0, costing: 0 };
      }
      if (t.type === 'income') dailyBreakdown[dateKey].income += t.amount;
      if (t.type === 'costing') dailyBreakdown[dateKey].costing += t.amount;
    });

    const sortedDates = Object.keys(dailyBreakdown).sort();
    let currentCarry = month.openingBalance || 0;

    return sortedDates.map((dateStr) => {
      const day = dailyBreakdown[dateStr];
      const opening = currentCarry;
      const closing = opening + day.income - day.costing;
      currentCarry = closing;
      
      return {
        date: day.date,
        opening,
        income: day.income,
        costing: day.costing,
        closing,
      };
    });
  } catch (error) {
    console.error('Failed to fetch monthly breakdown:', error);
    return [];
  }
}

export async function getMonthEndSummary(monthId: number) {
  try {
    const month = await db.query.months.findFirst({
      where: eq(months.id, monthId),
    });
    if (!month) return null;

    const monthTransactions = await db.query.transactions.findMany({
      where: and(
        eq(transactions.monthId, monthId),
        notInArray(transactions.category, BANK_CATEGORIES),
      ),
      orderBy: [transactions.category],
    });

    const normalize = (cat: string) => {
      const trimmed = cat.trim();
      return trimmed.includes("(")
        ? trimmed.replace(/\([^)]*\)$/, "(মাস-সাল)")
        : trimmed;
    };

    const incomeByCategory: Record<string, number> = {};
    const costingByCategory: Record<string, number> = {};

    monthTransactions.forEach((t) => {
      // Logic: If the category is a Bank Category, it's a direct bank entry (Transfer/Withdrawal)
      // and should NOT be counted as Income or Expense in the ledger totals, 
      // as it's already reflected in the Opening/Closing Bank balances.
      if (BANK_CATEGORIES.includes(t.category)) return;

      const normCat = normalize(t.category);
      if (t.type === "income") {
        let targetCat = normCat;
        // Split Nehara from Dust Sale if description contains the keyword
        if (normCat === "ডাস্ট বিক্রয় হতে আয়" && t.description?.includes("নেহারা")) {
          targetCat = "নেহারা বিক্রয় হতে আয়";
        }
        incomeByCategory[targetCat] = (incomeByCategory[targetCat] || 0) + t.amount;
      } else if (t.type === "costing") {
        costingByCategory[normCat] = (costingByCategory[normCat] || 0) + t.amount;
      }
    });

    // Handle Global Bank logic
    try {
      await db.execute(sql`
        CREATE TABLE IF NOT EXISTS global_banks (
          id SERIAL PRIMARY KEY,
          category TEXT UNIQUE NOT NULL,
          initial_balance INTEGER DEFAULT 0,
          created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
        );
      `);
    } catch (e) {}

    const globalConfigs = await db.query.globalBanks.findMany();
    const bankCalculated: Record<
      string,
      { opening: number; credit: number; debit: number; closing: number }
    > = {};

    for (const bank of BANK_CATEGORIES) {
      const config = globalConfigs.find((c) => c.category === bank);
      const initialBal = config?.initialBalance || 0;

      const bankTrans = await db.query.transactions.findMany({
        where: eq(transactions.category, bank),
      });

      const allMonths = await db.query.months.findMany();
      const previousMonthIds = allMonths
        .filter(
          (m) =>
            m.year < month.year || (m.year === month.year && m.id < monthId),
        )
        .map((m) => m.id);

      let opening = initialBal;
      let credit = 0;
      let debit = 0;

      bankTrans.forEach((t) => {
        if (previousMonthIds.includes(t.monthId)) {
          opening += t.type === "income" ? t.amount : -t.amount;
        } else if (t.monthId === monthId) {
          if (t.type === "income") credit += t.amount;
          if (t.type === "costing") debit += t.amount;
        }
      });

      bankCalculated[bank] = {
        opening,
        credit,
        debit,
        closing: opening + credit - debit,
      };
    }

    return {
      month,
      incomeByCategory,
      costingByCategory,
      bankCalculated,
    };
  } catch (error) {
    console.error("Failed to fetch month end summary:", error);
    return null;
  }
}

export async function getGlobalBankConfigs() {
  try {
    try {
      await db.execute(sql`
        CREATE TABLE IF NOT EXISTS global_banks (
          id SERIAL PRIMARY KEY,
          category TEXT UNIQUE NOT NULL,
          initial_balance INTEGER DEFAULT 0,
          created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
        );
      `);
    } catch (e) {}

    const configs = await db.query.globalBanks.findMany();

    const allBankTrans = await db.query.transactions.findMany({
      where: inArray(transactions.category, BANK_CATEGORIES),
    });

    const results = BANK_CATEGORIES.map((b) => {
      const found = configs.find((c) => c.category === b);
      const initial = found?.initialBalance || 0;

      const bankTrans = allBankTrans.filter((t) => t.category === b);
      const current = bankTrans.reduce((acc, t) => {
        return t.type === "income" ? acc + t.amount : acc - t.amount;
      }, initial);

      return { category: b, initialBalance: initial, currentBalance: current };
    });
    return results;
  } catch (error) {
    console.error("Failed to fetch global bank configs:", error);
    return BANK_CATEGORIES.map((b) => ({
      category: b,
      initialBalance: 0,
      currentBalance: 0,
    }));
  }
}

export async function updateGlobalBankConfig(
  category: string,
  initialBalance: number,
) {
  try {
    const existing = await db.query.globalBanks.findFirst({
      where: eq(globalBanks.category, category),
    });

    if (existing) {
      await db
        .update(globalBanks)
        .set({ initialBalance })
        .where(eq(globalBanks.id, existing.id));
    } else {
      await db.insert(globalBanks).values({ category, initialBalance });
    }
    revalidatePath("/dashboard");
    return { success: true };
  } catch (e) {
    console.error("Failed to update global bank:", e);
    return { success: false };
  }
}

export async function getGlobalBankStatement(category: string) {
  try {
    const config = await db.query.globalBanks.findFirst({
      where: eq(globalBanks.category, category),
    });
    const openingBalance = config?.initialBalance || 0;

    const trans = await db.query.transactions.findMany({
      where: eq(transactions.category, category),
      orderBy: [transactions.date, transactions.id],
    });

    return {
      openingBalance,
      transactions: trans,
    };
  } catch (e) {
    console.error("Failed to get statement:", e);
    return { openingBalance: 0, transactions: [] };
  }
}
