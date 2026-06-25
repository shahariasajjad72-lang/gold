'use client';

import { useState, useEffect } from 'react';
import { useRouter, useParams } from 'next/navigation';
import { getMonthById } from '@/lib/actions';
import DashboardHeader from '@/components/DashboardHeader';
import { motion } from 'framer-motion';
import { 
  ArrowLeft, 
  ArrowUpRight, 
  ArrowDownRight, 
  ChevronRight, 
  Wallet, 
  Plus, 
  CreditCard,
  Printer,
  Building2,
  Edit2,
  Check,
  X as CloseIcon
} from 'lucide-react';
import { cn } from '@/lib/utils';
import { isAuthenticated } from '@/lib/auth';
import Link from 'next/link';
import { formatBanglaAmount, toBanglaNumeral } from '@/lib/utils/bangla-date';
import dynamic from 'next/dynamic';
import { BarChart3, FileText } from 'lucide-react';
import { INCOME_CATEGORIES, COSTING_CATEGORIES, BANK_CATEGORIES } from '@/lib/constants';
import { updateOpeningBalance } from '@/lib/actions';
import MonthChart from '@/components/MonthChart';

// Lazy-load heavy modal components — they are only fetched when the user opens them.
const AddTransactionModal = dynamic(() => import('@/components/AddTransactionModal'), { ssr: false });
const AddBankTransactionModal = dynamic(() => import('@/components/AddBankTransactionModal'), { ssr: false });
const DailyReportModal = dynamic(() => import('@/components/DailyReportModal'), { ssr: false });
const DailySummaryModal = dynamic(() => import('@/components/DailySummaryModal'), { ssr: false });
const MonthlyReportModal = dynamic(() => import('@/components/MonthlyReportModal'), { ssr: false });
const MonthEndSummaryModal = dynamic(() => import('@/components/MonthEndSummaryModal'), { ssr: false });

export default function MonthDetailPage() {
  const params = useParams();
  const router = useRouter();
  const [month, setMonth] = useState<any>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isBankModalOpen, setIsBankModalOpen] = useState(false);
  const [isReportModalOpen, setIsReportModalOpen] = useState(false);
  const [isSummaryModalOpen, setIsSummaryModalOpen] = useState(false);
  const [isMonthlyReportOpen, setIsMonthlyReportOpen] = useState(false);
  const [isMonthEndSummaryOpen, setIsMonthEndSummaryOpen] = useState(false);
  const [isEditingOpening, setIsEditingOpening] = useState(false);
  const [newOpeningBalance, setNewOpeningBalance] = useState('');

  const fetchData = async () => {
    const data = await getMonthById(parseInt(params.id as string));
    if (data) {
      setMonth(data);
    }
    setIsLoading(false);
  };

  useEffect(() => {
    if (!isAuthenticated()) {
      router.push('/login');
      return;
    }
    fetchData();
  }, [params.id, router]);

  const handleUpdateOpening = async () => {
    const res = await updateOpeningBalance(month.id, parseInt(newOpeningBalance));
    if (res.success) {
      setMonth({ ...month, openingBalance: parseInt(newOpeningBalance) });
      setIsEditingOpening(false);
    }
  };

  const startEditingOpening = () => {
    setNewOpeningBalance(month.openingBalance?.toString() || '0');
    setIsEditingOpening(true);
  };

  if (isLoading) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="w-8 h-8 border-2 border-primary/30 border-t-primary rounded-full animate-spin" />
      </div>
    );
  }

  if (!month) {
    return (
      <div className="min-h-screen bg-background flex flex-col items-center justify-center gap-4">
        <p className="text-muted-foreground font-bold">Month not found</p>
        <button onClick={() => router.push('/dashboard')} className="text-primary underline">Back to Dashboard</button>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-background pb-20">
      <DashboardHeader />
      
      <main className="container mx-auto px-4 py-8 lg:py-12 max-w-[1700px]">
        <div className="flex justify-between items-start mb-6">
          <button 
            onClick={() => router.push('/dashboard')}
            className="flex items-center gap-2 text-muted-foreground hover:text-foreground transition-all font-black uppercase tracking-widest text-[10px]"
          >
            <ArrowLeft className="w-4 h-4" />
            Back to Dashboard
          </button>

          <div className="flex flex-wrap items-center justify-end gap-2 sm:gap-3">


            <motion.button
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
              onClick={() => setIsBankModalOpen(true)}
              className="hidden sm:flex items-center gap-2 px-6 py-3 rounded-2xl bg-blue-600 text-white font-black uppercase tracking-widest text-[10px] shadow-lg hover:shadow-xl hover:shadow-blue-600/20 transition-all"
            >
              <Building2 className="w-4 h-4" strokeWidth={3} />
              Bank Entry
            </motion.button>

            <motion.button
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
              onClick={() => setIsModalOpen(true)}
              className="hidden sm:flex items-center gap-2 px-6 py-3 rounded-2xl bg-emerald-500 text-white font-black uppercase tracking-widest text-[10px] shadow-lg hover:shadow-xl hover:shadow-emerald-500/20 transition-all"
            >
              <Plus className="w-4 h-4" strokeWidth={3} />
              Add Entry
            </motion.button>
          </div>
        </div>

        <div className="mb-8 lg:mb-12 flex flex-col md:flex-row justify-between items-start md:items-end gap-6">
          <div>
            <h1 className="text-3xl sm:text-5xl lg:text-7xl font-black tracking-tighter text-foreground mb-1 uppercase">{month.name}</h1>
            <p className="text-sm lg:text-lg text-muted-foreground font-bold uppercase tracking-[0.2em]">{toBanglaNumeral(month.year)} Financial Report</p>
          </div>

          {/* Quick Reports Hub placed stylishly beside the title */}
          <div className="flex flex-wrap items-center gap-2 sm:gap-3 bg-muted/30 p-2 rounded-[24px] border border-border/50 no-print">
            <button
              onClick={() => setIsReportModalOpen(true)}
              className="flex items-center gap-2 px-4 py-2.5 rounded-xl hover:bg-white dark:hover:bg-zinc-900 text-foreground font-black uppercase tracking-widest text-[10px] hover:shadow-sm transition-all"
            >
              <Printer className="w-4 h-4 text-slate-500" />
              Daily
            </button>
            <button
              onClick={() => setIsSummaryModalOpen(true)}
              className="flex items-center gap-2 px-4 py-2.5 rounded-xl hover:bg-indigo-50 dark:hover:bg-indigo-950/30 text-indigo-700 dark:text-indigo-400 font-black uppercase tracking-widest text-[10px] hover:shadow-sm transition-all"
            >
              <BarChart3 className="w-4 h-4 text-indigo-500" />
              Summary
            </button>
            <button
              onClick={() => setIsMonthlyReportOpen(true)}
              className="flex items-center gap-2 px-4 py-2.5 rounded-xl hover:bg-white dark:hover:bg-zinc-900 text-foreground font-black uppercase tracking-widest text-[10px] hover:shadow-sm transition-all"
            >
              <FileText className="w-4 h-4 text-slate-500" />
              Monthly
            </button>
            <button
              onClick={() => setIsMonthEndSummaryOpen(true)}
              className="flex items-center gap-2 px-4 py-2.5 rounded-xl hover:bg-amber-50 dark:hover:bg-amber-950/30 text-amber-700 dark:text-amber-500 font-black uppercase tracking-widest text-[10px] hover:shadow-sm transition-all"
            >
              <FileText className="w-4 h-4 text-amber-500" />
              Month End
            </button>
          </div>
        </div>

        {/* V2 Dashboard Layout */}
        <div className="grid grid-cols-1 xl:grid-cols-3 gap-6 mb-16">
          {/* Left Column: KPI Cards */}
          <div className="flex flex-col gap-6 xl:col-span-2">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6 h-full">
              {/* Opening Balance Card */}
              <div className="p-6 sm:p-8 rounded-[32px] bg-blue-50 dark:bg-blue-950/20 border-2 border-blue-100 dark:border-blue-900/30 shadow-sm flex flex-col justify-center relative overflow-hidden group">
                <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-opacity">
                  <Wallet className="w-24 h-24 text-blue-500" />
                </div>
                <div className="flex items-center justify-between mb-2">
                  <p className="text-[11px] font-black uppercase tracking-[0.2em] text-blue-600 dark:text-blue-500">Opening Balance</p>
                  <button onClick={startEditingOpening} className="p-2 hover:bg-blue-200/50 dark:hover:bg-blue-900/50 rounded-xl transition-colors text-blue-600 dark:text-blue-400 z-10 relative">
                    <Edit2 className="w-4 h-4" />
                  </button>
                </div>
                {isEditingOpening ? (
                  <div className="flex items-center gap-2 mt-1 z-10 relative">
                    <input 
                      type="number" 
                      value={newOpeningBalance}
                      onChange={(e) => setNewOpeningBalance(e.target.value)}
                      className="w-full bg-white dark:bg-black border border-blue-200 dark:border-blue-800 rounded-xl px-4 py-3 text-lg font-bold outline-none"
                      autoFocus
                    />
                    <button onClick={handleUpdateOpening} className="p-3 bg-emerald-500 text-white rounded-xl shadow-md"><Check className="w-5 h-5" /></button>
                    <button onClick={() => setIsEditingOpening(false)} className="p-3 bg-rose-500 text-white rounded-xl shadow-md"><CloseIcon className="w-5 h-5" /></button>
                  </div>
                ) : (
                  <h2 className="text-3xl sm:text-4xl font-black text-blue-900 dark:text-blue-400">৳ {formatBanglaAmount(month.openingBalance || 0)}</h2>
                )}
              </div>

              {/* Net Balance Card */}
              <div className="p-6 sm:p-8 rounded-[32px] bg-slate-900 dark:bg-white border-2 border-slate-900 dark:border-white shadow-2xl flex flex-col justify-center relative overflow-hidden group">
                <div className="absolute top-0 right-0 p-6 opacity-10 transition-opacity">
                  <CreditCard className="w-24 h-24 text-white dark:text-black" />
                </div>
                <p className="text-[11px] font-black uppercase tracking-[0.2em] text-slate-400 dark:text-slate-500 mb-2">Net Balance</p>
                <h2 className="text-3xl sm:text-4xl font-black text-white dark:text-black">
                  ৳ {formatBanglaAmount((month.openingBalance || 0) + (month.income || 0) - (month.costing || 0))}
                </h2>
              </div>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-6 h-full">
              {/* Income Card */}
              <div className="p-6 sm:p-8 rounded-[32px] bg-emerald-50 dark:bg-emerald-950/20 border-2 border-emerald-100 dark:border-emerald-900/30 shadow-sm flex flex-col justify-center relative overflow-hidden group">
                <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-opacity">
                  <ArrowUpRight className="w-24 h-24 text-emerald-500" />
                </div>
                <p className="text-[11px] font-black uppercase tracking-[0.2em] text-emerald-600 dark:text-emerald-500 mb-2">Total Income</p>
                <h2 className="text-3xl sm:text-4xl font-black text-emerald-900 dark:text-emerald-400">৳ {formatBanglaAmount(month.income || 0)}</h2>
              </div>

              {/* Costing Card */}
              <div className="p-6 sm:p-8 rounded-[32px] bg-rose-50 dark:bg-rose-950/20 border-2 border-rose-100 dark:border-rose-900/30 shadow-sm flex flex-col justify-center relative overflow-hidden group">
                <div className="absolute top-0 right-0 p-6 opacity-10 group-hover:opacity-20 transition-opacity">
                  <ArrowDownRight className="w-24 h-24 text-rose-500" />
                </div>
                <p className="text-[11px] font-black uppercase tracking-[0.2em] text-rose-600 dark:text-rose-500 mb-2">Total Expense</p>
                <h2 className="text-3xl sm:text-4xl font-black text-rose-900 dark:text-rose-400">৳ {formatBanglaAmount(month.costing || 0)}</h2>
              </div>
            </div>
          </div>

          {/* Right Column: Chart */}
          <div className="xl:col-span-1 h-full min-h-[300px]">
            <MonthChart income={month.income || 0} costing={month.costing || 0} />
          </div>
        </div>

        <div className="grid grid-cols-1 gap-12">
          {/* Income Categories Section */}
          <div className="space-y-6">
            <div className="flex items-center gap-2 px-1">
              <Wallet className="w-5 h-5 lg:w-6 lg:h-6 text-muted-foreground" />
              <h2 className="text-lg lg:text-3xl font-black tracking-tight uppercase italic text-muted-foreground">আয় এর বিবরণ / খাত সমূহ</h2>
            </div>
            
            <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 2xl:grid-cols-6 gap-3 lg:gap-4">
              {INCOME_CATEGORIES.map((category, i) => (
                <motion.div
                  key={category}
                  initial={{ opacity: 0, y: 10 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ delay: i * 0.03 }}
                >
                  <Link 
                    href={`/month/${month.id}/income/${encodeURIComponent(category)}`}
                    className="w-full h-full flex flex-col justify-between p-4 rounded-3xl bg-white dark:bg-[#0a0a0a] border border-border/50 hover:border-emerald-500 hover:bg-emerald-50/50 dark:hover:bg-emerald-950/20 shadow-sm hover:shadow-[0_10px_30px_rgba(16,185,129,0.15)] transition-all duration-300 group min-h-[90px]"
                  >
                    <div className="w-8 h-8 rounded-full bg-emerald-50 dark:bg-emerald-900/30 flex items-center justify-center mb-2 group-hover:scale-110 transition-transform">
                      <ArrowUpRight className="w-4 h-4 text-emerald-500" />
                    </div>
                    <div className="flex items-end justify-between gap-2 mt-auto">
                      <span className="font-bold text-foreground text-xs leading-tight group-hover:text-emerald-600 dark:group-hover:text-emerald-400 transition-colors">{category}</span>
                    </div>
                  </Link>
                </motion.div>
              ))}
            </div>
          </div>
 
           {/* Costing Categories Section */}
           <div className="space-y-6">
             <div className="flex items-center gap-2 px-1">
               <CreditCard className="w-5 h-5 lg:w-6 lg:h-6 text-muted-foreground" />
               <h2 className="text-lg lg:text-3xl font-black tracking-tight uppercase italic text-muted-foreground">ব্যয় এর বিবরণ / খাত সমূহ</h2>
             </div>
             
             <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 2xl:grid-cols-6 gap-3 lg:gap-4">
               {COSTING_CATEGORIES.map((category, i) => {
                 return (
                   <motion.div
                     key={category}
                     initial={{ opacity: 0, y: 10 }}
                     animate={{ opacity: 1, y: 0 }}
                     transition={{ delay: i * 0.03 }}
                   >
                     <Link 
                       href={`/month/${month.id}/cost/${encodeURIComponent(category)}`}
                       className="w-full h-full flex flex-col justify-between p-4 rounded-3xl bg-white dark:bg-[#0a0a0a] border border-border/50 hover:border-rose-500 hover:bg-rose-50/50 dark:hover:bg-rose-950/20 shadow-sm hover:shadow-[0_10px_30px_rgba(244,63,94,0.15)] transition-all duration-300 group min-h-[90px]"
                     >
                       <div className="w-8 h-8 rounded-full bg-rose-50 dark:bg-rose-900/30 flex items-center justify-center mb-2 group-hover:scale-110 transition-transform">
                         <ArrowDownRight className="w-4 h-4 text-rose-500" />
                       </div>
                       <div className="flex items-end justify-between gap-2 mt-auto">
                         <span className="font-bold text-foreground text-xs leading-tight group-hover:text-rose-600 dark:group-hover:text-rose-400 transition-colors">{category}</span>
                       </div>
                     </Link>
                   </motion.div>
                 );
               })}
             </div>
          </div>

          {/* Bank Accounts Section */}
          <div className="space-y-6">
            <div className="flex items-center gap-2 px-1">
              <Building2 className="w-5 h-5 lg:w-6 lg:h-6 text-muted-foreground" />
              <h2 className="text-lg lg:text-3xl font-black tracking-tight uppercase italic text-muted-foreground">ব্যবসায়িক ব্যাংক হিসাব (Bank Accounts)</h2>
            </div>
            
            <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 2xl:grid-cols-6 gap-3 lg:gap-4">
              {BANK_CATEGORIES.map((category, i) => (
                <motion.div
                  key={category}
                  initial={{ opacity: 0, y: 10 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ delay: i * 0.03 }}
                >
                  <Link 
                    href={`/month/${month.id}/bank/${encodeURIComponent(category)}`}
                    className="w-full h-full flex flex-col justify-between p-4 rounded-3xl bg-white dark:bg-[#0a0a0a] border border-border/50 hover:border-blue-500 hover:bg-blue-50/50 dark:hover:bg-blue-950/20 shadow-sm hover:shadow-[0_10px_30px_rgba(59,130,246,0.15)] transition-all duration-300 group min-h-[90px]"
                  >
                    <div className="w-8 h-8 rounded-full bg-blue-50 dark:bg-blue-900/30 flex items-center justify-center mb-2 group-hover:scale-110 transition-transform">
                      <Building2 className="w-4 h-4 text-blue-500" />
                    </div>
                    <div className="flex items-end justify-between gap-2 mt-auto">
                      <span className="font-bold text-foreground text-xs leading-tight group-hover:text-blue-600 dark:group-hover:text-blue-400 transition-colors">{category}</span>
                    </div>
                  </Link>
                </motion.div>
              ))}
            </div>
          </div>
        </div>
      </main>

      {/* Mobile Sticky FABs */}
      <div className="sm:hidden fixed bottom-6 left-4 right-4 z-40 flex gap-3">
        <motion.button
          whileTap={{ scale: 0.95 }}
          onClick={() => setIsBankModalOpen(true)}
          className="flex-1 flex items-center justify-center gap-2 py-4 rounded-[20px] bg-blue-600 text-white font-black uppercase tracking-widest text-[11px] shadow-[0_8px_30px_rgba(37,99,235,0.4)] border border-white/20"
        >
          <Building2 className="w-5 h-5" />
          Bank
        </motion.button>
        <motion.button
          whileTap={{ scale: 0.95 }}
          onClick={() => setIsModalOpen(true)}
          className="flex-1 flex items-center justify-center gap-2 py-4 rounded-[20px] bg-emerald-600 text-white font-black uppercase tracking-widest text-[11px] shadow-[0_8px_30px_rgba(16,185,129,0.4)] border border-white/20"
        >
          <Plus className="w-5 h-5" strokeWidth={3} />
          Add Entry
        </motion.button>
      </div>

      <AddTransactionModal 
        monthId={month.id}
        monthName={month.name}
        monthYear={month.year}
        isOpen={isModalOpen}
        onSuccess={fetchData}
        onClose={() => setIsModalOpen(false)}
      />

      <AddBankTransactionModal 
        monthId={month.id}
        monthName={month.name}
        monthYear={month.year}
        isOpen={isBankModalOpen}
        onSuccess={fetchData}
        onClose={() => setIsBankModalOpen(false)}
      />

      <DailyReportModal 
        monthId={month.id}
        isOpen={isReportModalOpen}
        onClose={() => setIsReportModalOpen(false)}
      />

      <DailySummaryModal 
        monthId={month.id}
        isOpen={isSummaryModalOpen}
        onClose={() => setIsSummaryModalOpen(false)}
      />

      <MonthlyReportModal 
        monthId={month.id}
        isOpen={isMonthlyReportOpen}
        onClose={() => setIsMonthlyReportOpen(false)}
      />

      <MonthEndSummaryModal
        monthId={month.id}
        isOpen={isMonthEndSummaryOpen}
        onClose={() => setIsMonthEndSummaryOpen(false)}
      />
    </div>
  );
}
