import { getMonthEndSummary } from "./src/lib/actions";
import { BANK_CATEGORIES } from "./src/lib/constants";

async function run() {
  const summary = await getMonthEndSummary(5); // May is month 5
  const month = summary.month;
  
  const totalIncome = Object.values(summary.incomeByCategory || {}).reduce((s: number, v) => s + (v as number), 0);
  const totalCosting = Object.entries(summary.costingByCategory || {}).reduce((s: number, [cat, val]) => {
    if (cat === "ব্যাংক এ যাবতীয় জমা") return s;
    return s + (val as number);
  }, 0);
  
  const openingBankBalance = BANK_CATEGORIES.reduce((s, c) => s + (summary.bankCalculated?.[c]?.opening || 0), 0);
  const closingBankBalance = BANK_CATEGORIES.reduce((s, c) => s + (summary.bankCalculated?.[c]?.closing || 0), 0);

  const cashInitial = month.openingBalance || 0;
  const cashClosing = month.netBalance || 0;
  
  const grandTotalIncome = totalIncome + (openingBankBalance + cashInitial);
  const grandTotalCosting = totalCosting + (closingBankBalance + cashClosing);

  console.log({
    monthId: month.id,
    monthName: month.name,
    totalIncome,
    totalCosting,
    openingBankBalance,
    closingBankBalance,
    cashInitial,
    cashClosing,
    grandTotalIncome,
    grandTotalCosting,
    gap: grandTotalIncome - grandTotalCosting
  });
  
  process.exit(0);
}

run();
