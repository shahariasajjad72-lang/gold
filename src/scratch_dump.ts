import postgres from 'postgres';

async function dump() {
  const sql = postgres("postgresql://neondb_owner:npg_Rcm6XMfzBS9x@ep-winter-cherry-a14bcu7m-pooler.ap-southeast-1.aws.neon.tech/neondb?sslmode=require&channel_binding=require");
  
  const allMonths = await sql`SELECT * FROM months`;
  console.log("--- ALL MONTHS ---");
  console.log(allMonths);
  
  await sql.end();
}

dump().catch(console.error);
