import postgres from 'postgres';

const sql = postgres("postgresql://postgres.obighzeelrsrxkhrvprf:e8UAuGU9jQtkNwNs@aws-1-ap-northeast-1.pooler.supabase.com:6543/postgres");

async function analyzeAll() {
  const months = await sql`SELECT * FROM months ORDER BY year ASC, id ASC`;
  console.log(`Total Months found: ${months.length}`);
  
  for (const month of months) {
    console.log(`\n=================================================`);
    console.log(`Month: ${month.name} ${month.year} (ID: ${month.id})`);
    console.log(`Opening Balance: ${month.opening_balance}`);
    console.log(`Total Income (from month table): ${month.income}`);
    console.log(`Total Costing (from month table): ${month.costing}`);
    console.log(`Net Balance (Cash Closing): ${month.net_balance}`);

    const trans = await sql`SELECT type, count(*) as count, sum(amount) as total FROM transactions WHERE month_id = ${month.id} GROUP BY type`;
    console.log(`Transactions:`);
    let totalTrans = 0;
    trans.forEach(t => {
      console.log(`  - ${t.type.toUpperCase()}: ${t.count} entries, Total Amount: ${t.total}`);
      totalTrans += parseInt(t.count);
    });
    console.log(`  - Total Entries: ${totalTrans}`);

    // Let's find top categories
    const categories = await sql`SELECT category, count(*) as count, sum(amount) as total FROM transactions WHERE month_id = ${month.id} GROUP BY category ORDER BY count DESC LIMIT 3`;
    console.log(`  - Top Categories by frequency:`);
    categories.forEach(c => {
      console.log(`      * ${c.category}: ${c.count} times (Total: ${c.total})`);
    });
  }

  const globalBanks = await sql`SELECT * FROM global_banks`;
  console.log(`\n=================================================`);
  console.log(`Global Banks tracked: ${globalBanks.length}`);
  globalBanks.forEach(b => {
    console.log(`  - ${b.category} (Initial Balance: ${b.initial_balance})`);
  });

  const totalTransactionsCount = await sql`SELECT count(*) FROM transactions`;
  console.log(`\nTotal Transactions in Database: ${totalTransactionsCount[0].count}`);
}

analyzeAll().then(() => sql.end()).catch(console.error);
