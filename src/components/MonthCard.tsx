'use client';

import { Folder, ChevronRight, ArrowUpRight, ArrowDownRight } from 'lucide-react';
import { motion } from 'framer-motion';
import Link from 'next/link';
import { formatBanglaAmount, toBanglaNumeral } from '@/lib/utils/bangla-date';

interface MonthCardProps {
  id: string;
  name: string;
  year: number;
  income: number;
  costing: number;
}

export default function MonthCard({ id, name, year, income, costing }: MonthCardProps) {
  return (
    <motion.div
      whileHover={{ y: -4, scale: 1.01 }}
      whileTap={{ scale: 0.98 }}
      className="group h-full"
    >
      <Link href={`/month/${id}`} className="block relative h-full">
        {/* Minimal Folder Tab */}
        <div className="absolute -top-2.5 left-6 w-12 h-3 bg-muted border border-b-0 border-border rounded-t-lg group-hover:bg-foreground group-hover:border-foreground transition-all duration-300" />
        
        <div className="bg-white dark:bg-black rounded-[32px] p-7 lg:p-9 border border-border group-hover:border-primary group-hover:bg-primary/[0.02] transition-all duration-300 h-full flex flex-col shadow-sm group-hover:shadow-xl group-hover:shadow-primary/5">
          <div className="flex justify-between items-start mb-8">
            <div className="p-3 rounded-2xl bg-muted text-foreground group-hover:bg-primary group-hover:text-primary-foreground transition-all duration-300 shadow-sm group-hover:shadow-md">
              <Folder className="w-5 h-5" fill="currentColor" fillOpacity={0.2} />
            </div>
            <div className="text-right">
              <h3 className="text-xl lg:text-3xl font-black tracking-tight text-foreground">{name}</h3>
              <p className="text-xs lg:text-sm font-bold text-muted-foreground uppercase tracking-widest mt-1">{toBanglaNumeral(year.toString())}</p>
            </div>
          </div>

          <div className="mt-auto space-y-4">
            <div className="flex items-center justify-between py-2 border-b border-border/50">
              <div className="flex items-center gap-2 text-muted-foreground">
                <ArrowUpRight className="w-4 h-4" />
                <span className="text-xs font-bold uppercase tracking-tight">Income</span>
              </div>
              <span className="text-sm font-black text-foreground">
                {income > 0 ? `৳${formatBanglaAmount(income)}` : '৳০'}
              </span>
            </div>
            
            <div className="flex items-center justify-between py-2">
              <div className="flex items-center gap-2 text-muted-foreground">
                <ArrowDownRight className="w-4 h-4" />
                <span className="text-xs font-bold uppercase tracking-tight">Costing</span>
              </div>
              <span className="text-sm font-black text-foreground">
                {costing > 0 ? `৳${formatBanglaAmount(costing)}` : '৳০'}
              </span>
            </div>
          </div>

          <div className="mt-6 flex items-center justify-end text-[10px] font-black uppercase tracking-widest text-muted-foreground group-hover:text-foreground transition-colors">
            <ChevronRight className="w-4 h-4" />
          </div>
        </div>
      </Link>
    </motion.div>
  );
}
