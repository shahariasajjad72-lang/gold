import postgres from 'postgres';

const sql = postgres("postgresql://postgres.obighzeelrsrxkhrvprf:e8UAuGU9jQtkNwNs@aws-1-ap-northeast-1.pooler.supabase.com:6543/postgres");

async function analyzeDescriptions() {
  const categories = await sql`SELECT DISTINCT category FROM transactions`;
  
  for (const c of categories) {
    const category = c.category;
    console.log(`\n--- ${category} ---`);
    
    const descriptions = await sql`
      SELECT description, count(*) as count 
      FROM transactions 
      WHERE category = ${category} 
        AND description IS NOT NULL 
        AND description != '' 
      GROUP BY description 
      ORDER BY count DESC 
      LIMIT 10
    `;
    
    if (descriptions.length === 0) {
      console.log('No frequent descriptions found.');
      continue;
    }
    
    descriptions.forEach(d => {
      console.log(`  - "${d.description}" (${d.count} times)`);
    });
  }
}

analyzeDescriptions().then(() => sql.end()).catch(console.error);
