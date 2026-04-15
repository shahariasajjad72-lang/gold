'use server';

import { db } from '@/db';
import { months, transactions } from '@/db/schema';
import { desc, eq, and, sql as drizzleSql, notInArray } from 'drizzle-orm';
import { revalidatePath } from 'next/cache';
import { BANK_CATEGORIES } from './constants';

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
      total: drizzleSql<number>`sum(${transactions.amount})` 
    })
    .from(transactions)
    .where(and(
      eq(transactions.monthId, monthId), 
      eq(transactions.type, 'income'),
      notInArray(transactions.category, BANK_CATEGORIES)
    ));

    const costingResult = await db.select({ 
      total: drizzleSql<number>`sum(${transactions.amount})` 
    })
    .from(transactions)
    .where(and(
      eq(transactions.monthId, monthId), 
      eq(transactions.type, 'costing'),
      notInArray(transactions.category, BANK_CATEGORIES)
    ));

    const totalIncome = Number(incomeResult[0]?.total || 0);
    const totalCosting = Number(costingResult[0]?.total || 0);

    await db.update(months)
      .set({ income: totalIncome, costing: totalCosting })
      .where(eq(months.id, monthId));
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

export async function getBankTransactions(category: string) {
  try {
    return await db.query.transactions.findMany({
      where: eq(transactions.category, category),
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
      total: drizzleSql<number>`sum(${transactions.amount})` 
    })
    .from(transactions)
    .where(and(
        eq(transactions.monthId, monthId), 
        eq(transactions.type, 'income'),
        notInArray(transactions.category, BANK_CATEGORIES),
        drizzleSql`${transactions.date} <= ${selectedDate.toISOString()}`
    ));

    const costingResult = await db.select({ 
      total: drizzleSql<number>`sum(${transactions.amount})` 
    })
    .from(transactions)
    .where(and(
        eq(transactions.monthId, monthId), 
        eq(transactions.type, 'costing'),
        notInArray(transactions.category, BANK_CATEGORIES),
        drizzleSql`${transactions.date} <= ${selectedDate.toISOString()}`
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
      total: drizzleSql<number>`sum(${transactions.amount})` 
    })
    .from(transactions)
    .where(and(
        eq(transactions.monthId, monthId), 
        eq(transactions.type, 'income'),
        notInArray(transactions.category, BANK_CATEGORIES),
        drizzleSql`${transactions.date} < ${startOfDay.toISOString()}`
    ));

    const costingResult = await db.select({ 
      total: drizzleSql<number>`sum(${transactions.amount})` 
    })
    .from(transactions)
    .where(and(
        eq(transactions.monthId, monthId), 
        eq(transactions.type, 'costing'),
        notInArray(transactions.category, BANK_CATEGORIES),
        drizzleSql`${transactions.date} < ${startOfDay.toISOString()}`
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
        drizzleSql`${transactions.date} >= ${startOfDay.toISOString()} AND ${transactions.date} <= ${endOfDay.toISOString()}`
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
        notInArray(transactions.category, BANK_CATEGORIES)
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
    const month = await getMonthById(monthId);
    if (!month) return null;

    const allTransactions = await db.query.transactions.findMany({
      where: eq(transactions.monthId, monthId),
      orderBy: [transactions.category],
    });

    // Group income by category
    const incomeByCategory: Record<string, number> = {};
    // Group costing by category
    const costingByCategory: Record<string, number> = {};
    // Group bank by category
    const bankByCategory: Record<string, { credit: number; debit: number }> = {};

    allTransactions.forEach((t) => {
      if (BANK_CATEGORIES.includes(t.category)) {
        if (!bankByCategory[t.category]) {
          bankByCategory[t.category] = { credit: 0, debit: 0 };
        }
        if (t.type === 'income') bankByCategory[t.category].credit += t.amount;
        else bankByCategory[t.category].debit += t.amount;
      } else if (t.type === 'income') {
        incomeByCategory[t.category] = (incomeByCategory[t.category] || 0) + t.amount;
      } else if (t.type === 'costing') {
        costingByCategory[t.category] = (costingByCategory[t.category] || 0) + t.amount;
      }
    });

    return {
      month,
      incomeByCategory,
      costingByCategory,
      bankByCategory,
    };
  } catch (error) {
    console.error('Failed to fetch month end summary:', error);
    return null;
  }
}
