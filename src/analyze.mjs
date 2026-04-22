import postgres from 'postgres';
const sql = postgres("postgresql://postgres.obighzeelrsrxkhrvprf:e8UAuGU9jQtkNwNs@aws-1-ap-northeast-1.pooler.supabase.com:6543/postgres");

async function analyze() {
  const monthId = 2; // February
  const trans = await sql`SELECT * FROM transactions WHERE month_id = ${monthId}`;
  
  const bankCats = [
    "প্রভিডেন্ট ফান্ড (আল - আরাফা ইসলামী ব্যাংক) শেখের বাজার",
    "ওয়েলফেয়ার ফান্ড (আল - আরাফা ইসলামী ব্যাংক) শেখের বাজার",
    "আল - আরাফা ইসলামী ব্যাংক (শেখের বাজার)",
    "আল - আরাফা ইসলামী ব্যাংক (নবাবপুর শাখা)",
    "প্রিমিয়ার ব্যাংক",
    "ঢাকা ব্যাংক",
  ];

  let bankIncome = 0;
  let bankCosting = 0;
  let regularIncome = 0;
  let regularCosting = 0;
  let bankDepositCosting = 0; 
  let salaryCosting = 0;

  trans.forEach(t => {
    if (bankCats.includes(t.category)) {
      if (t.type === 'income') bankIncome += t.amount;
      else bankCosting += t.amount;
    } else if (t.category.includes("ব্যাংক এ যাবতীয় জমা")) {
      bankDepositCosting += t.amount;
    } else if (t.category.includes("পরিচালকগণের সম্মানী প্রদান (ব্যাংক)") || t.category.includes("স্টাফদের বেতন প্রধান (ব্যাংক)")) {
      salaryCosting += t.amount;
    } else {
      if (t.type === 'income') regularIncome += t.amount;
      else regularCosting += t.amount;
    }
  });

  console.log(`--- MARCH BALANCE CHECK ---`);
  console.log(`Regular Income: ${regularIncome}`);
  console.log(`Regular Costing (No salaries): ${regularCosting}`);
  console.log(`Bank Salaries (Month End only): ${salaryCosting}`);
  console.log(`Bank Deposits (Daily only): ${bankDepositCosting}`);
  console.log(`Bank Direct Income (Add to Bank): ${bankIncome}`);
  console.log(`Bank Direct Costing (Sub from Bank): ${bankCosting}`);
  
  // Total Income listed on left
  const totalLeftIncome = regularIncome; 
  // Total Costing listed on right 
  const totalRightCosting = regularCosting + salaryCosting;
  
  console.log(`\nListed Income: ${totalLeftIncome}`);
  console.log(`Listed Costing: ${totalRightCosting}`);

  const month = await sql`SELECT * FROM months WHERE id = ${monthId}`;
  console.log(`\nCash Opening: ${month[0].opening_balance}`);
  console.log(`Cash Closing (Net Balance): ${month[0].net_balance}`);

  const cashDiff = month[0].opening_balance + totalLeftIncome - (regularCosting + bankDepositCosting) - month[0].net_balance;
  console.log(`Cash internal discrepancy?: ${cashDiff} (should be 0)`);
}

analyze().then(() => sql.end());
