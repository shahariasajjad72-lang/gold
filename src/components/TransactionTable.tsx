'use client';

import { useState, useMemo, useEffect } from 'react';
import { 
  Plus, 
  Trash2, 
  Edit2, 
  Check, 
  X, 
  Calendar,
  Printer
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
  weight: string | null;
}

interface TransactionTableProps {
  monthId: number;
  category: string;
  type: 'income' | 'costing';
  initialData: Transaction[];
  showWeight?: boolean;
  refreshData?: () => void;
}

export default function TransactionTable({ 
  monthId, 
  category, 
  type, 
  initialData,
  showWeight = false,
  refreshData
}: TransactionTableProps) {
  const router = useRouter();
  const [data, setData] = useState<Transaction[]>(initialData);
  const [isAdding, setIsAdding] = useState(false);
  const [editingId, setEditingId] = useState<number | null>(null);

  const handlePrint = () => {
    const printWindow = window.open('', '_blank');
    if (!printWindow) return;

    const companyName = "বাংলা গোল্ড (প্রাঃ) লিমিটেড";
    const reportTitle = `${category} - ${type === 'income' ? 'আয় এর বিবরণ' : 'ব্যয় এর বিবরণ'}`;
    const reportSubtitle = "আর্থিক লেনদেন প্রতিবেদন";

    const content = `
      <!DOCTYPE html>
      <html>
        <head>
          <title>${category} Report</title>
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
              font-size: 12px;
              font-weight: 900;
              text-align: left;
              text-transform: uppercase;
            }
            
            td {
              border: 1px solid #ddd;
              padding: 10px 8px;
              font-size: 14px;
              font-weight: 600;
            }
            
            .amount-col { text-align: right; width: 120px; }
            .date-col { width: 100px; }
            .weight-col { width: 100px; }
            
            .total-row {
              background-color: #f8f8f8;
              font-weight: 900;
            }
            
            .total-label {
              text-align: right;
              padding-right: 15px;
              font-size: 16px;
            }
            
            .total-amount {
              text-align: right;
              font-size: 18px;
              color: ${type === 'income' ? '#059669' : '#e11d48'};
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
                ${showWeight ? '<th class="weight-col">ওজন (Weight)</th>' : ''}
                <th class="amount-col">টাকা (Amount)</th>
              </tr>
            </thead>
            <tbody>
              ${data.map(item => `
                <tr>
                  <td>${toBanglaNumeral(format(new Date(item.date), 'dd-MM-yyyy'))}</td>
                  <td>${item.description}</td>
                  ${showWeight ? `<td>${toBanglaNumeral(Number(item.weight || 0).toFixed(2))} G</td>` : ''}
                  <td class="amount-col">৳ ${formatBanglaAmount(item.amount)}</td>
                </tr>
              `).join('')}
            </tbody>
            <tfoot>
              <tr class="total-row">
                <td colspan="${showWeight ? 3 : 2}" class="total-label">সর্বমোট ${type === 'income' ? 'আয়' : 'ব্যয়'} (Total ${type === 'income' ? 'Income' : 'Costing'})</td>
                <td class="total-amount">৳ ${formatBanglaAmount(totalAmount)}</td>
              </tr>
            </tfoot>
          </table>
          
          <div class="footer">
            <div class="signature-box">হিসাব রক্ষক</div>
            <div class="signature-box">পরিচালক স্বাক্ষর</div>
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

  // Sync state with props for reload-free navigation
  useEffect(() => {
    setData(initialData);
  }, [initialData]);

  // New row state
  const [newDate, setNewDate] = useState(format(new Date(), 'yyyy-MM-dd'));
  const [newDesc, setNewDesc] = useState('');
  const [newAmount, setNewAmount] = useState('');
  const [newWeight, setNewWeight] = useState('');

  // Editing state
  const [editDate, setEditDate] = useState('');
  const [editDesc, setEditDesc] = useState('');
  const [editAmount, setEditAmount] = useState('');
  const [editWeight, setEditWeight] = useState('');

  const totalAmount = useMemo(() => {
    return data.reduce((sum, item) => sum + Number(item.amount), 0);
  }, [data]);

  const totalWeight = useMemo(() => {
    return data.reduce((sum, item) => sum + Number(item.weight || 0), 0);
  }, [data]);

  const handleAdd = async () => {
    if (!newAmount) return;

    const res = await addTransaction({
      monthId,
      type,
      category,
      date: new Date(newDate),
      description: newDesc || category,
      amount: parseInt(newAmount),
      weight: showWeight ? newWeight : undefined,
    });

    if (res.success) {
      if (refreshData) refreshData();
      router.refresh();
      setNewDesc('');
      setNewAmount('');
      setNewWeight('');
      setIsAdding(false);
    }
  };

  const handleSaveEdit = async (id: number) => {
    const res = await updateTransaction(id, monthId, {
      description: editDesc,
      amount: parseInt(editAmount),
      date: new Date(editDate),
      weight: showWeight ? editWeight : undefined,
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
    setEditDate(format(new Date(item.date), 'yyyy-MM-dd'));
    setEditDesc(item.description);
    setEditAmount(item.amount.toString());
    setEditWeight(item.weight || '');
  };

  return (
    <div className="space-y-6">
      {/* Header Info & Print Action */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 no-print border-b border-border pb-6">
        <div>
          <h2 className="text-xl lg:text-4xl font-black tracking-tight text-foreground uppercase italic">{category}</h2>
          <p className="text-xs lg:text-sm text-muted-foreground font-bold mt-1 uppercase tracking-[0.2em] italic opacity-60">Financial Transaction Registry</p>
        </div>
        <button 
          onClick={handlePrint}
          className="flex items-center justify-center gap-2 px-5 py-2.5 rounded-xl bg-white dark:bg-black border border-border hover:border-foreground text-xs font-bold transition-all shadow-sm group"
        >
          <Printer className="w-4 h-4 text-muted-foreground group-hover:text-foreground transition-colors" />
          Print Report
        </button>
      </div>

      <div className={cn(
        "w-full bg-white dark:bg-black rounded-xl border shadow-sm overflow-hidden text-foreground transition-all",
        type === 'income' ? "border-emerald-500/20 shadow-emerald-500/5" : "border-rose-500/20 shadow-rose-500/5"
      )}>
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse print-table">
            <thead>
              <tr className={cn(
                "border-b border-border transition-colors",
                type === 'income' ? "bg-emerald-50/50 dark:bg-emerald-950/20" : "bg-rose-50/50 dark:bg-rose-950/20"
              )}>
                <th className="px-5 lg:px-8 py-4 lg:py-6 text-[11px] lg:text-[14px] font-black uppercase tracking-wider text-slate-500 border-r border-border/50 w-40 lg:w-56">তারিখ (Date)</th>
                <th className="px-5 lg:px-8 py-4 lg:py-6 text-[11px] lg:text-[14px] font-black uppercase tracking-wider text-slate-500 border-r border-border/50">বিবরণ (Description)</th>
                {showWeight && <th className="px-5 lg:px-8 py-4 lg:py-6 text-[11px] lg:text-[14px] font-black uppercase tracking-wider text-slate-500 border-r border-border/50 w-32 lg:w-48">ওজন (Weight)</th>}
                <th className="px-5 lg:px-8 py-4 lg:py-6 text-[11px] lg:text-[14px] font-black uppercase tracking-wider text-slate-500 border-r border-border/50 w-48 lg:w-64">টাকা (Amount)</th>
                <th className="px-5 lg:px-8 py-4 lg:py-6 text-[11px] lg:text-[14px] font-black uppercase tracking-wider text-slate-500 w-28 text-right no-print">অ্যাকশন</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-border/50">
              <AnimatePresence mode="popLayout" initial={false}>
                {data.map((item, index) => (
                  <motion.tr 
                    key={item.id}
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    exit={{ opacity: 0 }}
                    className={cn(
                      "transition-colors group",
                      index % 2 === 0 ? "bg-white dark:bg-black" : "bg-slate-50/20 dark:bg-zinc-900/20",
                      type === 'income' ? "hover:bg-emerald-50/30 dark:hover:bg-emerald-900/10" : "hover:bg-rose-50/30 dark:hover:bg-rose-900/10"
                    )}
                  >
                    <td className="px-5 py-4 border-r border-border/30">
                      {editingId === item.id ? (
                        <input 
                          type="date" 
                          value={editDate}
                          onChange={(e) => setEditDate(e.target.value)}
                          className="w-full bg-background border border-border rounded-lg px-2 py-1.5 text-xs outline-none focus:ring-1 focus:ring-primary/20"
                        />
                      ) : (
                        <span className="text-xs lg:text-base font-bold text-slate-600 dark:text-slate-400 font-mono tracking-tighter">{toBanglaNumeral(format(new Date(item.date), 'dd-MM-yyyy'))}</span>
                      )}
                    </td>
                    <td className="px-5 py-4 border-r border-border/30">
                      {editingId === item.id ? (
                        <input 
                          type="text" 
                          value={editDesc}
                          onChange={(e) => setEditDesc(e.target.value)}
                          className="w-full bg-background border border-border rounded-lg px-3 py-1.5 text-sm font-bold outline-none"
                        />
                      ) : (
                        <span className="text-sm lg:text-xl font-bold tracking-tight text-slate-700 dark:text-slate-200">{item.description}</span>
                      )}
                    </td>
                    {showWeight && (
                      <td className="px-5 py-4 border-r border-border/30">
                        {editingId === item.id ? (
                          <input 
                            type="number" 
                            step="0.01"
                            value={editWeight}
                            onChange={(e) => setEditWeight(e.target.value)}
                            className="w-full bg-background border border-border rounded-lg px-3 py-1.5 text-sm font-bold outline-none"
                          />
                        ) : (
                          <span className="text-sm lg:text-xl font-black text-slate-500">{toBanglaNumeral(Number(item.weight || 0).toFixed(2))} <span className="text-[10px] lg:text-xs opacity-50 uppercase tracking-widest font-bold">গ্রাম (G)</span></span>
                        )}
                      </td>
                    )}
                    <td className={cn(
                      "px-5 py-4 border-r border-border/30 font-black",
                      type === 'income' ? "text-emerald-600" : "text-rose-600"
                    )}>
                      {editingId === item.id ? (
                        <input 
                          type="number" 
                          value={editAmount}
                          onChange={(e) => setEditAmount(e.target.value)}
                          className="w-full bg-background border border-border rounded-lg px-3 py-1.5 text-sm font-bold outline-none"
                        />
                      ) : (
                        <span className="text-base lg:text-2xl tracking-tighter">৳ {formatBanglaAmount(item.amount)}</span>
                      )}
                    </td>
                    <td className="px-5 py-4 text-right no-print">
                      <div className="flex items-center justify-end gap-1.5">
                        {editingId === item.id ? (
                          <>
                            <button onClick={() => handleSaveEdit(item.id)} className="p-1.5 rounded-lg bg-black text-white dark:bg-white dark:text-black">
                              <Check className="w-3.5 h-3.5" />
                            </button>
                            <button onClick={() => setEditingId(null)} className="p-1.5 rounded-lg border border-border">
                              <X className="w-3.5 h-3.5" />
                            </button>
                          </>
                        ) : (
                          <>
                            <button onClick={() => startEditing(item)} className="p-2 rounded-lg text-muted-foreground hover:text-foreground transition-colors">
                              <Edit2 className="w-3.5 h-3.5" />
                            </button>
                            <button onClick={() => handleDelete(item.id)} className="p-2 rounded-lg text-muted-foreground hover:text-rose-500 transition-colors">
                              <Trash2 className="w-3.5 h-3.5" />
                            </button>
                          </>
                        )}
                      </div>
                    </td>
                  </motion.tr>
                ))}
              </AnimatePresence>

              {/* Add New Row */}
              <tr className={cn(
                "no-print border-t-2 border-border shadow-[inset_0_-2px_10px_rgba(0,0,0,0.02)]",
                type === 'income' ? "bg-emerald-50/30 dark:bg-emerald-950/10" : "bg-rose-50/30 dark:bg-rose-950/10"
              )}>
                <td className="px-5 py-6 border-r border-border/30">
                  <input 
                    type="date" 
                    value={newDate}
                    onChange={(e) => setNewDate(e.target.value)}
                    className="w-full bg-white dark:bg-zinc-900 border border-border rounded-xl px-3 py-2.5 text-xs font-bold outline-none focus:ring-2 focus:ring-primary/20 transition-all font-mono"
                  />
                </td>
                <td className="px-5 py-6 border-r border-border/30">
                  <input 
                    type="text" 
                    placeholder="নথিবদ্ধ করুন..."
                    value={newDesc}
                    onFocus={() => setIsAdding(true)}
                    onChange={(e) => setNewDesc(e.target.value)}
                    className="w-full bg-white dark:bg-zinc-900 border border-border rounded-xl px-4 py-2.5 text-sm font-bold outline-none focus:ring-2 focus:ring-primary/20 transition-all"
                  />
                </td>
                {showWeight && (
                  <td className="px-5 py-6 border-r border-border/30">
                    <input 
                      type="number" 
                      step="0.01"
                      placeholder="ওজন..."
                      value={newWeight}
                      onFocus={() => setIsAdding(true)}
                      onChange={(e) => setNewWeight(e.target.value)}
                      className="w-full bg-white dark:bg-zinc-900 border border-border rounded-xl px-4 py-2.5 text-sm font-bold outline-none focus:ring-2 focus:ring-primary/20 transition-all"
                    />
                  </td>
                )}
                <td className="px-5 py-6 border-r border-border/30">
                  <div className="relative group">
                    <span className="absolute left-3 top-1/2 -translate-y-1/2 text-xs font-black text-muted-foreground group-focus-within:text-foreground transition-colors">৳</span>
                    <input 
                      type="number" 
                      placeholder="টাকার পরিমাণ..."
                      value={newAmount}
                      onFocus={() => setIsAdding(true)}
                      onChange={(e) => setNewAmount(e.target.value)}
                      className="w-full bg-white dark:bg-zinc-900 border border-border rounded-xl pl-8 pr-4 py-2.5 text-sm font-black outline-none focus:ring-2 focus:ring-primary/20 transition-all"
                    />
                  </div>
                </td>
                <td className="px-5 py-6 text-right no-print">
                  <button 
                    onClick={handleAdd}
                    disabled={!newAmount}
                    className={cn(
                      "flex items-center justify-center w-full py-2.5 rounded-xl text-white font-black text-[10px] uppercase tracking-[0.2em] disabled:opacity-20 transition-all shadow-lg active:scale-95",
                      type === 'income' ? "bg-emerald-600 shadow-emerald-600/20" : "bg-rose-600 shadow-rose-600/20"
                    )}
                  >
                    <Plus className="w-4 h-4 mr-2" strokeWidth={3} />
                    Submit
                  </button>
                </td>
              </tr>
            </tbody>
            <tfoot>
              <tr className={cn(
                "border-t-4 h-24 transition-colors",
                type === 'income' ? "bg-emerald-50 dark:bg-emerald-900/20 border-emerald-500" : "bg-rose-50 dark:bg-rose-900/20 border-rose-500"
              )}>
                <td colSpan={2} className="px-8 py-0 border-r border-border/20">
                  <div className="flex flex-col">
                    <span className="text-[10px] font-black text-muted-foreground uppercase tracking-[0.3em] mb-1 italic opacity-50">Aggregate Total</span>
                    <span className={cn(
                      "text-sm font-black uppercase tracking-tighter",
                      type === 'income' ? "text-emerald-700 dark:text-emerald-400" : "text-rose-700 dark:text-rose-400"
                    )}>
                      মোট {type === 'income' ? 'আয়' : 'ব্যয়'} (Total {type === 'income' ? 'Income' : 'Costing'})
                    </span>
                  </div>
                </td>
                {showWeight && (
                  <td className="px-8 py-0 text-2xl font-black text-foreground border-r border-border/20 tracking-tighter">
                    {toBanglaNumeral(totalWeight.toFixed(2))}<span className="text-xs ml-1 font-bold opacity-40 uppercase tracking-widest">গ্রাম (Grams)</span>
                  </td>
                )}
                <td className={cn(
                  "px-8 py-0 text-3xl lg:text-6xl font-black tracking-tighter",
                  type === 'income' ? "text-emerald-600" : "text-rose-600"
                )} colSpan={showWeight ? 1 : 2}>
                  ৳ {formatBanglaAmount(totalAmount)}
                </td>
                <td className="px-8 py-0 no-print sm:table-cell hidden"></td>
              </tr>
            </tfoot>
          </table>
        </div>
      </div>
    </div>
  );
}
