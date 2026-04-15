export const BANGLA_MONTHS: { [key: string]: string } = {
  January: 'জানুয়ারি',
  February: 'ফেব্রুয়ারি',
  March: 'মার্চ',
  April: 'এপ্রিল',
  May: 'মে',
  June: 'জুন',
  July: 'জুলাই',
  August: 'আগস্ট',
  September: 'সেপ্টেম্বর',
  October: 'অক্টোবর',
  November: 'নভেম্বর',
  December: 'ডিসেম্বর',
};

export const BANGLA_NUMERALS: { [key: string]: string } = {
  '0': '০',
  '1': '১',
  '2': '২',
  '3': '৩',
  '4': '৪',
  '5': '৫',
  '6': '৬',
  '7': '৭',
  '8': '৮',
  '9': '৯',
};

export function toBanglaNumeral(n: number | string): string {
  if (n === null || n === undefined) return '';
  return n.toString().split('').map(char => BANGLA_NUMERALS[char] || char).join('');
}

export function formatBanglaAmount(amount: number): string {
  // Format as English first (with commas and decimals)
  const englishFormatted = amount.toLocaleString('en-US', {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  });
  
  // Convert Each digit to Bangla
  return toBanglaNumeral(englishFormatted);
}

export function formatBanglaDate(date: Date): string {
  const day = date.getDate();
  const month = date.toLocaleString('en-US', { month: 'long' });
  const year = date.getFullYear();

  const banglaMonth = BANGLA_MONTHS[month] || month;
  const banglaDay = toBanglaNumeral(day);

  return `${banglaDay} ${banglaMonth}, ${year}`;
}
