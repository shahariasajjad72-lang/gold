'use client';

import { useState, useEffect } from 'react';
import { getMonthById, getBankTransactions } from '@/lib/actions';
import DashboardHeader from '@/components/DashboardHeader';
import BankTransactionTable from '@/components/BankTransactionTable';
import { motion } from 'framer-motion';
import { ArrowLeft, Building2, Info } from 'lucide-react';
import { isAuthenticated } from '@/lib/auth';

// Correcting the imports for Next.js app router
import { useParams as useNextParams, useRouter as useNextRouter } from 'next/navigation';

export default function BankCategoryPage() {
  const params = useNextParams();
  const router = useNextRouter();
  const [month, setMonth] = useState<any>(null);
  const [transactions, setTransactions] = useState<any[]>([]);
  const [isLoading, setIsLoading] = useState(true);

  const category = decodeURIComponent(params.category as string);
  const monthId = parseInt(params.id as string);

  const fetchData = async () => {
    const monthData = await getMonthById(monthId);
    // For bank transactions, we fetch all-time to get accurate balance
    const transData = await getBankTransactions(category);
    
    if (monthData) {
      setMonth(monthData);
      setTransactions(transData);
    }
    setIsLoading(false);
  };

  useEffect(() => {
    if (!isAuthenticated()) {
      router.push('/login');
      return;
    }
    fetchData();
  }, [monthId, category, router]);

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
        <p className="text-muted-foreground font-bold italic uppercase tracking-widest text-xs">Error: Data context lost</p>
        <button onClick={() => router.push('/dashboard')} className="text-black dark:text-white font-black underline">Return Home</button>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-background">
      <DashboardHeader />
      
      <main className="container mx-auto px-4 py-8 lg:py-12 max-w-[1700px]">
        <button 
          onClick={() => router.push(`/month/${monthId}`)}
          className="flex items-center gap-2 text-muted-foreground hover:text-foreground transition-all mb-8 font-black uppercase tracking-widest text-[10px]"
        >
          <ArrowLeft className="w-4 h-4" />
          Back to {month.name}
        </button>

        <div className="flex flex-col md:flex-row justify-between items-start md:items-end gap-6 mb-12">
          <div>
            <div className="flex items-center gap-3 lg:gap-5 mb-2">
              <div className="p-3 lg:p-5 rounded-2xl lg:rounded-[24px] bg-blue-600 text-white shadow-xl shadow-blue-500/20">
                <Building2 className="w-5 h-5 lg:w-8 lg:h-8" />
              </div>
              <h1 className="text-3xl lg:text-6xl font-black tracking-tighter text-foreground italic uppercase">{category}</h1>
            </div>
            <p className="text-sm lg:text-lg text-muted-foreground font-bold uppercase tracking-widest italic ml-1 lg:ml-2 opacity-60">
              Bank Ledger • Historical Records & Balance
            </p>
          </div>

          <div className="flex items-center gap-3 bg-muted/30 px-5 py-3 rounded-2xl border border-border">
            <Info className="w-4 h-4 text-muted-foreground" />
            <p className="text-[10px] font-black uppercase tracking-widest text-muted-foreground">Bank balances are calculated from all entries</p>
          </div>
        </div>

        <motion.div
          initial={{ opacity: 0, scale: 0.98 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ duration: 0.3 }}
        >
          <BankTransactionTable 
            monthId={monthId}
            category={category}
            initialData={transactions}
            refreshData={fetchData}
          />
        </motion.div>
      </main>
    </div>
  );
}
