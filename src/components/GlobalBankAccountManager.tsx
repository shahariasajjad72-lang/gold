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
      <div className="mb-12">
        <div className="flex items-center gap-3 mb-6">
          <div className="p-3 bg-blue-500/10 text-blue-600 rounded-2xl">
            <Building2 className="w-6 h-6" />
          </div>
          <div>
            <h2 className="text-2xl font-black tracking-tight text-foreground">Global Bank Accounts</h2>
            <p className="text-sm text-muted-foreground font-bold uppercase tracking-widest">Manage Initial Balances & Statements</p>
          </div>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
          {banks.map((bank) => (
            <motion.div 
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              key={bank.category} 
              className="bg-card border border-border p-5 rounded-3xl shadow-sm hover:shadow-md transition-all flex flex-col"
            >
              <div className="flex justify-between items-start mb-4">
                <h3 className="font-bold text-foreground text-sm leading-tight line-clamp-2 pr-4">{bank.category}</h3>
                <div className="p-2 bg-muted rounded-xl text-muted-foreground shrink-0">
                  <Building2 className="w-4 h-4" />
                </div>
              </div>

              <div className="flex-1" />

              <div className="bg-muted/50 p-3 rounded-2xl mb-4 border border-border">
                <p className="text-[10px] uppercase tracking-widest text-muted-foreground font-bold mb-1">Initial Starting Balance</p>
                {editingBank === bank.category ? (
                  <div className="flex items-center gap-2">
                    <input 
                      type="number"
                      value={editValue}
                      onChange={(e) => setEditValue(e.target.value)}
                      className="w-full bg-background border border-border rounded-lg px-3 py-1.5 text-sm font-bold outline-none"
                      autoFocus
                    />
                    <button 
                      onClick={() => handleSave(bank.category)} 
                      disabled={isSaving}
                      className="p-1.5 bg-emerald-500 text-white rounded-lg disabled:opacity-50"
                    >
                      <Save className="w-4 h-4" />
                    </button>
                    <button 
                      onClick={() => setEditingBank(null)} 
                      className="p-1.5 bg-rose-100 text-rose-500 rounded-lg"
                    >
                      <X className="w-4 h-4" />
                    </button>
                  </div>
                ) : (
                  <div className="flex items-center justify-between group/edit">
                    <span className="font-black text-lg text-foreground">
                      {formatBanglaAmount(bank.initialBalance)}
                    </span>
                    <button 
                      onClick={() => handleEditClick(bank.category, bank.initialBalance)}
                      className="p-1 text-muted-foreground hover:text-foreground opacity-50 group-hover/edit:opacity-100 transition-all"
                    >
                      <Edit2 className="w-3.5 h-3.5" />
                    </button>
                  </div>
                )}
              </div>

              <div className="bg-slate-900 dark:bg-white p-3 rounded-2xl mb-4 shadow-inner border border-transparent">
                <p className="text-[10px] uppercase tracking-widest text-slate-400 dark:text-zinc-500 font-bold mb-1">Current Balance</p>
                <div className="flex items-center gap-2">
                  <Activity className="w-4 h-4 text-emerald-400 dark:text-emerald-500" />
                  <span className="font-black text-xl text-white dark:text-black">
                    {formatBanglaAmount((bank as any).currentBalance || bank.initialBalance)}
                  </span>
                </div>
              </div>

              <div className="flex-1" />

              <button 
                onClick={() => setSelectedStatementBank(bank.category)}
                className="w-full flex items-center justify-between px-4 py-2.5 bg-slate-900 text-white dark:bg-white dark:text-black rounded-xl hover:scale-[1.02] transition-transform font-bold text-xs uppercase tracking-widest"
              >
                <div className="flex items-center gap-2">
                  <FileText className="w-4 h-4" />
                  View Full Statement
                </div>
                <ChevronRight className="w-4 h-4" />
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
