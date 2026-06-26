import { db } from "./src/db";
import { transactions } from "./src/db/schema";
import { eq, and } from "drizzle-orm";
async function run() {
  const trans = await db.query.transactions.findMany({
    where: and(eq(transactions.monthId, 2), eq(transactions.type, 'costing'))
  });
  console.log(trans.filter(t => t.category.includes('শুল্ক')));
  process.exit(0);
}
run();
