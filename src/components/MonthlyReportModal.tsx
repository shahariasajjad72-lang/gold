"use client";

import { useState, useEffect, useRef } from "react";
import {
  X,
  Printer,
  Calendar,
  Clock,
  Download,
  FileText,
  Table as TableIcon,
} from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { format } from "date-fns";
import { cn } from "@/lib/utils";
import {
  getMonthlyDailyBreakdown,
  getMonthById,
} from "@/lib/actions";
import {
  formatBanglaDate,
  toBanglaNumeral,
  formatBanglaAmount,
} from "@/lib/utils/bangla-date";

interface MonthlyReportModalProps {
  monthId: number;
  isOpen: boolean;
  onClose: () => void;
}

export default function MonthlyReportModal({
  monthId,
  isOpen,
  onClose,
}: MonthlyReportModalProps) {
  const [reportData, setReportData] = useState<any[]>([]);
  const [monthData, setMonthData] = useState<any>(null);
  const [isLoading, setIsLoading] = useState(false);
  const [isCapturing, setIsCapturing] = useState(false);
  const reportAreaRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (isOpen) {
      fetchReportData();
    }
  }, [isOpen, monthId]);

  const fetchReportData = async () => {
    setIsLoading(true);
    const mData = await getMonthById(monthId);
    setMonthData(mData);
    const data = await getMonthlyDailyBreakdown(monthId);
    setReportData(data);
    setIsLoading(false);
  };

  const handlePrint = () => {
    const node = reportAreaRef.current;
    if (!node) return;

    const printWindow = window.open("", "_blank", "width=1000,height=800");
    if (!printWindow) return;

    printWindow.document.write(`<!DOCTYPE html>
<html lang="bn">
<head>
  <meta charset="UTF-8" />
  <title>মাসিক হিসাব বিবরণী - ${monthData?.name}</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Serif+Bengali:wght@400;700;900&display=swap');
    body { font-family: 'Noto Serif Bengali', serif; padding: 10mm; background: white; color: black; }
    table { width: 100%; border-collapse: collapse; margin-bottom: 5px; table-layout: fixed; }
    th, td { border: 1px solid black; padding: 4px 6px; font-size: 11px; text-align: left; overflow: hidden; word-break: break-word; }
    .text-right { text-align: right; }
    .font-bold { font-weight: bold; }
    .bg-dark { background: #1e293b; color: white; }
    .header { text-align: center; margin-bottom: 20px; border-bottom: 3px double black; padding-bottom: 10px; }
    .no-print { display: none !important; }
    @media print { @page { size: A4 portrait; margin: 0; } }
  </style>
</head>
<body>
  ${node.innerHTML}
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
    const node = document.getElementById("monthly-report-area");
    if (!node) return;

    setIsCapturing(true);
    setTimeout(async () => {
      try {
        const { toPng } = await import("html-to-image");
        const dataUrl = await toPng(node, {
          quality: 1.0,
          backgroundColor: "#ffffff",
          pixelRatio: 2,
        });

        const link = document.createElement("a");
        link.download = `মাসিক-রিপোর্ট-${monthData?.name || "report"}.png`;
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
          <div className="fixed inset-0 z-50 flex items-center justify-center p-2 sm:p-4">
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
              className="relative w-full max-w-6xl max-h-[92vh] bg-white dark:bg-black rounded-[32px] border border-border shadow-2xl overflow-hidden flex flex-col"
            >
              {/* Header Actions */}
              <div className="flex items-center justify-between px-6 py-4 border-b border-border no-print shrink-0 bg-slate-50 dark:bg-zinc-900/50">
                <h2 className="text-base font-black tracking-tight text-slate-800 dark:text-zinc-200 flex items-center gap-2">
                  <FileText className="w-5 h-5 text-indigo-500" />
                  পুরো মাসের হিসাব বিবরণী
                </h2>
                <div className="flex items-center gap-2">
                  <button
                    onClick={handleSaveImage}
                    disabled={isCapturing}
                    className="flex items-center gap-1.5 px-4 py-2 text-[11px] font-bold rounded-xl bg-indigo-50 text-indigo-700 hover:bg-indigo-100 transition-colors"
                  >
                    <Download className="w-4 h-4" />
                    ছবিতে সংরক্ষণ
                  </button>
                  <button
                    onClick={handlePrint}
                    className="flex items-center gap-1.5 px-4 py-2 text-[11px] font-bold rounded-xl bg-slate-100 text-slate-700 hover:bg-slate-200 transition-colors"
                  >
                    <Printer className="w-4 h-4" />
                    প্রিন্ট
                  </button>
                  <button
                    onClick={onClose}
                    className="p-2 rounded-xl bg-rose-50 text-rose-600 hover:bg-rose-100 transition-colors ml-2"
                  >
                    <X className="w-5 h-5" />
                  </button>
                </div>
              </div>

              <div className="flex-1 overflow-y-auto custom-scrollbar p-6 lg:p-10">
                {isLoading ? (
                  <div className="flex flex-col items-center justify-center py-20 space-y-4">
                    <div className="w-10 h-10 border-4 border-indigo-500/20 border-t-indigo-500 rounded-full animate-spin" />
                    <p className="text-sm font-bold text-slate-400 uppercase tracking-widest">
                      ডাটা লোড হচ্ছে...
                    </p>
                  </div>
                ) : (
                  <div
                    id="monthly-report-area"
                    ref={reportAreaRef}
                    className="space-y-8 bg-white dark:bg-black min-h-full"
                  >
                    {/* Professional Company Header */}
                    <div className="text-center space-y-2 border-b-2 border-slate-900 pb-6">
                      <h1 className="text-xl sm:text-3xl font-black text-slate-900 dark:text-white uppercase tracking-tight">
                        বাংলা গোল্ড (প্রাঃ) লিমিটেড
                      </h1>
                      <div className="flex flex-col items-center gap-1">
                        <p className="text-sm font-bold text-slate-600 dark:text-slate-400">
                          {monthData?.name} {toBanglaNumeral(monthData?.year)} মাসিক হিসাব বিবরণী (MONTHLY STATEMENT)
                        </p>
                        <div className="h-px w-40 bg-slate-300 dark:bg-zinc-700" />
                      </div>
                    </div>

                    <div className="overflow-hidden rounded-3xl border-2 border-slate-900 shadow-sm">
                      <div className="overflow-x-auto custom-scrollbar w-full">
                        <table className="w-full text-left border-collapse table-fixed min-w-[500px]">
                          <thead>
                          <tr className="bg-slate-900 text-white">
                            <th className="px-4 py-3 font-black uppercase tracking-widest text-[10px] w-1/5 border-r border-slate-700">তারিখ</th>
                            <th className="px-4 py-3 font-black uppercase tracking-widest text-[10px] w-1/5 border-r border-slate-700 text-right">আগের স্থিতি</th>
                            <th className="px-4 py-3 font-black uppercase tracking-widest text-[10px] w-1/5 border-r border-slate-700 text-right">আয়</th>
                            <th className="px-4 py-3 font-black uppercase tracking-widest text-[10px] w-1/5 border-r border-slate-700 text-right">ব্যয়</th>
                            <th className="px-4 py-3 font-black uppercase tracking-widest text-[10px] w-1/5 text-right">বর্তমান স্থিতি</th>
                          </tr>
                        </thead>
                        <tbody className="divide-y divide-slate-100">
                          {reportData.map((day, idx) => (
                            <tr key={idx} className="hover:bg-slate-50 transition-colors even:bg-slate-50/30">
                              <td className="px-4 py-3 font-black text-xs border-r border-slate-100">
                                {formatBanglaDate(day.date)}
                              </td>
                              <td className="px-4 py-3 font-bold text-sm text-right border-r border-slate-100 text-slate-500">
                                {formatBanglaAmount(day.opening)}
                              </td>
                              <td className="px-4 py-3 font-black text-sm text-right border-r border-slate-100 text-emerald-600">
                                + {formatBanglaAmount(day.income)}
                              </td>
                              <td className="px-4 py-3 font-black text-sm text-right border-r border-slate-100 text-rose-600">
                                - {formatBanglaAmount(day.costing)}
                              </td>
                              <td className="px-4 py-3 font-black text-base text-right bg-slate-50/50">
                                {formatBanglaAmount(day.closing)}
                              </td>
                            </tr>
                          ))}
                        </tbody>
                        <tfoot className="border-t-4 border-slate-900">
                          <tr className="bg-slate-900 text-white">
                            <td colSpan={4} className="px-6 py-4 text-right font-black uppercase tracking-[0.2em] text-[10px]">
                              মাসের চূড়ান্ত স্থিতি (FINAL CLOSING BALANCE):
                            </td>
                            <td className="px-6 py-4 text-right font-black text-xl">
                              ৳ {formatBanglaAmount(reportData[reportData.length - 1]?.closing || 0)}
                            </td>
                          </tr>
                        </tfoot>
                      </table>
                      </div>
                    </div>

                    <div className="flex flex-col sm:flex-row justify-between items-end gap-8 pt-12 border-t border-slate-200 border-dashed">
                      <div className="flex gap-8 sm:gap-20 text-[9px] font-black uppercase tracking-[0.3em] text-slate-400 w-full sm:w-auto justify-between sm:justify-start">
                        <div className="space-y-12">
                          <div className="border-t-2 border-slate-900 pt-2 text-center px-4">হিসাব রক্ষক</div>
                        </div>
                        <div className="space-y-12">
                          <div className="border-t-2 border-slate-900 pt-2 text-center px-4">পরিচালক</div>
                        </div>
                      </div>
                      <div className="text-[9px] text-slate-400 font-bold uppercase flex items-center gap-1.5 italic">
                        <Clock className="w-3 h-3" />
                        রিপোর্ট তৈরির সময়: {toBanglaNumeral(format(new Date(), "dd-MM-yyyy hh:mm a"))}
                      </div>
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
