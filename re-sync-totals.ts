// import { db } from './db';
// import { months, transactions } from './db/schema';
// import { eq, and, sql as drizzleSql, notInArray } from 'drizzle-orm';
// import { BANK_CATEGORIES } from './src/lib/constants';

// async function syncAll() {
//   const allMonths = await db.select().from(months);
//   for (const month of allMonths) {
//     const incomeResult = await db.select({
//       total: drizzleSql<number>`sum(${transactions.amount})`
//     })
//     .from(transactions)
//     .where(and(
//       eq(transactions.monthId, month.id),
//       eq(transactions.type, 'income'),
//       notInArray(transactions.category, BANK_CATEGORIES)
//     ));

//     const costingResult = await db.select({
//       total: drizzleSql<number>`sum(${transactions.amount})`
//     })
//     .from(transactions)
//     .where(and(
//       eq(transactions.monthId, month.id),
//       eq(transactions.type, 'costing'),
//       notInArray(transactions.category, BANK_CATEGORIES)
//     ));

//     const totalIncome = Number(incomeResult[0]?.total || 0);
//     const totalCosting = Number(costingResult[0]?.total || 0);

//     console.log(`Syncing month ${month.name} ${month.year}: Income ${totalIncome}, Costing ${totalCosting}`);
//     await db.update(months)
//       .set({ income: totalIncome, costing: totalCosting })
//       .where(eq(months.id, month.id));
//   }
// }

// syncAll().then(() => process.exit(0));
