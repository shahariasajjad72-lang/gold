'use client';

import { useState, useEffect } from 'react';
import { isAuthenticated } from '@/lib/auth';
import MonthCard from '@/components/MonthCard';
import AddMonthCard from '@/components/AddMonthCard';
import DashboardHeader from '@/components/DashboardHeader';
import dynamic from 'next/dynamic';
import { motion, AnimatePresence } from 'framer-motion';
import { Search, Filter, LayoutGrid } from 'lucide-react';
import { useRouter } from 'next/navigation';
import { getMonths } from '@/lib/actions';
import GlobalBankAccountManager from '@/components/GlobalBankAccountManager';
import DashboardChart from '@/components/DashboardChart';
import { formatBanglaAmount } from '@/lib/utils/bangla-date';
import { TrendingUp, TrendingDown, Wallet } from 'lucide-react';

// Lazy-load heavy modal
const AddMonthModal = dynamic(() => import('@/components/AddMonthModal'), { ssr: false });

interface MonthData {
  id: number;
  name: string;
  year: number;
  income: number | null;
  costing: number | null;
}

export default function DashboardPage() {
  const [months, setMonths] = useState<MonthData[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const router = useRouter();

  const fetchMonthsData = async () => {
    setIsLoading(true);
    const data = await getMonths();
    setMonths(data as MonthData[]);
    setIsLoading(false);
  };

  useEffect(() => {
    if (!isAuthenticated()) {
      router.push('/login');
    } else {
      fetchMonthsData();
    }
  }, [router]);

  if (isLoading && months.length === 0) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="w-8 h-8 border-2 border-primary/30 border-t-primary rounded-full animate-spin" />
      </div>
    );
  }

  const totalIncome = months.reduce((acc, m) => acc + (m.income || 0), 0);
  const totalExpense = months.reduce((acc, m) => acc + (m.costing || 0), 0);
  const netBalance = totalIncome - totalExpense;

  return (
    <div className="min-h-screen bg-background">
      <DashboardHeader />
      
      <main className="container mx-auto px-4 py-12 max-w-[1700px]">
        <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-6 mb-12">
          <div>
            <h1 className="text-4xl lg:text-5xl font-black tracking-tighter text-foreground mb-2 uppercase">Dashboard</h1>
            <p className="text-muted-foreground font-bold lg:text-sm tracking-widest uppercase">My Tracker Financial Analytics</p>
          </div>
          
          <div className="flex items-center gap-3 w-full md:w-auto">
            <div className="relative flex-1 md:w-64 group">
              <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground group-focus-within:text-foreground transition-colors" />
              <input 
                type="text" 
                placeholder="Search..." 
                className="w-full pl-11 pr-4 py-3 rounded-2xl bg-muted/50 border border-transparent focus:bg-background focus:border-border outline-none transition-all text-sm font-bold"
              />
            </div>
            <button className="p-3 rounded-2xl bg-slate-900 text-white dark:bg-white dark:text-black hover:scale-105 transition-all shadow-xl shadow-slate-900/20 dark:shadow-white/20">
              <Filter className="w-5 h-5" />
            </button>
          </div>
        </div>

        {/* --- V2 KPIs & Chart Section --- */}
        <div className="grid grid-cols-1 xl:grid-cols-3 gap-6 mb-10">
          {/* Top KPIs */}
          <div className="flex flex-col gap-6">
            <div className="p-8 rounded-[32px] bg-emerald-50 dark:bg-emerald-950/20 border-2 border-emerald-100 dark:border-emerald-900/30 shadow-sm flex flex-col justify-center relative overflow-hidden h-full group">
              <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-opacity">
                <TrendingUp className="w-24 h-24 text-emerald-500" />
              </div>
              <p className="text-[11px] font-black uppercase tracking-[0.2em] text-emerald-600 dark:text-emerald-500 mb-2">All-Time Revenue</p>
              <h2 className="text-4xl font-black text-emerald-900 dark:text-emerald-400">৳ {formatBanglaAmount(totalIncome)}</h2>
            </div>

            <div className="p-8 rounded-[32px] bg-rose-50 dark:bg-rose-950/20 border-2 border-rose-100 dark:border-rose-900/30 shadow-sm flex flex-col justify-center relative overflow-hidden h-full group">
              <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-opacity">
                <TrendingDown className="w-24 h-24 text-rose-500" />
              </div>
              <p className="text-[11px] font-black uppercase tracking-[0.2em] text-rose-600 dark:text-rose-500 mb-2">All-Time Expense</p>
              <h2 className="text-4xl font-black text-rose-900 dark:text-rose-400">৳ {formatBanglaAmount(totalExpense)}</h2>
            </div>

            <div className="p-8 rounded-[32px] bg-slate-900 dark:bg-white border-2 border-slate-900 dark:border-white shadow-2xl flex flex-col justify-center relative overflow-hidden h-full group">
              <div className="absolute top-0 right-0 p-6 opacity-10 transition-opacity">
                <Wallet className="w-24 h-24 text-white dark:text-black" />
              </div>
              <p className="text-[11px] font-black uppercase tracking-[0.2em] text-slate-400 dark:text-slate-500 mb-2">Net Cash Flow</p>
              <h2 className="text-4xl font-black text-white dark:text-black">৳ {formatBanglaAmount(netBalance)}</h2>
            </div>
          </div>

          {/* Interactive Chart */}
          <div className="xl:col-span-2">
            <DashboardChart months={months} />
          </div>
        </div>

        <GlobalBankAccountManager />

        {/* Grid of Months - Updated to Three in a Row + wider for 2xl */}
        <div className="flex items-center gap-2 mb-6 px-1">
          <div className="p-2 lg:p-3 rounded-2xl bg-amber-500/10 text-amber-600">
             <LayoutGrid className="w-5 h-5" />
          </div>
          <h2 className="text-xl lg:text-3xl font-black tracking-tight text-foreground">Monthly Ledgers</h2>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 2xl:grid-cols-4 gap-6 lg:gap-8">
          <AnimatePresence mode="popLayout">
            {months.map((month) => (
              <motion.div
                key={month.id}
                layout
                initial={{ opacity: 0, y: 10 }}
                animate={{ opacity: 1, y: 0 }}
                exit={{ opacity: 0, scale: 0.9 }}
                transition={{ duration: 0.2 }}
              >
                <MonthCard 
                  id={month.id.toString()} 
                  name={month.name} 
                  year={month.year} 
                  income={month.income || 0} 
                  costing={month.costing || 0} 
                />
              </motion.div>
            ))}
          </AnimatePresence>
          
          <motion.div layout>
            <AddMonthCard onClick={() => setIsModalOpen(true)} />
          </motion.div>
        </div>

        {months.length === 0 && !isLoading && (
          <div className="mt-20 flex flex-col items-center justify-center text-center py-20 border-2 border-dashed border-border rounded-[40px] bg-muted/20">
            <div className="p-6 rounded-3xl bg-muted mb-6">
              <LayoutGrid className="w-10 h-10 text-muted-foreground" />
            </div>
            <h3 className="text-xl font-bold mb-2">No entries yet</h3>
            <p className="text-muted-foreground max-w-sm mb-8">Start tracking by creating your first monthly financial folder</p>
            <button 
              onClick={() => setIsModalOpen(true)}
              className="px-8 py-3 rounded-2xl bg-black text-white dark:bg-white dark:text-black font-bold hover:scale-105 transition-all"
            >
              Add First Month
            </button>
          </div>
        )}
      </main>

      <AddMonthModal 
        isOpen={isModalOpen} 
        onClose={() => setIsModalOpen(false)} 
        onSuccess={fetchMonthsData}
      />
    </div>
  );
}
