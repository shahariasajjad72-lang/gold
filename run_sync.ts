import { db } from "./src/db";
import { months } from "./src/db/schema";
// Since syncMonthTotals is not exported, we need to export it or just duplicate it here cleanly.
// Wait, actions.ts does not export syncMonthTotals. 
// Let's modify actions.ts to export it, then we can just call it!
import { syncMonthTotals } from "./src/lib/actions";

async function run() {
  const allMonths = await db.query.months.findMany();
  for (const m of allMonths) {
    console.log(`Syncing month ${m.id}`);
    await syncMonthTotals(m.id);
  }
  console.log("Done");
  process.exit(0);
}
run();
