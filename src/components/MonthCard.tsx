'use client';

import { TrendingUp, TrendingDown, ArrowRight, Wallet } from 'lucide-react';
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
  const net = income - costing;

  return (
    <motion.div
      whileHover={{ y: -6, scale: 1.02 }}
      whileTap={{ scale: 0.98 }}
      className="group h-full"
    >
      <Link href={`/month/${id}`} className="block relative h-full">
        <div className="relative overflow-hidden rounded-[32px] p-6 lg:p-8 bg-slate-900 dark:bg-[#0a0a0a] text-white border-2 border-slate-800 dark:border-zinc-800 shadow-[0_10px_40px_-10px_rgba(0,0,0,0.5)] group-hover:border-indigo-500/50 group-hover:shadow-[0_20px_50px_-10px_rgba(99,102,241,0.4)] transition-all duration-500 h-full flex flex-col z-10">
          
          {/* Glowing Orb Background */}
          <div className="absolute -top-24 -right-24 w-64 h-64 bg-indigo-500 rounded-full mix-blend-screen filter blur-[80px] opacity-20 group-hover:opacity-40 transition-opacity duration-500" />
          <div className="absolute -bottom-24 -left-24 w-64 h-64 bg-emerald-500 rounded-full mix-blend-screen filter blur-[80px] opacity-10 group-hover:opacity-30 transition-opacity duration-500" />

          {/* Card Header */}
          <div className="flex justify-between items-start mb-6 relative z-10">
            <div className="flex items-center gap-2">
              <Wallet className="w-6 h-6 text-indigo-400" />
              <span className="text-[10px] font-black uppercase tracking-[0.2em] text-slate-400">Monthly Ledger</span>
            </div>
            <div className="text-right">
              <h3 className="text-xl lg:text-2xl font-black tracking-tight">{name}</h3>
              <p className="text-xs font-bold text-slate-400 uppercase tracking-widest mt-0.5">{toBanglaNumeral(year.toString())}</p>
            </div>
          </div>

          {/* Main Balance (Like a Card Number) */}
          <div className="my-6 relative z-10">
            <p className="text-[9px] font-black uppercase tracking-[0.3em] text-slate-500 mb-2">Monthly Net Flow</p>
            <h2 className="text-3xl lg:text-4xl font-black tracking-tighter tabular-nums drop-shadow-md">
              {net >= 0 ? '+' : '-'} ৳{formatBanglaAmount(Math.abs(net))}
            </h2>
          </div>

          {/* Footer Stats */}
          <div className="mt-auto pt-6 border-t border-slate-800/50 flex justify-between items-end relative z-10">
            <div className="space-y-3">
              <div className="flex items-center gap-2">
                <div className="p-1.5 rounded-full bg-emerald-500/20 text-emerald-400">
                  <TrendingUp className="w-3 h-3" />
                </div>
                <div>
                  <p className="text-[8px] font-black uppercase tracking-widest text-slate-500">Income</p>
                  <p className="text-xs font-bold">৳{formatBanglaAmount(income)}</p>
                </div>
              </div>
              <div className="flex items-center gap-2">
                <div className="p-1.5 rounded-full bg-rose-500/20 text-rose-400">
                  <TrendingDown className="w-3 h-3" />
                </div>
                <div>
                  <p className="text-[8px] font-black uppercase tracking-widest text-slate-500">Expense</p>
                  <p className="text-xs font-bold">৳{formatBanglaAmount(costing)}</p>
                </div>
              </div>
            </div>

            <div className="w-12 h-12 rounded-2xl bg-indigo-500 text-white flex items-center justify-center shadow-lg group-hover:scale-110 group-hover:bg-indigo-400 transition-all">
              <ArrowRight className="w-5 h-5" />
            </div>
          </div>
        </div>
      </Link>
    </motion.div>
  );
}
