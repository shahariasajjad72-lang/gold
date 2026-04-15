'use client';

import { useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { X, Calendar, Plus } from 'lucide-react';
import { addMonth } from '@/lib/actions';
import { cn } from '@/lib/utils';

interface AddMonthModalProps {
  isOpen: boolean;
  onClose: () => void;
  onSuccess: () => void;
}

export default function AddMonthModal({ isOpen, onClose, onSuccess }: AddMonthModalProps) {
  const [name, setName] = useState('');
  const [year, setYear] = useState(new Date().getFullYear().toString());
  const [openingBalance, setOpeningBalance] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [error, setError] = useState('');

  const months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!name || !year) {
      setError('Please fill in all fields');
      return;
    }

    setIsSubmitting(true);
    setError('');

    const result = await addMonth(name, parseInt(year), parseInt(openingBalance || '0'));
    
    if (result.success) {
      setName('');
      onSuccess();
      onClose();
    } else {
      setError('Failed to add month. Please check your DB connection.');
    }
    setIsSubmitting(false);
  };

  return (
    <AnimatePresence>
      {isOpen && (
        <>
          {/* Backdrop */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={onClose}
            className="fixed inset-0 bg-black/60 backdrop-blur-sm z-[100]"
          />

          {/* Modal */}
          <motion.div
            initial={{ opacity: 0, scale: 0.95, y: 20 }}
            animate={{ opacity: 1, scale: 1, y: 0 }}
            exit={{ opacity: 0, scale: 0.95, y: 20 }}
            className="fixed left-1/2 top-1/2 -translate-x-1/2 -translate-y-1/2 w-full max-w-md z-[101] px-4"
          >
            <div className="bg-white dark:bg-black rounded-3xl p-8 border border-border shadow-2xl overflow-hidden relative">
              <button 
                onClick={onClose}
                className="absolute right-6 top-6 p-2 rounded-full hover:bg-muted transition-colors text-muted-foreground"
              >
                <X className="w-5 h-5" />
              </button>

              <div className="flex items-center gap-3 mb-8">
                <div className="p-3 rounded-2xl bg-primary text-primary-foreground">
                  <Calendar className="w-6 h-6" />
                </div>
                <div>
                  <h2 className="text-xl font-bold">Add Entry</h2>
                  <p className="text-sm text-muted-foreground">Select month and year</p>
                </div>
              </div>

              <form onSubmit={handleSubmit} className="space-y-6">
                <div className="space-y-2">
                  <label className="text-sm font-semibold ml-1">Month</label>
                  <select
                    value={name}
                    onChange={(e) => setName(e.target.value)}
                    className="w-full px-4 py-3 rounded-2xl border border-border bg-background focus:ring-2 focus:ring-primary/10 outline-none transition-all appearance-none"
                    required
                  >
                    <option value="">Select Month</option>
                    {months.map(m => (
                      <option key={m} value={m}>{m}</option>
                    ))}
                  </select>
                </div>

                <div className="space-y-2">
                  <label className="text-sm font-semibold ml-1">Year</label>
                  <input
                    type="number"
                    value={year}
                    onChange={(e) => setYear(e.target.value)}
                    className="w-full px-4 py-3 rounded-2xl border border-border bg-background focus:ring-2 focus:ring-primary/10 outline-none transition-all"
                    placeholder="2025"
                    min="2000"
                    max="2100"
                    required
                  />
                </div>

                <div className="space-y-2">
                  <label className="text-sm font-semibold ml-1">Opening Balance (প্রাথমিক জমা)</label>
                  <div className="relative">
                    <span className="absolute left-4 top-1/2 -translate-y-1/2 text-muted-foreground font-bold">৳</span>
                    <input
                      type="number"
                      value={openingBalance}
                      onChange={(e) => setOpeningBalance(e.target.value)}
                      className="w-full pl-10 pr-4 py-3 rounded-2xl border border-border bg-background focus:ring-2 focus:ring-primary/10 outline-none transition-all font-bold"
                      placeholder="0.00"
                    />
                  </div>
                  <p className="text-[10px] text-muted-foreground ml-1 italic">* This will be the starting balance for the month</p>
                </div>

                {error && (
                  <p className="text-sm text-red-500 font-medium ml-1 bg-red-500/10 p-3 rounded-xl border border-red-500/20">{error}</p>
                )}

                <button
                  type="submit"
                  disabled={isSubmitting}
                  className={cn(
                    "w-full py-4 rounded-2xl font-bold text-white bg-black dark:bg-white dark:text-black transition-all flex items-center justify-center gap-2",
                    "hover:scale-[1.02] active:scale-[0.98] disabled:opacity-50"
                  )}
                >
                  {isSubmitting ? (
                    <div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                  ) : (
                    <>
                      <Plus className="w-5 h-5" strokeWidth={3} />
                      Create Entry
                    </>
                  )}
                </button>
              </form>
            </div>
          </motion.div>
        </>
      )}
    </AnimatePresence>
  );
}
