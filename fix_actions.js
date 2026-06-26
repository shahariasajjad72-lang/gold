const fs = require('fs');

let content = fs.readFileSync('src/lib/actions.ts', 'utf8');

// Remove the BANK_SIDE_CATEGORIES array definition completely
content = content.replace(/    const BANK_SIDE_CATEGORIES = \[\s*"ব্যাংক এ যাবতীয় জমা",\s*"ব্যাংক এর আবগারি শুল্ক",\s*"ব্যাংক এর মাধ্যমে পেমেন্ট",\s*"ব্যাংক হতে প্রাপ্ত লভ্যাংশ"\s*\];\n?/g, '');

// Remove the notInArray lines
content = content.replace(/\s*notInArray\(transactions\.category, BANK_SIDE_CATEGORIES\),?/g, '');

fs.writeFileSync('src/lib/actions.ts', content);
