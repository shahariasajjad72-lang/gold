"use client";

import { useMemo } from "react";
import { PieChart, Pie, Cell, Tooltip, ResponsiveContainer } from "recharts";
import { formatBanglaAmount } from "@/lib/utils/bangla-date";

interface MonthChartProps {
  income: number;
  costing: number;
}

export default function MonthChart({ income, costing }: MonthChartProps) {
  const data = useMemo(() => {
    return [
      { name: "Income", value: income, color: "#10b981" }, // emerald-500
      { name: "Expense", value: costing, color: "#f43f5e" }, // rose-500
    ];
  }, [income, costing]);

  const total = income + costing;

  if (total === 0) {
    return (
      <div className="w-full h-full min-h-[300px] flex items-center justify-center bg-slate-50 dark:bg-zinc-950/50 rounded-[32px] border-2 border-dashed border-border/50">
        <p className="text-muted-foreground font-bold text-sm uppercase tracking-widest">No Transactions Yet</p>
      </div>
    );
  }

  return (
    <div className="w-full h-full min-h-[300px] bg-slate-900 dark:bg-[#0a0a0a] rounded-[32px] p-6 shadow-2xl relative overflow-hidden flex flex-col items-center justify-center border-2 border-slate-800/50 dark:border-zinc-800">
      <div className="absolute inset-0 bg-gradient-to-br from-white/5 to-transparent pointer-events-none" />
      <h3 className="text-white font-black uppercase tracking-widest text-xs mb-4 z-10 text-center">Cash Flow Distribution</h3>
      <div className="w-full h-[220px] z-10">
        <ResponsiveContainer width="100%" height="100%">
          <PieChart>
            <Pie
              data={data}
              cx="50%"
              cy="50%"
              innerRadius={65}
              outerRadius={85}
              paddingAngle={5}
              dataKey="value"
              stroke="none"
              cornerRadius={10}
            >
              {data.map((entry, index) => (
                <Cell key={`cell-${index}`} fill={entry.color} />
              ))}
            </Pie>
            <Tooltip
              formatter={(value: number) => [`৳ ${formatBanglaAmount(value)}`, ""]}
              contentStyle={{ borderRadius: '16px', border: 'none', backgroundColor: '#fff', color: '#000', fontWeight: 'bold', boxShadow: '0 10px 25px -5px rgba(0,0,0,0.1)' }}
              itemStyle={{ color: '#000' }}
            />
          </PieChart>
        </ResponsiveContainer>
      </div>
      <div className="flex gap-6 mt-4 z-10">
        <div className="flex items-center gap-2">
          <div className="w-3 h-3 rounded-full bg-emerald-500 shadow-[0_0_10px_rgba(16,185,129,0.5)]" />
          <span className="text-[10px] font-black uppercase tracking-widest text-slate-300">Income</span>
        </div>
        <div className="flex items-center gap-2">
          <div className="w-3 h-3 rounded-full bg-rose-500 shadow-[0_0_10px_rgba(244,63,94,0.5)]" />
          <span className="text-[10px] font-black uppercase tracking-widest text-slate-300">Expense</span>
        </div>
      </div>
    </div>
  );
}
