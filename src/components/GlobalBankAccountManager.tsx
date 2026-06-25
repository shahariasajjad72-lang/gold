'use client';

import { useState, useEffect } from 'react';
import { getGlobalBankConfigs, updateGlobalBankConfig } from '@/lib/actions';
import { motion, AnimatePresence } from 'framer-motion';
import { Building2, Save, X, Edit2, FileText, ChevronRight, Activity } from 'lucide-react';
import { formatBanglaAmount } from '@/lib/utils/bangla-date';
import dynamic from 'next/dynamic';

const GlobalBankStatementModal = dynamic(() => import('@/components/GlobalBankStatementModal'), { ssr: false });

export default function GlobalBankAccountManager() {
  const [banks, setBanks] = useState<{category: string, initialBalance: number}[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [editingBank, setEditingBank] = useState<string | null>(null);
  const [editValue, setEditValue] = useState('');
  const [isSaving, setIsSaving] = useState(false);
  const [selectedStatementBank, setSelectedStatementBank] = useState<string | null>(null);

  const fetchBanks = async () => {
    const data = await getGlobalBankConfigs();
    setBanks(data);
    setIsLoading(false);
  };

  useEffect(() => {
    fetchBanks();
  }, []);

  const handleEditClick = (category: string, currentAmount: number) => {
    setEditingBank(category);
    setEditValue(currentAmount.toString());
  };

  const handleSave = async (category: string) => {
    setIsSaving(true);
    const amount = parseInt(editValue) || 0;
    const res = await updateGlobalBankConfig(category, amount);
    if (res.success) {
      await fetchBanks();
      setEditingBank(null);
    }
    setIsSaving(false);
  };

  if (isLoading) return null;

  return (
    <>
      <div className="mb-12 relative">
        {/* Subtle background glow */}
        <div className="absolute top-0 left-1/2 -translate-x-1/2 w-full max-w-3xl h-32 bg-blue-500/10 blur-[100px] rounded-full pointer-events-none" />
        
        <div className="flex items-center gap-4 mb-8 relative z-10 px-2">
          <div className="p-4 bg-gradient-to-br from-blue-500 to-indigo-600 text-white rounded-3xl shadow-lg shadow-blue-500/20">
            <Building2 className="w-8 h-8" strokeWidth={2.5} />
          </div>
          <div>
            <h2 className="text-3xl lg:text-4xl font-black tracking-tighter uppercase text-foreground">Global Bank Accounts</h2>
            <p className="text-xs text-muted-foreground font-black uppercase tracking-[0.3em] mt-1">Manage Balances & Statements</p>
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
          {banks.map((bank) => (
            <motion.div 
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              key={bank.category} 
              className="bg-white/80 dark:bg-zinc-950/80 backdrop-blur-xl border border-white/20 dark:border-white/10 p-6 rounded-[32px] shadow-[0_8px_30px_rgba(0,0,0,0.04)] hover:shadow-[0_20px_40px_rgba(0,0,0,0.08)] dark:hover:shadow-[0_20px_40px_rgba(0,0,0,0.4)] transition-all duration-300 flex flex-col group relative overflow-hidden"
            >
              {/* Card Accent Gradient */}
              <div className="absolute top-0 right-0 w-32 h-32 bg-blue-500/5 rounded-full blur-3xl -mr-10 -mt-10 pointer-events-none transition-all group-hover:bg-blue-500/10" />

              <div className="flex justify-between items-start mb-6 relative z-10">
                <h3 className="font-black text-foreground text-sm uppercase tracking-wider leading-relaxed pr-4 line-clamp-2">{bank.category}</h3>
                <div className="p-3 bg-blue-50 dark:bg-blue-950/30 text-blue-600 dark:text-blue-400 rounded-2xl shrink-0 group-hover:scale-110 transition-transform shadow-sm">
                  <Building2 className="w-5 h-5" />
                </div>
              </div>

              <div className="flex-1" />

              {/* Initial Balance Section */}
              <div className="bg-muted/30 p-4 rounded-[24px] mb-4 border border-border/50 relative z-10">
                <p className="text-[10px] uppercase tracking-[0.2em] text-muted-foreground font-black mb-2 flex items-center gap-2">
                  <span className="w-1.5 h-1.5 rounded-full bg-slate-400" />
                  Initial Balance
                </p>
                {editingBank === bank.category ? (
                  <div className="flex items-center gap-2">
                    <input 
                      type="number"
                      value={editValue}
                      onChange={(e) => setEditValue(e.target.value)}
                      className="w-full bg-background border border-border/50 focus:border-blue-500 focus:ring-2 focus:ring-blue-500/20 rounded-xl px-4 py-3 text-sm font-black outline-none transition-all"
                      autoFocus
                    />
                    <button 
                      onClick={() => handleSave(bank.category)} 
                      disabled={isSaving}
                      className="p-3 bg-emerald-500 hover:bg-emerald-600 text-white rounded-xl disabled:opacity-50 transition-colors shadow-md shadow-emerald-500/20"
                    >
                      <Save className="w-5 h-5" />
                    </button>
                    <button 
                      onClick={() => setEditingBank(null)} 
                      className="p-3 bg-rose-500 hover:bg-rose-600 text-white rounded-xl transition-colors shadow-md shadow-rose-500/20"
                    >
                      <X className="w-5 h-5" />
                    </button>
                  </div>
                ) : (
                  <div className="flex items-center justify-between group/edit">
                    <span className="font-black text-xl text-foreground tracking-tight">
                      ৳ {formatBanglaAmount(bank.initialBalance)}
                    </span>
                    <button 
                      onClick={() => handleEditClick(bank.category, bank.initialBalance)}
                      className="p-2 bg-white dark:bg-zinc-800 border border-border/50 text-muted-foreground hover:text-blue-600 hover:border-blue-500/30 rounded-xl opacity-0 translate-x-2 group-hover/edit:opacity-100 group-hover/edit:translate-x-0 transition-all shadow-sm"
                    >
                      <Edit2 className="w-4 h-4" />
                    </button>
                  </div>
                )}
              </div>

              {/* Current Balance Section */}
              <div className="bg-gradient-to-br from-slate-900 to-black dark:from-slate-100 dark:to-white p-5 rounded-[24px] mb-6 shadow-xl relative z-10 overflow-hidden">
                <div className="absolute right-0 top-0 w-32 h-32 bg-white/5 dark:bg-black/5 rounded-full blur-2xl -mr-10 -mt-10 pointer-events-none" />
                <p className="text-[10px] uppercase tracking-[0.2em] text-slate-400 dark:text-slate-500 font-black mb-2 flex items-center gap-2">
                  <Activity className="w-3 h-3 text-emerald-400 dark:text-emerald-600" />
                  Current Balance
                </p>
                <div className="flex items-center gap-2">
                  <span className="font-black text-3xl text-white dark:text-black tracking-tighter">
                    ৳ {formatBanglaAmount((bank as any).currentBalance || bank.initialBalance)}
                  </span>
                </div>
              </div>

              {/* Statement Button */}
              <button 
                onClick={() => setSelectedStatementBank(bank.category)}
                className="w-full flex items-center justify-between px-5 py-4 bg-muted/50 hover:bg-blue-600 text-foreground hover:text-white rounded-[20px] transition-all duration-300 font-black text-[10px] uppercase tracking-[0.2em] relative z-10 group/btn"
              >
                <div className="flex items-center gap-3">
                  <FileText className="w-4 h-4" />
                  View Full Statement
                </div>
                <div className="p-1 bg-background/50 rounded-lg group-hover/btn:bg-white/20 transition-colors">
                  <ChevronRight className="w-4 h-4" />
                </div>
              </button>
            </motion.div>
          ))}
        </div>
      </div>

      <GlobalBankStatementModal 
        category={selectedStatementBank} 
        isOpen={!!selectedStatementBank} 
        onClose={() => setSelectedStatementBank(null)} 
      />
    </>
  );
}
