import { db } from "../db";
import { months, transactions } from "../db/schema";
import { eq, and, sql, notInArray, not, or, like } from "drizzle-orm";
import { BANK_CATEGORIES } from "./constants";

async function check() {
  const jan = await db.query.months.findFirst({
    where: eq(months.id, 1) // Assuming Jan 2026 is ID 1 based on previous context
  });
  
  if (!jan) {
    console.log("Jan 2026 (ID 1) not found");
    return;
  }

  const income = await db.select({ total: sql<number>`sum(${transactions.amount})` })
    .from(transactions)
    .where(and(
      eq(transactions.monthId, 1),
      eq(transactions.type, 'income'),
      notInArray(transactions.category, BANK_CATEGORIES)
    ));

  const costing = await db.select({ total: sql<number>`sum(${transactions.amount})` })
    .from(transactions)
    .where(and(
      eq(transactions.monthId, 1),
      eq(transactions.type, 'costing'),
      notInArray(transactions.category, BANK_CATEGORIES),
      not(or(
        like(transactions.category, 'স্টাফ বেতন%'),
        like(transactions.category, 'পরিচালকগণের সম্মানী প্রদান (ব্যাংক)%'),
        like(transactions.category, 'ব্যাংক এ যাবতীয় জমা%')
      ))
    ));

  console.log("Jan Opening Balance:", jan.openingBalance);
  console.log("Jan Income:", Number(income[0]?.total || 0));
  console.log("Jan Cash Costing (Excluding Bank Items):", Number(costing[0]?.total || 0));
  console.log("Jan Net Balance (Dashboard Logic):", (jan.openingBalance + Number(income[0]?.total || 0)) - Number(costing[0]?.total || 0));
}

check().then(() => process.exit());
