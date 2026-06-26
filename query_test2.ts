import { getMonthEndSummary } from "./src/lib/actions";

async function run() {
  const summary = await getMonthEndSummary(2);
  console.log(summary.costingByCategory);
  process.exit(0);
}

run();
