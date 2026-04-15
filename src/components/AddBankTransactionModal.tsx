'use client';

import { useState } from 'react';
import { 
  X, 
  Calendar, 
  Tag, 
  FileText, 
  Plus,
  ArrowUpRight,
  ArrowDownRight,
  ChevronDown,
  Building2
} from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import { format } from 'date-fns';
import { cn } from '@/lib/utils';
import { addTransaction } from '@/lib/actions';
import { useRouter } from 'next/navigation';
import { BANK_CATEGORIES } from '@/lib/constants';

interface AddBankTransactionModalProps {
  monthId: number;
  isOpen: boolean;
  onClose: () => void;
  onSuccess?: () => void;
}

export default function AddBankTransactionModal({ 
  monthId, 
  isOpen, 
  onClose, 
  onSuccess 
}: AddBankTransactionModalProps) {
  const router = useRouter();
  const [type, setType] = useState<'income' | 'costing'>('income'); // income=deposit, costing=withdrawal
  const [category, setCategory] = useState(BANK_CATEGORIES[0]);
  const [date, setDate] = useState(format(new Date(), 'yyyy-MM-dd'));
  const [description, setDescription] = useState('');
  const [amount, setAmount] = useState('');
  const [isLoading, setIsLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!amount) return;

    setIsLoading(true);
    const res = await addTransaction({
      monthId,
      type,
      category,
      date: new Date(date),
      description: description || category,
      amount: parseInt(amount),
    });

    if (res.success) {
      if (onSuccess) onSuccess();
      router.refresh();
      onClose();
      // Reset form
      setAmount('');
      setDescription('');
    }
    setIsLoading(false);
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
      <motion.div 
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        exit={{ opacity: 0 }}
        onClick={onClose}
        className="absolute inset-0 bg-black/60 backdrop-blur-[8px]"
      />
      
      <motion.div
        initial={{ opacity: 0, scale: 0.95, y: 20 }}
        animate={{ opacity: 1, scale: 1, y: 0 }}
        exit={{ opacity: 0, scale: 0.95, y: 20 }}
        className="relative w-full max-w-lg bg-white/90 dark:bg-[#050505]/90 backdrop-blur-xl rounded-[40px] border border-white/20 dark:border-white/10 shadow-[0_32px_64px_-16px_rgba(0,0,0,0.3)] overflow-hidden"
      >
        {/* Glow Effect */}
        <div className={cn(
          "absolute -top-24 -left-24 w-48 h-48 rounded-full blur-[100px] transition-colors duration-500",
          type === 'income' ? "bg-blue-500/20" : "bg-amber-500/20"
        )} />

        <div className="relative p-6 md:p-8">
          <div className="flex justify-between items-start mb-8">
            <div>
              <div className="flex items-center gap-2 mb-1">
                <span className={cn(
                  "px-2 py-0.5 rounded-md text-[8px] font-black uppercase tracking-widest",
                  type === 'income' ? "bg-blue-500/10 text-blue-500" : "bg-amber-500/10 text-amber-500"
                )}>
                  BANK {type === 'income' ? 'DEPOSIT' : 'WITHDRAWAL'}
                </span>
              </div>
              <h2 className="text-3xl font-black tracking-tighter uppercase italic line-clamp-1">Bank Entry</h2>
            </div>
            <button 
              onClick={onClose}
              className="p-2 rounded-2xl bg-muted/50 hover:bg-muted transition-colors group"
            >
              <X className="w-5 h-5 text-muted-foreground group-hover:text-foreground transition-colors" />
            </button>
          </div>

          <form onSubmit={handleSubmit} className="space-y-6">
            {/* Type Toggle */}
            <div className="relative flex p-1.5 bg-muted/50 rounded-[24px] h-16 overflow-hidden border border-border/50">
              <motion.div
                className={cn(
                  "absolute inset-y-1.5 rounded-[18px] shadow-xl z-0",
                  type === 'income' ? "bg-blue-600" : "bg-amber-600"
                )}
                initial={false}
                animate={{ 
                  x: type === 'income' ? 0 : '100%',
                  width: 'calc(50% - 6px)'
                }}
                transition={{ type: "spring", stiffness: 300, damping: 30 }}
              />
              <button
                type="button"
                onClick={() => setType('income')}
                className={cn(
                  "flex-1 font-black text-[10px] tracking-widest uppercase transition-colors relative z-10 flex items-center justify-center gap-2",
                  type === 'income' ? "text-white" : "text-muted-foreground hover:text-foreground"
                )}
              >
                <ArrowUpRight className="w-4 h-4" />
                জমা (Credit)
              </button>
              <button
                type="button"
                onClick={() => setType('costing')}
                className={cn(
                  "flex-1 font-black text-[10px] tracking-widest uppercase transition-colors relative z-10 flex items-center justify-center gap-2",
                  type === 'costing' ? "text-white" : "text-muted-foreground hover:text-foreground"
                )}
              >
                <ArrowDownRight className="w-4 h-4" />
                উত্তোলন (Debit)
              </button>
            </div>

            {/* Category Selection */}
            <div className="space-y-2">
              <label className="text-[10px] font-black uppercase tracking-[0.2em] text-muted-foreground ml-1">ব্যাংক হিসাব (Bank Account)</label>
              <div className="relative group">
                <div className="absolute left-4 top-1/2 -translate-y-1/2 p-1.5 rounded-lg bg-muted text-muted-foreground group-focus-within:text-foreground transition-colors">
                  <Building2 className="w-4 h-4" />
                </div>
                <select
                  value={category}
                  onChange={(e) => setCategory(e.target.value)}
                  className="w-full pl-14 pr-12 py-4 rounded-2xl bg-muted/30 border border-border/50 focus:border-foreground focus:bg-background outline-none font-bold text-sm appearance-none transition-all cursor-pointer"
                >
                  {BANK_CATEGORIES.map(cat => <option key={cat} value={cat}>{cat}</option>)}
                </select>
                <ChevronDown className="absolute right-4 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground pointer-events-none group-focus-within:rotate-180 transition-transform duration-300" />
              </div>
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              {/* Date Picker */}
              <div className="space-y-2">
                <label className="text-[10px] font-black uppercase tracking-[0.2em] text-muted-foreground ml-1">তারিখ (Date)</label>
                <div className="relative group">
                  <Calendar className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground group-focus-within:text-foreground transition-colors" />
                  <input
                    type="date"
                    value={date}
                    onChange={(e) => setDate(e.target.value)}
                    className="w-full pl-11 pr-4 py-4 rounded-2xl bg-muted/30 border border-border/50 focus:border-foreground focus:bg-background outline-none font-bold text-sm transition-all"
                  />
                </div>
              </div>

              {/* Amount */}
              <div className="space-y-2">
                <label className="text-[10px] font-black uppercase tracking-[0.2em] text-muted-foreground ml-1">টাকা (Amount)</label>
                <div className="relative group">
                  <div className="absolute left-4 top-1/2 -translate-y-1/2 font-black text-muted-foreground group-focus-within:text-foreground transition-colors">৳</div>
                  <input
                    type="number"
                    required
                    placeholder="0.00"
                    value={amount}
                    onChange={(e) => setAmount(e.target.value)}
                    className="w-full pl-11 pr-4 py-4 rounded-2xl bg-muted/30 border border-border/50 focus:border-foreground focus:bg-background outline-none font-black text-sm transition-all placeholder:text-muted-foreground/30"
                  />
                </div>
              </div>
            </div>

            {/* Description */}
            <div className="space-y-2">
              <label className="text-[10px] font-black uppercase tracking-[0.2em] text-muted-foreground ml-1">বিবরণ (Description)</label>
              <div className="relative group">
                <FileText className="absolute left-4 top-4 w-4 h-4 text-muted-foreground group-focus-within:text-foreground transition-colors" />
                <textarea
                  rows={2}
                  placeholder="Enter specific details..."
                  value={description}
                  onChange={(e) => setDescription(e.target.value)}
                  className="w-full pl-11 pr-4 py-4 rounded-2xl bg-muted/30 border border-border/50 focus:border-foreground focus:bg-background outline-none font-bold text-sm resize-none transition-all placeholder:text-muted-foreground/30"
                />
              </div>
            </div>

            <button
              type="submit"
              disabled={isLoading}
              className={cn(
                "w-full py-5 rounded-2xl font-black uppercase tracking-[0.2em] text-[10px] flex items-center justify-center gap-3 active:scale-95 transition-all disabled:opacity-50 mt-4 shadow-xl",
                type === 'income' 
                  ? "bg-blue-600 text-white shadow-blue-600/20 hover:shadow-blue-600/40" 
                  : "bg-amber-600 text-white shadow-amber-600/20 hover:shadow-amber-600/40"
              )}
            >
              {isLoading ? (
                <div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
              ) : (
                <>
                  <Plus className="w-5 h-5" strokeWidth={3} />
                  Authorize Bank Entry
                </>
              )}
            </button>
          </form>

          <div className="flex flex-col items-center gap-2 mt-8">
            <p className="text-[8px] font-black uppercase tracking-[0.3em] text-muted-foreground/30 italic">
              BANK PROTOCOL v1.0.0
            </p>
            <div className="w-12 h-1 rounded-full bg-muted/50" />
          </div>
        </div>
      </motion.div>
    </div>
  );
}
