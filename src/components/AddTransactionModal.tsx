'use client';

import { useState, useEffect } from 'react';
import { 
  X, 
  Calendar, 
  DollarSign, 
  Tag, 
  FileText, 
  Scale,
  Plus,
  ArrowUpRight,
  ArrowDownRight,
  ChevronDown
} from 'lucide-react';
import { motion, AnimatePresence } from 'framer-motion';
import { format } from 'date-fns';
import { cn } from '@/lib/utils';
import { addTransaction } from '@/lib/actions';
import { useRouter } from 'next/navigation';

import { INCOME_CATEGORIES, COSTING_CATEGORIES, WEIGHT_TRACKED_CATEGORIES, getSuggestions } from '@/lib/constants';

interface AddTransactionModalProps {
  monthId: number;
  monthName: string;
  monthYear: number;
  isOpen: boolean;
  onClose: () => void;
  onSuccess?: () => void;
}

export default function AddTransactionModal({ monthId, monthName, monthYear, isOpen, onClose, onSuccess }: AddTransactionModalProps) {
  const router = useRouter();
  
  // Helper to truncate long strings to a word limit for UI chips
  const truncateToWords = (str: string, limit: number = 3) => {
    if (!str) return "";
    const words = str.split(" ").filter(w => w.trim().length > 0);
    if (words.length <= limit) return str;
    return words.slice(0, limit).join(" ") + "...";
  };

  const [type, setType] = useState<'income' | 'costing'>('income');
  const [category, setCategory] = useState(INCOME_CATEGORIES[0]);
  const [date, setDate] = useState(format(new Date(), 'yyyy-MM-dd'));
  const [description, setDescription] = useState('');
  const [amount, setAmount] = useState('');
  const [weight, setWeight] = useState('');
  const [isLoading, setIsLoading] = useState(false);

  // Update category when type changes
  useEffect(() => {
    const sortedIncome = [...INCOME_CATEGORIES].sort((a, b) => a.localeCompare(b, 'bn'));
    const sortedCosting = [...COSTING_CATEGORIES].sort((a, b) => a.localeCompare(b, 'bn'));
    
    if (type === 'income') {
      setCategory(sortedIncome[0]);
    } else {
      setCategory(sortedCosting[0]);
    }
  }, [type]);

  const suggestions = getSuggestions(category);

  const isWeightCategory = WEIGHT_TRACKED_CATEGORIES.includes(category) && type === 'income';

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!amount) return;

    // Dynamically replace (মাস-সাল) for costing categories
    const finalCategory = type === 'costing' 
      ? category.replace('(মাস-সাল)', `(${monthName}-${monthYear})`)
      : category;

    setIsLoading(true);
    const res = await addTransaction({
      monthId,
      type,
      category: finalCategory,
      date: new Date(date),
      description: description || finalCategory,
      amount: parseInt(amount),
      weight: isWeightCategory ? weight : undefined,
    });

    if (res.success) {
      if (onSuccess) onSuccess();
      router.refresh();
      onClose();
      // Reset form
      setAmount('');
      setDescription('');
      setWeight('');
    }
    setIsLoading(false);
  };

  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-2 sm:p-4">
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
        className="relative w-full max-w-lg bg-white/90 dark:bg-[#050505]/90 backdrop-blur-xl rounded-[32px] sm:rounded-[40px] border border-white/20 dark:border-white/10 shadow-[0_32px_64px_-16px_rgba(0,0,0,0.3)] overflow-hidden flex flex-col max-h-[96vh]"
      >
        <div className="relative p-6 md:p-8 overflow-y-auto custom-scrollbar">
          <div className="flex justify-between items-start mb-6 md:mb-8">
            <div>
              <div className="flex items-center gap-2 mb-1">
                <span className={cn(
                  "px-2 py-0.5 rounded-md text-[8px] font-black uppercase tracking-widest",
                  type === 'income' ? "bg-emerald-500/10 text-emerald-500" : "bg-rose-500/10 text-rose-500"
                )}>
                  {type === 'income' ? 'CREDIT' : 'DEBIT'} PROTOCOL
                </span>
              </div>
              <h2 className="text-2xl sm:text-3xl font-black tracking-tighter uppercase italic line-clamp-1">Secure Entry</h2>
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
                  type === 'income' ? "bg-emerald-500" : "bg-rose-500"
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
                আয় (Income)
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
                খরজ (Costing)
              </button>
            </div>

            {/* Category Selection */}
            <div className="space-y-2">
              <label className="text-[10px] font-black uppercase tracking-[0.2em] text-muted-foreground ml-1">খাত সমূহ (Category)</label>
              <div className="relative group">
                <div className="absolute left-4 top-1/2 -translate-y-1/2 p-1.5 rounded-lg bg-muted text-muted-foreground group-focus-within:text-foreground transition-colors">
                  <Tag className="w-4 h-4" />
                </div>
                <select
                  value={category}
                  onChange={(e) => setCategory(e.target.value)}
                  className="w-full pl-14 pr-12 py-3.5 sm:py-4 rounded-2xl bg-muted/30 border border-border/50 focus:border-foreground focus:bg-background outline-none font-bold text-sm appearance-none transition-all cursor-pointer"
                >
                  {type === 'income' 
                    ? [...INCOME_CATEGORIES].sort((a, b) => a.localeCompare(b, 'bn')).map(cat => <option key={cat} value={cat}>{cat}</option>)
                    : [...COSTING_CATEGORIES].sort((a, b) => a.localeCompare(b, 'bn')).map(cat => (
                        <option key={cat} value={cat}>
                          {cat.replace('(মাস-সাল)', `(${monthName}-${monthYear})`)}
                        </option>
                      ))
                  }
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
                    className="w-full pl-11 pr-4 py-3.5 sm:py-4 rounded-2xl bg-muted/30 border border-border/50 focus:border-foreground focus:bg-background outline-none font-bold text-sm transition-all"
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
                    className="w-full pl-11 pr-4 py-3.5 sm:py-4 rounded-2xl bg-muted/30 border border-border/50 focus:border-foreground focus:bg-background outline-none font-black text-sm transition-all placeholder:text-muted-foreground/30"
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
                  className="w-full pl-11 pr-4 py-3.5 sm:py-4 rounded-2xl bg-muted/30 border border-border/50 focus:border-foreground focus:bg-background outline-none font-bold text-sm resize-none transition-all placeholder:text-muted-foreground/30"
                />
              </div>
              
              {/* Suggestion Chips */}
              {suggestions.length > 0 && (
                <div className="flex flex-wrap gap-2 mt-2 ml-1">
                  {suggestions.map((sug) => (
                    <button
                      key={sug}
                      type="button"
                      onClick={() => setDescription(sug)}
                      className="px-3 py-1.5 rounded-xl bg-muted/50 hover:bg-muted text-[11px] font-bold text-muted-foreground hover:text-foreground transition-all border border-border/30 hover:border-border/60 active:scale-95"
                      title={sug}
                    >
                      {truncateToWords(sug, 3)}
                    </button>
                  ))}
                </div>
              )}
            </div>

            {/* Weight (Only for gold category) */}
            <AnimatePresence>
              {isWeightCategory && (
                <motion.div
                  initial={{ opacity: 0, height: 0, marginTop: 0 }}
                  animate={{ opacity: 1, height: 'auto', marginTop: 16 }}
                  exit={{ opacity: 0, height: 0, marginTop: 0 }}
                  className="space-y-2 overflow-hidden"
                >
                  <label className="text-[10px] font-black uppercase tracking-[0.2em] text-muted-foreground ml-1">ওজন (Weight in Grams)</label>
                  <div className="relative group">
                    <Scale className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground group-focus-within:text-foreground transition-colors" />
                    <input
                      type="number"
                      step="0.01"
                      placeholder="0.00g"
                      value={weight}
                      onChange={(e) => setWeight(e.target.value)}
                      className="w-full pl-11 pr-4 py-4 rounded-2xl bg-muted/30 border border-border/50 focus:border-foreground focus:bg-background outline-none font-black text-sm transition-all placeholder:text-muted-foreground/30"
                    />
                  </div>
                </motion.div>
              )}
            </AnimatePresence>

            <button
              type="submit"
              disabled={isLoading}
              className={cn(
                "w-full py-4 sm:py-5 rounded-2xl font-black uppercase tracking-[0.2em] text-[10px] flex items-center justify-center gap-3 active:scale-95 transition-all disabled:opacity-50 mt-4 shadow-xl",
                type === 'income' 
                  ? "bg-emerald-500 text-white shadow-emerald-500/20 hover:shadow-emerald-500/40" 
                  : "bg-rose-500 text-white shadow-rose-500/20 hover:shadow-rose-500/40"
              )}
            >
              {isLoading ? (
                <div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
              ) : (
                <>
                  <Plus className="w-5 h-5" strokeWidth={3} />
                  Authorize Transaction
                </>
              )}
            </button>
          </form>

          <div className="flex flex-col items-center gap-2 mt-8">
            <p className="text-[8px] font-black uppercase tracking-[0.3em] text-muted-foreground/30 italic">
              SECURE ENTRY PROTOCOL v1.0.5
            </p>
            <div className="w-12 h-1 rounded-full bg-muted/50" />
          </div>
        </div>
      </motion.div>
    </div>
  );
}
