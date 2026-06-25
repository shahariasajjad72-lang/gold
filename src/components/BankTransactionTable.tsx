'use client';

import { useState, useMemo, useEffect } from 'react';
import { 
  Plus, 
  Trash2, 
  Edit2, 
  Check, 
  X, 
  Calendar,
  Printer,
  ArrowUpRight,
  ArrowDownRight
} from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import { format } from 'date-fns';
import { cn } from '@/lib/utils';
import { addTransaction, updateTransaction, deleteTransaction } from '@/lib/actions';
import { useRouter } from 'next/navigation';
import { formatBanglaAmount, toBanglaNumeral } from '@/lib/utils/bangla-date';

interface Transaction {
  id: number;
  date: Date;
  description: string;
  amount: number;
  type: 'income' | 'costing';
  category: string;
}

interface BankTransactionTableProps {
  monthId: number;
  category: string;
  initialData: Transaction[];
  refreshData?: () => void;
}

export default function BankTransactionTable({ 
  monthId, 
  category, 
  initialData,
  refreshData
}: BankTransactionTableProps) {
  const router = useRouter();
  const [data, setData] = useState<Transaction[]>(initialData);
  const [editingId, setEditingId] = useState<number | null>(null);

  const handlePrint = () => {
    const printWindow = window.open('', '_blank');
    if (!printWindow) return;

    const companyName = "বাংলা গোল্ড (প্রাঃ) লিমিটেড";
    const reportTitle = `${category} - ব্যাংক লেজার (Bank Ledger Record)`;
    const reportSubtitle = "আর্থিক লেনদেন ও স্থিতি প্রতিবেদন";

    const content = `
      <!DOCTYPE html>
      <html>
        <head>
          <title>${category} Ledger</title>
          <style>
            @import url('https://fonts.googleapis.com/css2?family=Hind+Siliguri:wght@300;400;500;600;700&display=swap');
            
            @page {
              size: A4;
              margin: 15mm;
            }
            
            body {
              font-family: 'Hind Siliguri', sans-serif;
              color: #1a1a1a;
              line-height: 1.4;
              margin: 0;
              padding: 0;
            }
            
            .header {
              text-align: center;
              margin-bottom: 30px;
              border-bottom: 2px solid #000;
              padding-bottom: 15px;
            }
            
            .company-name {
              font-size: 32px;
              font-weight: 900;
              margin: 0;
              color: #000;
            }
            
            .report-title {
              font-size: 20px;
              font-weight: 700;
              margin: 5px 0;
              color: #444;
            }
            
            .report-subtitle {
              font-size: 14px;
              font-weight: 600;
              text-transform: uppercase;
              letter-spacing: 2px;
              color: #666;
            }
            
            table {
              width: 100%;
              border-collapse: collapse;
              margin-top: 20px;
            }
            
            th {
              background-color: #f4f4f4;
              border: 1px solid #ddd;
              padding: 10px 8px;
              font-size: 11px;
              font-weight: 900;
              text-align: left;
              text-transform: uppercase;
            }
            
            td {
              border: 1px solid #ddd;
              padding: 10px 8px;
              font-size: 13px;
              font-weight: 600;
            }
            
            .amount-col { text-align: right; width: 100px; }
            .date-col { width: 90px; }
            .type-col { width: 80px; text-align: center; }
            
            .total-row {
              background-color: #f8f8f8;
              font-weight: 900;
            }
            
            .total-label {
              text-align: right;
              padding-right: 15px;
              font-size: 14px;
            }
            
            .total-amount {
              text-align: right;
              font-size: 15px;
            }
            
            .balance-row {
              background-color: #efefff;
              font-weight: 900;
              color: #2563eb;
            }

            .balance-amount {
              font-size: 18px;
              text-align: right;
            }
            
            .footer {
              margin-top: 50px;
              display: flex;
              justify-content: space-between;
              font-weight: 700;
              font-size: 12px;
            }
            
            .signature-box {
              border-top: 1px solid #000;
              width: 150px;
              text-align: center;
              padding-top: 5px;
            }

            .print-time {
              font-size: 10px;
              color: #999;
              margin-top: 40px;
              text-align: right;
            }
          </style>
        </head>
        <body>
          <div class="header">
            <h1 class="company-name">${companyName}</h1>
            <div class="report-title">${reportTitle}</div>
            <div class="report-subtitle">${reportSubtitle}</div>
          </div>
          
          <table>
            <thead>
              <tr>
                <th class="date-col">তারিখ (Date)</th>
                <th>বিবরণ (Description)</th>
                <th class="type-col">ধরন (Type)</th>
                <th class="amount-col">ডেবিট (DR)</th>
                <th class="amount-col">ক্রেডিট (CR)</th>
                <th class="amount-col">ব্যালেন্স</th>
              </tr>
            </thead>
            <tbody>
              ${processedData.map(item => `
                <tr>
                  <td>${toBanglaNumeral(format(new Date(item.date), 'dd-MM-yyyy'))}</td>
                  <td>${item.description}</td>
                  <td class="type-col">${item.type === 'income' ? 'জমা' : 'উত্তোলন'}</td>
                  <td class="amount-col" style="color: #e11d48">${item.type === 'costing' ? formatBanglaAmount(item.amount) : '-'}</td>
                  <td class="amount-col" style="color: #059669">${item.type === 'income' ? formatBanglaAmount(item.amount) : '-'}</td>
                  <td class="amount-col" style="font-weight: 900">৳ ${formatBanglaAmount(item.balance)}</td>
                </tr>
              `).join('')}
            </tbody>
            <tfoot>
              <tr class="total-row">
                <td colspan="3" class="total-label">সর্বমোট হিসাব (Total Analysis)</td>
                <td class="total-amount" style="color: #e11d48">${formatBanglaAmount(totalDebit)}</td>
                <td class="total-amount" style="color: #059669">${formatBanglaAmount(totalCredit)}</td>
                <td></td>
              </tr>
              <tr class="balance-row">
                <td colspan="4" class="total-label">চূড়ান্ত স্থিতি (Final Net Balance)</td>
                <td colspan="2" class="balance-amount">৳ ${formatBanglaAmount(totalCredit - totalDebit)}</td>
              </tr>
            </tfoot>
          </table>
          
          <div class="footer">
            <div class="signature-box">হিসাব রক্ষক</div>
            <div class="signature-box">ব্যবস্থাপক (ব্যাংক)</div>
          </div>

          <div class="print-time">প্রিন্ট সময়: ${new Date().toLocaleString('bn-BD')}</div>
          
          <script>
            window.onload = () => {
              window.print();
              setTimeout(() => { window.close(); }, 500);
            };
          </script>
        </body>
      </html>
    `;

    printWindow.document.write(content);
    printWindow.document.close();
  };

  useEffect(() => {
    // Sort data by date ascending for balance calculation
    const sorted = [...initialData].sort((a, b) => new Date(a.date).getTime() - new Date(b.date).getTime());
    setData(sorted);
  }, [initialData]);

  // Derived data with running balance and totals
  const { processedData, totalDebit, totalCredit } = useMemo(() => {
    let currentBalance = 0;
    let tDebit = 0;
    let tCredit = 0;
    
    const processed = data.map(item => {
      if (item.type === 'income') {
        currentBalance += item.amount;
        tCredit += item.amount;
      } else {
        currentBalance -= item.amount;
        tDebit += item.amount;
      }
      return { ...item, balance: currentBalance };
    });

    return { processedData: processed, totalDebit: tDebit, totalCredit: tCredit };
  }, [data]);

  // New row state
  const [newType, setNewType] = useState<'income' | 'costing'>('income');
  const [newDate, setNewDate] = useState(format(new Date(), 'yyyy-MM-dd'));
  const [newDesc, setNewDesc] = useState('');
  const [newAmount, setNewAmount] = useState('');

  // Editing state
  const [editType, setEditType] = useState<'income' | 'costing'>('income');
  const [editDate, setEditDate] = useState('');
  const [editDesc, setEditDesc] = useState('');
  const [editAmount, setEditAmount] = useState('');

  const handleAdd = async () => {
    if (!newAmount) return;

    const res = await addTransaction({
      monthId,
      type: newType,
      category,
      date: new Date(newDate),
      description: newDesc || category,
      amount: parseInt(newAmount),
    });

    if (res.success) {
      if (refreshData) refreshData();
      router.refresh();
      setNewDesc('');
      setNewAmount('');
    }
  };

  const handleSaveEdit = async (id: number) => {
    const res = await updateTransaction(id, monthId, {
      description: editDesc,
      amount: parseInt(editAmount),
      date: new Date(editDate),
      type: editType,
    });

    if (res.success) {
      if (refreshData) refreshData();
      setEditingId(null);
      router.refresh();
    }
  };

  const handleDelete = async (id: number) => {
    if (!confirm('Are you sure you want to delete this entry?')) return;
    const res = await deleteTransaction(id, monthId);
    if (res.success) {
      if (refreshData) refreshData();
      router.refresh();
    }
  };

  const startEditing = (item: Transaction) => {
    setEditingId(item.id);
    setEditType(item.type);
    setEditDate(format(new Date(item.date), 'yyyy-MM-dd'));
    setEditDesc(item.description);
    setEditAmount(item.amount.toString());
  };

  return (
    <div className="space-y-6">
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 no-print border-b border-border pb-6">
        <div>
          <h2 className="text-xl lg:text-4xl font-black tracking-tight text-foreground uppercase italic">{category}</h2>
          <p className="text-xs lg:text-sm text-muted-foreground font-bold mt-1 uppercase tracking-[0.2em] italic opacity-60">Bank Ledger & Balance Registry</p>
        </div>
        <button 
          onClick={handlePrint}
          className="flex items-center justify-center gap-2 px-5 py-2.5 rounded-xl bg-white dark:bg-black border border-border hover:border-foreground text-xs font-bold transition-all shadow-sm group"
        >
          <Printer className="w-4 h-4 text-muted-foreground group-hover:text-foreground transition-colors" />
          Print Ledger
        </button>
      </div>

      <div className="w-full bg-white dark:bg-[#0a0a0a] rounded-[24px] lg:rounded-[32px] border-2 border-blue-100 dark:border-blue-900/30 shadow-[0_8px_30px_rgb(0,0,0,0.04)] dark:shadow-none overflow-hidden text-foreground transition-all">
        <div className="overflow-x-auto custom-scrollbar">
          <table className="w-full text-left border-collapse print-table">
            <thead>
              <tr className="border-b-2 border-border/50 bg-blue-50/50 dark:bg-blue-950/20 transition-colors">
                <th className="px-5 lg:px-8 py-4 lg:py-5 text-[10px] lg:text-[12px] font-black uppercase tracking-[0.2em] text-muted-foreground border-r border-border/30 w-36 lg:w-48">তারিখ (Date)</th>
                <th className="px-5 lg:px-8 py-4 lg:py-5 text-[10px] lg:text-[12px] font-black uppercase tracking-[0.2em] text-muted-foreground border-r border-border/30">বিবরণ (Description)</th>
                <th className="px-5 lg:px-8 py-4 lg:py-5 text-[10px] lg:text-[12px] font-black uppercase tracking-[0.2em] text-muted-foreground border-r border-border/30 w-32 lg:w-44 text-center">ধরন (Type)</th>
                <th className="px-5 lg:px-8 py-4 lg:py-5 text-[10px] lg:text-[12px] font-black uppercase tracking-[0.2em] text-muted-foreground border-r border-border/30 w-40 lg:w-48 text-right">ডেবিট (Debit)</th>
                <th className="px-5 lg:px-8 py-4 lg:py-5 text-[10px] lg:text-[12px] font-black uppercase tracking-[0.2em] text-muted-foreground border-r border-border/30 w-40 lg:w-48 text-right">ক্রেডিট (Credit)</th>
                <th className="px-5 lg:px-8 py-4 lg:py-5 text-[10px] lg:text-[12px] font-black uppercase tracking-[0.2em] text-muted-foreground w-28 text-center no-print">অ্যাকশন</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-border/50">
              <AnimatePresence mode="popLayout" initial={false}>
                {processedData.map((item, index) => (
                  <motion.tr 
                    key={item.id}
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    exit={{ opacity: 0 }}
                    className={cn(
                      "transition-colors group",
                      index % 2 === 0 ? "bg-white dark:bg-black" : "bg-slate-50/40 dark:bg-zinc-900/40"
                    )}
                  >
                    <td className="px-5 py-4 border-r border-border/30">
                      {editingId === item.id ? (
                        <input 
                          type="date" 
                          value={editDate}
                          onChange={(e) => setEditDate(e.target.value)}
                          className="w-full bg-background border border-border rounded-lg px-2 py-1.5 text-xs outline-none"
                        />
                      ) : (
                        <span className="text-xs lg:text-base font-bold font-mono tracking-tighter text-slate-600 dark:text-slate-400">{toBanglaNumeral(format(new Date(item.date), 'dd-MM-yyyy'))}</span>
                      )}
                    </td>
                    <td className="px-5 py-4 border-r border-border/30">
                      {editingId === item.id ? (
                        <input 
                          type="text" 
                          value={editDesc}
                          onChange={(e) => setEditDesc(e.target.value)}
                          className="w-full bg-background border border-border rounded-lg px-3 py-1.5 text-sm font-semibold outline-none"
                        />
                      ) : (
                        <span className="text-sm lg:text-xl font-bold tracking-tight text-slate-700 dark:text-slate-200">{item.description}</span>
                      )}
                    </td>
                    <td className="px-5 py-4 border-r border-border/30">
                      {editingId === item.id ? (
                        <select 
                          value={editType} 
                          onChange={(e) => setEditType(e.target.value as 'income' | 'costing')}
                          className="w-full bg-background border border-border rounded-lg px-2 py-1.5 text-xs outline-none"
                        >
                            <option value="income">Credit (জমা)</option>
                            <option value="costing">Debit (উত্তোলন)</option>
                        </select>
                      ) : (
                        <span className={cn(
                          "text-[10px] uppercase font-black px-2 py-1 rounded-md",
                          item.type === 'income' ? "bg-emerald-100 text-emerald-700" : "bg-rose-100 text-rose-700"
                        )}>
                          {item.type === 'income' ? 'জমা (CR)' : 'উত্তোলন (DR)'}
                        </span>
                      )}
                    </td>
                    <td className="px-5 py-4 border-r border-border/30 text-rose-600 font-black text-right">
                      {editingId === item.id ? (
                        <div className="flex flex-col gap-1">
                          <input 
                            type="number" 
                            value={editAmount}
                            onChange={(e) => setEditAmount(e.target.value)}
                            className="w-full bg-background border border-border rounded-lg px-2 py-1 text-sm outline-none"
                          />
                        </div>
                      ) : (
                        item.type === 'costing' ? <span className="text-base lg:text-2xl tracking-tighter">৳ {formatBanglaAmount(item.amount)}</span> : '-'
                      )}
                    </td>
                    <td className="px-5 py-4 border-r border-border/30 text-emerald-600 font-black text-right">
                       {editingId === item.id ? (
                        <span className="text-[10px] opacity-40 italic">Linked to Amount</span>
                       ) : (
                        item.type === 'income' ? <span className="text-base lg:text-2xl tracking-tighter">৳ {formatBanglaAmount(item.amount)}</span> : '-'
                       )}
                    </td>
                    <td className="px-5 py-4 text-center no-print">
                      <div className="flex items-center justify-center gap-1.5">
                        {editingId === item.id ? (
                          <>
                            <button onClick={() => handleSaveEdit(item.id)} className="p-2 rounded-xl bg-slate-900 text-white dark:bg-white dark:text-black hover:opacity-80 transition-opacity">
                              <Check className="w-4 h-4" />
                            </button>
                            <button onClick={() => setEditingId(null)} className="p-2 rounded-xl border border-border hover:bg-muted transition-colors">
                              <X className="w-4 h-4" />
                            </button>
                          </>
                        ) : (
                          <>
                            <button onClick={() => startEditing(item)} className="p-2 rounded-xl text-muted-foreground hover:text-slate-900 dark:hover:text-white hover:bg-slate-100 dark:hover:bg-zinc-800 transition-colors">
                              <Edit2 className="w-4 h-4" />
                            </button>
                            <button onClick={() => handleDelete(item.id)} className="p-2 rounded-xl text-muted-foreground hover:text-rose-500 hover:bg-rose-50 dark:hover:bg-rose-500/10 transition-colors">
                              <Trash2 className="w-4 h-4" />
                            </button>
                          </>
                        )}
                      </div>
                    </td>
                  </motion.tr>
                ))}
              </AnimatePresence>

              {/* Add New Row */}
              <tr className="no-print border-t-2 border-border/80 shadow-[inset_0_2px_10px_rgba(0,0,0,0.02)] bg-blue-50/40 dark:bg-blue-950/20">
                <td className="px-5 py-5 border-r border-border/30">
                  <input 
                    type="date" 
                    value={newDate}
                    onChange={(e) => setNewDate(e.target.value)}
                    className="w-full bg-white dark:bg-zinc-900 border border-border rounded-xl px-4 py-3 text-sm font-mono font-bold outline-none focus:ring-2 focus:ring-primary/20 transition-all"
                  />
                </td>
                <td className="px-5 py-5 border-r border-border/30">
                  <input 
                    type="text" 
                    placeholder="Entry details..."
                    value={newDesc}
                    onChange={(e) => setNewDesc(e.target.value)}
                    className="w-full bg-white dark:bg-zinc-900 border border-border rounded-xl px-4 py-3 text-sm font-bold outline-none focus:ring-2 focus:ring-primary/20 transition-all placeholder:text-muted-foreground/50"
                  />
                </td>
                <td className="px-5 py-5 border-r border-border/30">
                  <select 
                    value={newType} 
                    onChange={(e) => setNewType(e.target.value as 'income' | 'costing')}
                    className="w-full bg-white dark:bg-zinc-900 border border-border rounded-xl px-2 py-3 text-xs font-bold focus:ring-2 focus:ring-primary/20 transition-all"
                  >
                      <option value="income">Credit (জমা)</option>
                      <option value="costing">Debit (উত্তোলন)</option>
                  </select>
                </td>
                <td colSpan={2} className="px-5 py-5 border-r border-border/30">
                  <div className="relative group">
                    <span className="absolute left-4 top-1/2 -translate-y-1/2 text-sm font-black text-muted-foreground group-focus-within:text-foreground transition-colors">৳</span>
                    <input 
                      type="number" 
                      placeholder="Amount..."
                      value={newAmount}
                      onChange={(e) => setNewAmount(e.target.value)}
                      className="w-full bg-white dark:bg-zinc-900 border border-border rounded-xl pl-8 pr-4 py-3 text-sm font-black outline-none focus:ring-2 focus:ring-primary/20 transition-all text-right placeholder:text-muted-foreground/50"
                    />
                  </div>
                </td>
                <td className="px-5 py-5 text-center no-print">
                  <button 
                    onClick={handleAdd}
                    disabled={!newAmount}
                    className="flex items-center justify-center w-full py-3 rounded-xl bg-blue-600 hover:bg-blue-700 shadow-blue-600/20 text-white font-black text-[11px] uppercase tracking-[0.2em] disabled:opacity-30 transition-all shadow-md active:scale-95"
                  >
                    <Plus className="w-4 h-4 mr-1" strokeWidth={3} />
                    Add
                  </button>
                </td>
              </tr>
            </tbody>
            <tfoot>
              {/* Row 1: Totals */}
              <tr className="border-t-2 border-border h-24 bg-blue-50/50 dark:bg-blue-950/40 transition-colors">
                <td colSpan={3} className="px-5 lg:px-8 py-0 border-r border-border/20 text-right">
                  <div className="flex flex-col">
                    <span className="text-[10px] font-black text-muted-foreground uppercase tracking-[0.3em] mb-1 italic opacity-50">Aggregate Total</span>
                    <span className="text-sm lg:text-lg font-black uppercase tracking-tighter text-blue-700 dark:text-blue-400">
                      মোট হিসাব (Totals)
                    </span>
                  </div>
                </td>
                <td className="px-5 lg:px-8 py-0 text-2xl lg:text-4xl font-black text-rose-600 border-r border-border/20 text-right tracking-tighter">
                  ৳ {formatBanglaAmount(totalDebit)}
                </td>
                <td className="px-5 lg:px-8 py-0 text-2xl lg:text-4xl font-black text-emerald-600 border-r border-border/20 text-right tracking-tighter">
                  ৳ {formatBanglaAmount(totalCredit)}
                </td>
                <td className="no-print"></td>
              </tr>
              {/* Row 2: Balance */}
              <tr className="h-16 bg-blue-100/50 dark:bg-blue-900/30 border-t border-border/30">
                <td colSpan={4} className="px-5 lg:px-8 py-0 border-r border-border/20 text-right">
                    <span className="text-xs lg:text-sm font-black uppercase tracking-[0.2em] text-blue-600/70 dark:text-blue-400/70">Net Balance</span>
                </td>
                <td className="px-5 lg:px-8 py-0 text-3xl lg:text-5xl font-black text-blue-600 tracking-tighter text-right">
                   ৳ {formatBanglaAmount(totalCredit - totalDebit)}
                </td>
                <td className="no-print"></td>
              </tr>
            </tfoot>
          </table>
        </div>
      </div>
    </div>
  );
}
