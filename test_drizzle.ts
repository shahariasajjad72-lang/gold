import { db } from "./src/db";
import { transactions } from "./src/db/schema";
import { eq, or, not, like } from "drizzle-orm";
const PURE_BANK_CATEGORIES = [
  "ব্যাংক এর আবগারি শুল্ক",
  "ব্যাংক এর মাধ্যমে পেমেন্ট",
  "ব্যাংক হতে প্রাপ্ত লভ্যাংশ"
];

const excludePureBankCategories = not(or(
  ...PURE_BANK_CATEGORIES.map(c => like(transactions.category, `${c}%`))
));

async function run() {
  const query = db.select().from(transactions).where(excludePureBankCategories).toSQL();
  console.log(query.sql);
  console.log(query.params);
  process.exit(0);
}
run();
