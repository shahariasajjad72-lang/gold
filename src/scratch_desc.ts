import postgres from 'postgres';

async function dump() {
  const sql = postgres("postgresql://postgres.obighzeelrsrxkhrvprf:e8UAuGU9jQtkNwNs@aws-1-ap-northeast-1.pooler.supabase.com:6543/postgres");
  
  // Find transactions with 'ব্যাংক' in category or description for the latest month
  const trans = await sql`
    SELECT category, amount, description, type 
    FROM transactions 
    ORDER BY id DESC 
    LIMIT 50
  `;

  console.log("--- RECENT TRANSACTIONS ---");
  trans.forEach(t => {
    console.log(`Cat: ${t.category} | Amt: ${t.amount} | Type: ${t.type} | Desc: ${t.description}`);
  });
  
  await sql.end();
}

dump().catch(console.error);
