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
              onClick={() => setIsReportModalOpen(true)}
              className="flex items-center gap-2 px-5 py-3 rounded-2xl bg-muted border border-border text-foreground font-black uppercase tracking-widest text-[10px] shadow-sm hover:shadow-md transition-all no-print"
            >
              <Printer className="w-4 h-4" />
              Daily
            </motion.button>

            <motion.button
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
              onClick={() => setIsSummaryModalOpen(true)}
              className="flex items-center gap-2 px-5 py-3 rounded-2xl bg-indigo-50 border border-indigo-100 text-indigo-700 font-black uppercase tracking-widest text-[10px] shadow-sm hover:shadow-md transition-all no-print"
            >
              <BarChart3 className="w-4 h-4" />
              Summary
            </motion.button>

            <motion.button
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
              onClick={() => setIsMonthlyReportOpen(true)}
              className="flex items-center gap-2 px-5 py-3 rounded-2xl bg-slate-900 border border-slate-800 text-white font-black uppercase tracking-widest text-[10px] shadow-sm hover:shadow-md transition-all no-print"
            >
              <FileText className="w-4 h-4" />
              Monthly
            </motion.button>

            <motion.button
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
              onClick={() => setIsMonthEndSummaryOpen(true)}
              className="flex items-center gap-2 px-5 py-3 rounded-2xl bg-amber-50 border border-amber-200 text-amber-800 font-black uppercase tracking-widest text-[10px] shadow-sm hover:shadow-md transition-all no-print"
            >
              <FileText className="w-4 h-4" />
              Month End
            </motion.button>

            <motion.button
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
              onClick={() => setIsBankModalOpen(true)}
              className="flex items-center gap-2 px-6 py-3 rounded-2xl bg-blue-600 text-white font-black uppercase tracking-widest text-[10px] shadow-lg hover:shadow-xl transition-all"
            >
              <Building2 className="w-4 h-4" strokeWidth={3} />
              Bank Entry
            </motion.button>

            <motion.button
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
              onClick={() => setIsModalOpen(true)}
              className="flex items-center gap-2 px-6 py-3 rounded-2xl bg-black text-white dark:bg-white dark:text-black font-black uppercase tracking-widest text-[10px] shadow-lg hover:shadow-xl transition-all"
            >
              <Plus className="w-4 h-4" strokeWidth={3} />
              Add Entry
            </motion.button>
          </div>
        </div>

        <div className="mb-8 lg:mb-16">
          <h1 className="text-3xl sm:text-5xl lg:text-7xl font-black tracking-tighter text-foreground mb-1">{month.name}</h1>
          <p className="text-sm lg:text-lg text-muted-foreground font-bold uppercase tracking-widest italic">{toBanglaNumeral(month.year)} Financial Overview</p>
        </div>

        {/* Smaller Header Cards */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 mb-12">
          {/* Opening Balance Card */}
          <div className="group bg-white dark:bg-black p-6 rounded-[32px] border border-border card-shadow flex items-center justify-between">
            <div className="flex items-center gap-4 w-full">
              <div className="p-3 rounded-2xl bg-blue-500/10 text-blue-600">
                <Wallet className="w-5 h-5" />
              </div>
              <div className="flex-1">
                <div className="flex items-center justify-between">
                  <p className="text-[10px] lg:text-xs font-black uppercase tracking-widest text-muted-foreground">Original Opening</p>
                  <button onClick={startEditingOpening} className="p-1 hover:bg-muted rounded transition-colors text-muted-foreground">
                    <Edit2 className="w-3 h-3" />
                  </button>
                </div>
                {isEditingOpening ? (
                  <div className="flex items-center gap-2 mt-1">
                    <input 
                      type="number" 
                      value={newOpeningBalance}
                      onChange={(e) => setNewOpeningBalance(e.target.value)}
                      className="w-full bg-background border border-border rounded-lg px-2 py-1 text-sm font-bold outline-none"
                      autoFocus
                    />
                    <button onClick={handleUpdateOpening} className="p-1 text-emerald-500"><Check className="w-4 h-4" /></button>
                    <button onClick={() => setIsEditingOpening(false)} className="p-1 text-rose-500"><CloseIcon className="w-4 h-4" /></button>
                  </div>
                ) : (
                  <h2 className="text-xl lg:text-3xl font-black tracking-tight">{formatBanglaAmount(month.openingBalance || 0)}</h2>
                )}
              </div>
            </div>
          </div>

          {/* Income Card */}
          <div className="group bg-white dark:bg-black p-6 rounded-[32px] border border-border card-shadow flex items-center justify-between">
            <div className="flex items-center gap-4">
              <div className="p-3 rounded-2xl bg-emerald-500/10 text-emerald-600">
                <ArrowUpRight className="w-5 h-5" />
              </div>
              <div>
                <p className="text-[10px] lg:text-xs font-black uppercase tracking-widest text-muted-foreground">Total Income</p>
                <h2 className="text-xl lg:text-3xl font-black tracking-tight">
                  {formatBanglaAmount(month.income || 0)}
                </h2>
              </div>
            </div>
          </div>

          {/* Costing Card */}
          <div className="group bg-white dark:bg-black p-6 rounded-[32px] border border-border card-shadow flex items-center justify-between">
            <div className="flex items-center gap-4">
              <div className="p-3 rounded-2xl bg-rose-500/10 text-rose-600">
                <ArrowDownRight className="w-5 h-5" />
              </div>
              <div>
                <p className="text-[10px] lg:text-xs font-black uppercase tracking-widest text-muted-foreground">Total Costing</p>
                <h2 className="text-xl lg:text-3xl font-black tracking-tight">
                  {formatBanglaAmount(month.costing || 0)}
                </h2>
              </div>
            </div>
          </div>

          {/* Net Balance Card */}
          <div className="group bg-slate-900 dark:bg-white p-6 rounded-[32px] border border-transparent shadow-xl flex items-center justify-between overflow-hidden relative">
            <div className="absolute inset-0 bg-gradient-to-br from-white/10 to-transparent pointer-events-none" />
            <div className="flex items-center gap-4 relative z-10">
              <div className="p-3 rounded-2xl bg-white/20 dark:bg-black/10 text-white dark:text-black">
                <CreditCard className="w-5 h-5" />
              </div>
              <div>
                <p className="text-[10px] lg:text-xs font-black uppercase tracking-widest text-white/60 dark:text-black/60">Net Balance</p>
                <h2 className="text-2xl lg:text-4xl font-black tracking-tight text-white dark:text-black">
                  {formatBanglaAmount((month.openingBalance || 0) + (month.income || 0) - (month.costing || 0))}
                </h2>
              </div>
            </div>
          </div>
        </div>

        <div className="grid grid-cols-1 gap-12">
          {/* Income Categories Section */}
          <div className="space-y-6">
            <div className="flex items-center gap-2 px-1">
              <Wallet className="w-5 h-5 lg:w-6 lg:h-6 text-muted-foreground" />
              <h2 className="text-lg lg:text-3xl font-black tracking-tight uppercase italic text-muted-foreground">আয় এর বিবরণ / খাত সমূহ</h2>
            </div>
            
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 2xl:grid-cols-5 gap-3 lg:gap-5">
              {INCOME_CATEGORIES.map((category, i) => (
                <motion.div
                  key={category}
                  initial={{ opacity: 0, y: 10 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ delay: i * 0.05 }}
                >
                  <Link 
                    href={`/month/${month.id}/income/${encodeURIComponent(category)}`}
                    className="w-full h-full flex items-center justify-between p-5 rounded-2xl bg-white dark:bg-black border border-border hover:border-emerald-500 hover:bg-emerald-500/5 hover:shadow-lg hover:shadow-emerald-500/5 transition-all group"
                  >
                    <span className="font-bold text-foreground text-sm lg:text-lg group-hover:text-emerald-600 dark:group-hover:text-emerald-400 transition-colors">{category}</span>
                    <ChevronRight className="w-4 h-4 text-muted-foreground group-hover:text-emerald-500 transition-colors" />
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
             
             <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 2xl:grid-cols-5 gap-3 lg:gap-5">
               {COSTING_CATEGORIES.map((category, i) => {
                 const dynamicCategory = category.replace('(মাস-সাল)', `(${month.name}-${month.year})`);
                 return (
                   <motion.div
                     key={category}
                     initial={{ opacity: 0, y: 10 }}
                     animate={{ opacity: 1, y: 0 }}
                     transition={{ delay: i * 0.05 }}
                   >
                     <Link 
                       href={`/month/${month.id}/cost/${encodeURIComponent(dynamicCategory)}`}
                       className="w-full h-full flex items-center justify-between p-5 rounded-2xl bg-white dark:bg-black border border-border hover:border-rose-500 hover:bg-rose-500/10 hover:shadow-lg hover:shadow-rose-500/5 transition-all group"
                     >
                       <span className="font-bold text-foreground text-sm lg:text-lg group-hover:text-rose-600 dark:group-hover:text-rose-400 transition-colors">{dynamicCategory}</span>
                       <ChevronRight className="w-4 h-4 text-muted-foreground group-hover:text-rose-500 transition-colors" />
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
            
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 2xl:grid-cols-5 gap-3 lg:gap-5">
              {BANK_CATEGORIES.map((category, i) => (
                <motion.div
                  key={category}
                  initial={{ opacity: 0, y: 10 }}
                  animate={{ opacity: 1, y: 0 }}
                  transition={{ delay: i * 0.05 }}
                >
                  <Link 
                    href={`/month/${month.id}/bank/${encodeURIComponent(category)}`}
                    className="w-full h-full flex items-center justify-between p-5 rounded-2xl bg-white dark:bg-black border border-border hover:border-blue-500 hover:bg-blue-500/10 hover:shadow-lg hover:shadow-blue-500/5 transition-all group"
                  >
                    <span className="font-bold text-foreground text-sm lg:text-lg group-hover:text-blue-600 dark:group-hover:text-blue-400 transition-colors line-clamp-1">{category}</span>
                    <ChevronRight className="w-4 h-4 text-muted-foreground group-hover:text-blue-500 transition-colors" />
                  </Link>
                </motion.div>
              ))}
            </div>
          </div>
        </div>
      </main>

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
