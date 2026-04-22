import postgres from 'postgres';
const sql = postgres("postgresql://postgres.obighzeelrsrxkhrvprf:e8UAuGU9jQtkNwNs@aws-1-ap-northeast-1.pooler.supabase.com:6543/postgres");

async function fixBalances() {
  try {
    // 1. January (Month 1): Correct the 190k gap (200k expense missing, 10k income missing)
    await sql`
      INSERT INTO transactions (month_id, type, category, date, description, amount, weight)
      VALUES (1, 'costing', 'ব্যাংক এর মাধ্যমে পেমেন্ট (January-2026)', '2026-01-31 23:59:00', 'অ্যাডজাস্টমেন্ট (Bank Transfer clg Dr)', 200000, 0),
             (1, 'income', 'ব্যাংক হতে প্রাপ্ত লভ্যাংশ', '2026-01-31 23:59:00', 'অ্যাডজাস্টমেন্ট (Bank Benefit)', 10000, 0)
    `;

    // 2. February (Month 2): Correct the 5067 gap
    await sql`
      INSERT INTO transactions (month_id, type, category, date, description, amount, weight)
      VALUES (2, 'costing', 'ব্যাংক এর মাধ্যমে পেমেন্ট (February-2026)', '2026-02-28 23:59:00', 'অ্যাডজাস্টমেন্ট (Bank SMS/Fees)', 5067, 0)
    `;

    // 3. March (Month 3): Correct the 20k gap
    await sql`
      INSERT INTO transactions (month_id, type, category, date, description, amount, weight)
      VALUES (3, 'costing', 'ব্যাংক এর মাধ্যমে পেমেন্ট (March-2026)', '2026-03-31 23:59:00', 'অ্যাডজাস্টমেন্ট (Welfare Fund AC Transfer)', 20000, 0)
    `;

    console.log("Database entries inserted successfully.");
  } catch (err) {
    console.error("Error inserting transactions:", err);
  } finally {
    await sql.end();
  }
}

fixBalances();
