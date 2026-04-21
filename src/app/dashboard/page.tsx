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

  return (
    <div className="min-h-screen bg-background">
      <DashboardHeader />
      
      <main className="container mx-auto px-4 py-12 max-w-[1700px]">
        <div className="flex flex-col md:flex-row justify-between items-start md:items-center gap-6 mb-12">
          <div>
            <h1 className="text-4xl lg:text-6xl font-black tracking-tighter text-foreground mb-2">My Tracker</h1>
            <p className="text-muted-foreground font-medium lg:text-lg">Manage your monthly financial records</p>
          </div>
          
          <div className="flex items-center gap-3 w-full md:w-auto">
            <div className="relative flex-1 md:w-64 group">
              <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground group-focus-within:text-foreground transition-colors" />
              <input 
                type="text" 
                placeholder="Search..." 
                className="w-full pl-11 pr-4 py-2.5 rounded-xl bg-muted/50 border border-transparent focus:bg-background focus:border-border outline-none transition-all text-sm font-medium"
              />
            </div>
            <button className="p-2.5 rounded-xl border border-border hover:bg-muted transition-all">
              <Filter className="w-5 h-5 text-muted-foreground" />
            </button>
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
