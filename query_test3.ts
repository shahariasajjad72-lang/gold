import { db } from "./src/db";
import { transactions } from "./src/db/schema";
import { eq, and } from "drizzle-orm";
import { BANK_CATEGORIES } from "./src/lib/constants";

async function run() {
  const allCosting = await db.query.transactions.findMany({
    where: and(eq(transactions.monthId, 2), eq(transactions.type, 'costing'))
  });

  let sumAll = 0;
  let sumDB = 0;
  let sumModal = 0;

  for (const t of allCosting) {
    sumAll += t.amount;
    
    // simulate DB costing logic
    let isDBCosting = true;
    if (BANK_CATEGORIES.includes(t.category)) isDBCosting = false;
    if (t.category.startsWith('স্টাফদের বেতন প্রধান (ব্যাংক)')) isDBCosting = false;
    if (t.category.startsWith('পরিচালকগণের সম্মানী প্রদান (ব্যাংক)')) isDBCosting = false;
    
    if (isDBCosting) sumDB += t.amount;

    // simulate Modal costing logic
    // Modal gets items via getMonthEndSummary which excludes BANK_CATEGORIES
    let isModalCosting = true;
    if (BANK_CATEGORIES.includes(t.category)) isModalCosting = false;
    // but Modal EXCLUDES "ব্যাংক এ যাবতীয় জমা"
    // wait! Modal receives normalized category from getMonthEndSummary!
    let normCat = t.category.trim();
    if (normCat.includes("(")) {
      const stripped = normCat.replace(/\s*\([^)]*\)$/, "").trim();
      // simulating my new normalize logic
      // let's just pretend it normalized properly
      normCat = stripped; 
    }
    // "ব্যাংক এ যাবতীয় জমা (মাস-সাল)" is normalized to "ব্যাংক এ যাবতীয় জমা"
    // then Modal excludes it!
    if (t.category.startsWith("ব্যাংক এ যাবতীয় জমা")) isModalCosting = false;

    if (isModalCosting) sumModal += t.amount;
    
    if (isModalCosting !== isDBCosting) {
        console.log(`Mismatch cat: ${t.category}, amount: ${t.amount}, DB: ${isDBCosting}, Modal: ${isModalCosting}`);
    }
  }

  console.log({sumAll, sumDB, sumModal, diff: sumModal - sumDB});
  process.exit(0);
}

run();
