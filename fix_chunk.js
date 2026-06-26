const fs = require('fs');
let code = fs.readFileSync('src/lib/actions.ts', 'utf8');

if (!code.includes('excludePureBankCategories = not(')) {
  code = code.replace(
`const PURE_BANK_CATEGORIES = [
  "ব্যাংক এর আবগারি শুল্ক",
  "ব্যাংক এর মাধ্যমে পেমেন্ট",
  "ব্যাংক হতে প্রাপ্ত লভ্যাংশ"
];`,
`const PURE_BANK_CATEGORIES = [
  "ব্যাংক এর আবগারি শুল্ক",
  "ব্যাংক এর মাধ্যমে পেমেন্ট",
  "ব্যাংক হতে প্রাপ্ত লভ্যাংশ"
];
const excludePureBankCategories = not(or(
  ...PURE_BANK_CATEGORIES.map(c => like(transactions.category, \`\${c}%\`))
));
`
  );
  fs.writeFileSync('src/lib/actions.ts', code);
}
