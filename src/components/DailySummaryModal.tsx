"use client";

import { useState, useEffect, useMemo, useRef } from "react";
import {
  X,
  Printer,
  Calendar,
  TrendingUp,
  TrendingDown,
  Clock,
  Download,
  Wallet,
  Calculator,
} from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { format } from "date-fns";
import { cn } from "@/lib/utils";
import {
  getDailyTransactions,
  getMonthById,
  getMonthlyStatsBeforeDate,
} from "@/lib/actions";
import {
  formatBanglaDate,
  toBanglaNumeral,
  formatBanglaAmount,
} from "@/lib/utils/bangla-date";

interface DailySummaryModalProps {
  monthId: number;
  isOpen: boolean;
  onClose: () => void;
}

export default function DailySummaryModal({
  monthId,
  isOpen,
  onClose,
}: DailySummaryModalProps) {
  const [selectedDate, setSelectedDate] = useState(
    format(new Date(), "yyyy-MM-dd"),
  );
  const [transactions, setTransactions] = useState<any[]>([]);
  const [carryBalance, setCarryBalance] = useState(0);
  const [isLoading, setIsLoading] = useState(false);
  const [isCapturing, setIsCapturing] = useState(false);
  const [view, setView] = useState<"select" | "summary">("select");
  const summaryAreaRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (!isOpen) {
      setView("select");
      setTransactions([]);
    }
  }, [isOpen]);

  const fetchSummaryData = async () => {
    setIsLoading(true);

    const month = await getMonthById(monthId);
    const statsBefore = await getMonthlyStatsBeforeDate(monthId, selectedDate);
    const opening = month?.openingBalance || 0;
    const carry = opening + statsBefore.totalIncome - statsBefore.totalCosting;
    setCarryBalance(carry);

    const data = await getDailyTransactions(monthId, selectedDate);
    setTransactions(data);

    setIsLoading(false);
    setView("summary");
  };

  const totalIncome = useMemo(
    () =>
      transactions
        .filter((t) => t.type === "income")
        .reduce((sum, t) => sum + t.amount, 0),
    [transactions],
  );

  const totalCosting = useMemo(
    () =>
      transactions
        .filter((t) => t.type === "costing")
        .reduce((sum, t) => sum + t.amount, 0),
    [transactions],
  );

  const currentClosing = carryBalance + totalIncome - totalCosting;

  const handlePrint = () => {
    const node = summaryAreaRef.current;
    if (!node) return;

    const printWindow = window.open("", "_blank", "width=800,height=800");
    if (!printWindow) return;

    printWindow.document.write(`<!DOCTYPE html>
<html lang="bn">
<head>
  <meta charset="UTF-8" />
  <title>দৈনিক সারসংক্ষেপ - ${selectedDate}</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Serif+Bengali:wght@400;700;900&display=swap');
    body { font-family: 'Noto Serif Bengali', serif; padding: 20mm; background: white; color: black; display: flex; justify-content: center; }
    .container { width: 140mm; }
    .header { text-align: center; margin-bottom: 25px; border-bottom: 2px solid black; padding-bottom: 10px; }
    .card { border: 1px solid black; padding: 15px; margin-bottom: 10px; }
    .flex-row { display: flex; justify-content: space-between; align-items: center; }
    .total-card { background: #1e293b; color: white; padding: 20px; text-align: center; margin-top: 15px; }
    .text-right { text-align: right; }
    .font-black { font-weight: 900; }
    .text-sm { font-size: 12px; }
    .text-lg { font-size: 18px; }
    .text-2xl { font-size: 24px; }
    .no-print { display: none !important; }
  </style>
</head>
<body>
  <div class="container">
    ${node.innerHTML}
  </div>
</body>
</html>`);

    printWindow.document.close();
    printWindow.focus();
    setTimeout(() => {
      printWindow.print();
      printWindow.close();
    }, 500);
  };

  const handleSaveImage = async () => {
    const node = document.getElementById("summary-capture-area");
    if (!node) return;

    setIsCapturing(true);
    setTimeout(async () => {
      try {
        const { toPng } = await import("html-to-image");
        const dataUrl = await toPng(node, {
          quality: 1.0,
          backgroundColor: "#ffffff",
          pixelRatio: 3,
        });

        const link = document.createElement("a");
        link.download = `সারসংক্ষেপ-${selectedDate}.png`;
        link.href = dataUrl;
        link.click();
      } catch (err) {
        console.error("Failed to save image", err);
      } finally {
        setIsCapturing(false);
      }
    }, 100);
  };

  return (
    <>
      <AnimatePresence>
        {isOpen && (
          <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              onClick={onClose}
              className="absolute inset-0 bg-background/80 backdrop-blur-sm no-print"
            />

            <motion.div
              initial={{ opacity: 0, scale: 0.95, y: 20 }}
              animate={{ opacity: 1, scale: 1, y: 0 }}
              exit={{ opacity: 0, scale: 0.95, y: 20 }}
              className={cn(
                "relative w-full bg-white dark:bg-black rounded-[32px] border border-border shadow-2xl overflow-hidden flex flex-col transition-all duration-500",
                view === "select" ? "max-w-md" : "max-w-2xl",
              )}
            >
              <div className="flex items-center justify-between px-6 py-4 border-b border-border no-print shrink-0 bg-slate-50 dark:bg-zinc-900/50">
                <h2 className="text-base font-black tracking-tight text-slate-800 dark:text-zinc-200 flex items-center gap-2">
                  <Calculator className="w-5 h-5 text-indigo-500" />
                  {view === "select" ? "তারিখ নির্বাচন" : "দৈনিক সারসংক্ষেপ"}
                </h2>
                <div className="flex items-center gap-2">
                  {view === "summary" && (
                    <>
                      <button
                        onClick={handleSaveImage}
                        disabled={isCapturing}
                        className="p-2 rounded-xl bg-indigo-50 text-indigo-600 hover:bg-indigo-100 transition-colors"
                      >
                        <Download className="w-5 h-5" />
                      </button>
                      <button
                        onClick={handlePrint}
                        className="p-2 rounded-xl bg-slate-100 text-slate-600 hover:bg-slate-200 transition-colors"
                      >
                        <Printer className="w-5 h-5" />
                      </button>
                    </>
                  )}
                  <button
                    onClick={onClose}
                    className="p-2 rounded-xl bg-rose-50 text-rose-600 hover:bg-rose-100 transition-colors"
                  >
                    <X className="w-5 h-5" />
                  </button>
                </div>
              </div>

              <div className="flex-1 overflow-y-auto">
                {view === "select" ? (
                  <div className="p-8 space-y-6">
                    <div className="p-6 rounded-3xl bg-slate-50 border-2 border-dashed border-slate-200 text-center">
                      <Calendar className="w-10 h-10 mx-auto mb-3 text-slate-400" />
                      <p className="text-sm font-black text-slate-500 uppercase tracking-widest">
                        রিপোর্ট এর তারিখ
                      </p>
                    </div>

                    <input
                      type="date"
                      value={selectedDate}
                      onChange={(e) => setSelectedDate(e.target.value)}
                      className="w-full bg-background border-2 border-slate-200 rounded-2xl px-5 py-4 text-lg font-black outline-none focus:border-indigo-500 transition-all text-center"
                    />

                    <button
                      onClick={fetchSummaryData}
                      disabled={isLoading}
                      className="w-full py-5 rounded-2xl bg-slate-900 text-white font-black uppercase tracking-[0.2em] text-xs shadow-xl shadow-slate-900/20 active:scale-95 transition-all"
                    >
                      {isLoading ? "প্রসেসিং হচ্ছে..." : "সারসংক্ষেপ দেখুন"}
                    </button>
                  </div>
                ) : (
                  <div
                    id="summary-capture-area"
                    ref={summaryAreaRef}
                    className="p-8 lg:p-12 space-y-8 bg-white dark:bg-black"
                  >
                    {/* Professional Company Header */}
                    <div className="text-center space-y-2 border-b-2 border-slate-900 pb-6">
                      <h1 className="text-[28px] font-black text-slate-900 dark:text-white uppercase tracking-tight">
                        বাংলা গোল্ড (প্রাঃ) লিমিটেড
                      </h1>
                      <div className="flex flex-col items-center gap-1">
                        <h2 className="text-lg font-bold text-slate-600 dark:text-zinc-400">
                          দৈনিক আর্থিক সারসংক্ষেপ ({formatBanglaDate(new Date(selectedDate))})
                        </h2>
                        <div className="h-0.5 w-24 bg-indigo-500 rounded-full" />
                      </div>
                    </div>

                    <div className="grid grid-cols-1 gap-4">
                      {/* Previous Balance Card */}
                      <div className="p-6 rounded-3xl bg-blue-50 border-2 border-blue-100 flex items-center justify-between group">
                        <div className="space-y-1">
                          <p className="text-[10px] font-black text-blue-500 uppercase tracking-widest flex items-center gap-1.5 font-sans">
                            <Wallet className="w-3 h-3" />
                            আগের স্থিতি (PREVIOUS)
                          </p>
                          <h4 className="text-2xl font-black text-blue-900">
                            ৳ {formatBanglaAmount(carryBalance)}
                          </h4>
                        </div>
                        <div className="w-12 h-12 rounded-2xl bg-white flex items-center justify-center text-blue-500 shadow-sm transition-transform group-hover:scale-110">
                          <Wallet className="w-6 h-6" />
                        </div>
                      </div>

                      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                        {/* Income Card */}
                        <div className="p-6 rounded-3xl bg-emerald-50 border-2 border-emerald-100 flex items-center justify-between group">
                          <div className="space-y-1">
                            <p className="text-[10px] font-black text-emerald-600 uppercase tracking-widest flex items-center gap-1.5 font-sans">
                              <TrendingUp className="w-3 h-3" />
                              আজকের আয় (INCOME)
                            </p>
                            <h4 className="text-2xl font-black text-emerald-900">
                              ৳ {formatBanglaAmount(totalIncome)}
                            </h4>
                          </div>
                        </div>

                        {/* Costing Card */}
                        <div className="p-6 rounded-3xl bg-rose-50 border-2 border-rose-100 flex items-center justify-between group">
                          <div className="space-y-1">
                            <p className="text-[10px] font-black text-rose-600 uppercase tracking-widest flex items-center gap-1.5 font-sans">
                              <TrendingDown className="w-3 h-3" />
                              আজকের ব্যয় (COSTING)
                            </p>
                            <h4 className="text-2xl font-black text-rose-900">
                              ৳ {formatBanglaAmount(totalCosting)}
                            </h4>
                          </div>
                        </div>
                      </div>

                      {/* Closing Balance Card */}
                      <div className="p-8 rounded-[38px] bg-slate-900 text-white flex flex-col items-center justify-center text-center space-y-3 shadow-2xl relative overflow-hidden">
                        <div className="absolute top-0 left-0 w-full h-full bg-gradient-to-br from-indigo-500/20 to-transparent opacity-50" />
                        <p className="text-[11px] font-black uppercase tracking-[0.3em] text-white/50 relative z-10">
                          বর্তমান মোট স্থিতি (NET BALANCE)
                        </p>
                        <h2 className="text-4xl font-black tracking-tight relative z-10">
                          ৳ {formatBanglaAmount(currentClosing)}
                        </h2>
                      </div>
                    </div>

                    <div className="pt-8 border-t border-slate-100 flex items-center justify-center gap-2 text-slate-400">
                      <Clock className="w-3.5 h-3.5" />
                      <p className="text-[9px] font-black uppercase tracking-widest">
                        সময়: {toBanglaNumeral(format(new Date(), "hh:mm a"))} —
                        তারিখ: {toBanglaNumeral(format(new Date(), "dd/MM/yyyy"))}
                      </p>
                    </div>
                  </div>
                )}
              </div>
            </motion.div>
          </div>
        )}
      </AnimatePresence>
    </>
  );
}
