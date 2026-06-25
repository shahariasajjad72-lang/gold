"use client";

import { useMemo } from "react";
import {
  AreaChart,
  Area,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  ResponsiveContainer,
} from "recharts";
import { formatBanglaAmount } from "@/lib/utils/bangla-date";

interface MonthData {
  id: number;
  name: string;
  year: number;
  income: number | null;
  costing: number | null;
}

export default function DashboardChart({ months }: { months: MonthData[] }) {
  const chartData = useMemo(() => {
    // Reverse the months so it shows chronologically
    return [...months].reverse().map((m) => ({
      name: `${m.name.substring(0, 3)} '${m.year.toString().slice(2)}`,
      Income: m.income || 0,
      Expense: m.costing || 0,
    }));
  }, [months]);

  if (months.length === 0) return null;

  return (
    <div className="w-full bg-white dark:bg-[#0a0a0a] border border-border rounded-[32px] p-6 lg:p-8 shadow-sm flex flex-col justify-between h-full">
      <div className="mb-8">
        <h3 className="text-xl font-black text-foreground uppercase tracking-wider">Cash Flow Overview</h3>
        <p className="text-xs font-bold text-muted-foreground uppercase tracking-widest mt-1">Income vs Expense (Last {months.length} Months)</p>
      </div>
      <div className="w-full h-[300px]">
        <ResponsiveContainer width="100%" height="100%">
          <AreaChart
            data={chartData}
            margin={{
              top: 10,
              right: 10,
              left: -10,
              bottom: 0,
            }}
          >
            <defs>
              <linearGradient id="colorIncome" x1="0" y1="0" x2="0" y2="1">
                <stop offset="5%" stopColor="#10b981" stopOpacity={0.3} />
                <stop offset="95%" stopColor="#10b981" stopOpacity={0} />
              </linearGradient>
              <linearGradient id="colorExpense" x1="0" y1="0" x2="0" y2="1">
                <stop offset="5%" stopColor="#f43f5e" stopOpacity={0.3} />
                <stop offset="95%" stopColor="#f43f5e" stopOpacity={0} />
              </linearGradient>
            </defs>
            <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#3f3f46" opacity={0.2} />
            <XAxis 
              dataKey="name" 
              axisLine={false} 
              tickLine={false} 
              tick={{ fontSize: 12, fontWeight: 700, fill: '#71717a' }} 
              dy={15}
            />
            <YAxis 
              axisLine={false} 
              tickLine={false} 
              tickFormatter={(value) => `৳${(value / 100000).toFixed(1)}L`}
              tick={{ fontSize: 12, fontWeight: 700, fill: '#71717a' }}
              dx={-15}
            />
            <Tooltip
              contentStyle={{ borderRadius: '16px', border: 'none', boxShadow: '0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1)', fontWeight: 'bold' }}
              itemStyle={{ fontWeight: 900 }}
              labelStyle={{ color: '#71717a', marginBottom: '8px' }}
              formatter={(value: any, name: any) => [`৳ ${formatBanglaAmount(value || 0)}`, name]}
            />
            <Area
              type="monotone"
              dataKey="Income"
              stroke="#10b981"
              strokeWidth={4}
              fillOpacity={1}
              fill="url(#colorIncome)"
            />
            <Area
              type="monotone"
              dataKey="Expense"
              stroke="#f43f5e"
              strokeWidth={4}
              fillOpacity={1}
              fill="url(#colorExpense)"
            />
          </AreaChart>
        </ResponsiveContainer>
      </div>
    </div>
  );
}
