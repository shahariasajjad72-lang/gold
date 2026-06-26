const fs = require('fs');
let code = fs.readFileSync('src/lib/actions.ts', 'utf8');

const bankCategoriesDef = `
const PURE_BANK_CATEGORIES = [
  "ব্যাংক এর আবগারি শুল্ক",
  "ব্যাংক এর মাধ্যমে পেমেন্ট",
  "ব্যাংক হতে প্রাপ্ত লভ্যাংশ"
];
`;

if (!code.includes('PURE_BANK_CATEGORIES')) {
  code = code.replace(/import { revalidatePath } from "next\/cache";/, "import { revalidatePath } from \"next/cache\";\n" + bankCategoriesDef);
}

// Add notInArray for PURE_BANK_CATEGORIES right after BANK_CATEGORIES
code = code.replace(/notInArray\(transactions\.category, BANK_CATEGORIES\),/g, 
  "notInArray(transactions.category, BANK_CATEGORIES),\n      notInArray(transactions.category, PURE_BANK_CATEGORIES),");

fs.writeFileSync('src/lib/actions.ts', code);
