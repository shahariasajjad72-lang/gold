import { db } from "./src/db";
import { transactions, months } from "./src/db/schema";
import { eq, and, sql } from "drizzle-orm";
import { getMonthEndSummary } from "./src/lib/actions";
import { BANK_CATEGORIES } from "./src/lib/constants";

const PURE_BANK_CATEGORIES = [
  "ব্যাংক এর আবগারি শুল্ক",
  "ব্যাংক এর মাধ্যমে পেমেন্ট",
  "ব্যাংক হতে প্রাপ্ত লভ্যাংশ"
];

async function run() {
  const allMonths = await db.query.months.findMany();
  for (const m of allMonths) {
    const summary = await getMonthEndSummary(m.id);
    
    // Simulate what DB totals WOULD be if we excluded PURE_BANK_CATEGORIES (but NOT "ব্যাংক এ যাবতীয় জমা")
    const allTrans = await db.query.transactions.findMany({
      where: and(eq(transactions.monthId, m.id), notInArray(transactions.category, BANK_CATEGORIES))
    });

    let simIncome = 0;
    let simCosting = 0;
    for (const t of allTrans) {
      if (t.type === 'income') {
         if (!PURE_BANK_CATEGORIES.some(c => t.category.startsWith(c))) {
             simIncome += t.amount;
         }
      }
      if (t.type === 'costing') {
         if (!PURE_BANK_CATEGORIES.some(c => t.category.startsWith(c)) && 
             !t.category.startsWith('স্টাফদের বেতন প্রধান (ব্যাংক)') &&
             !t.category.startsWith('পরিচালকগণের সম্মানী প্রদান (ব্যাংক)')) {
             simCosting += t.amount;
         }
      }
    }
    
    const simCashClosing = (m.openingBalance || 0) + simIncome - simCosting;

    const totalIncome = Object.values(summary.incomeByCategory || {}).reduce((s: number, v) => s + (v as number), 0);
    const totalCosting = Object.entries(summary.costingByCategory || {}).reduce((s: number, [cat, val]) => {
      if (cat === "ব্যাংক এ যাবতীয় জমা") return s;
      return s + (val as number);
    }, 0);
    
    const openingBankBalance = BANK_CATEGORIES.reduce((s, c) => s + (summary.bankCalculated?.[c]?.opening || 0), 0);
    const closingBankBalance = BANK_CATEGORIES.reduce((s, c) => s + (summary.bankCalculated?.[c]?.closing || 0), 0);

    const cashInitial = m.openingBalance || 0;
    
    const grandTotalIncome = totalIncome + (openingBankBalance + cashInitial);
    const grandTotalCosting = totalCosting + (closingBankBalance + simCashClosing);

    const gap = grandTotalIncome - grandTotalCosting;
    console.log(`Month ${m.name} ${m.year} (ID: ${m.id}): Simulated Gap = ${gap}`);
  }
  process.exit(0);
}
// using require to bypass import limits
const { notInArray } = require('drizzle-orm');
run();
