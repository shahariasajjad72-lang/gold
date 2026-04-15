"use client";

import { useState, useEffect, useMemo, useRef } from "react";
import {
  X,
  Printer,
  Calendar,
  Trash2,
  Edit2,
  Check,
  TrendingUp,
  TrendingDown,
  Clock,
  Download,
} from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { format } from "date-fns";
import { cn } from "@/lib/utils";
import {
  getDailyTransactions,
  deleteTransaction,
  updateTransaction,
  getMonthById,
  getMonthlyStatsBeforeDate,
} from "@/lib/actions";
import {
  formatBanglaDate,
  toBanglaNumeral,
  formatBanglaAmount,
} from "@/lib/utils/bangla-date";
import { useRouter } from "next/navigation";
import { getSuggestions } from "@/lib/constants";

// Helper to shorten long category names professionally
const shortenCategory = (name: string) => {
  if (!name) return "";

  const dateMatch = name.match(/\(.*\)/);
  const dateStr = dateMatch ? ` ${dateMatch[0]}` : "";

  let baseName = name.replace(/\(.*\)/, "").trim();

  const mapping: Record<string, string> = {
    "ইলেক্ট্রিক ও অফিস বিভিন্ন ইলেক্ট্রিক, কম্পিউটার, প্রিন্টার-এর যাবতীয় যন্ত্রাংশ ক্রয় ও মেরামত":
      "অফিস ও ইলেক্ট্রিক মেরামত",
    "পরিচালক মাসিক সম্মানী প্রদান": "পরিচালকের সম্মানী",
    "বাইতুল মোকারাম অফিস খরচ": "বাইতুল মোকারাম খরচ",
    "মাসিক বেতন প্রদান (স্টাফ ক্লিনার)": "স্টাফ ক্লিনার বেতন",
    "মাসিক বেতন প্রদান (স্টাফ ক্লিনার/দারোয়ান)": "স্টাফ বেতন (ক্লিনার)",
    "ভাট বিক্রয় হতে আয়": "ভাট বিক্রয় আয়",
    "রিফাইনিং প্রোজেক্ট ভাড়া নেওয়া বাবধ পাওনা ক্রিতহ টাকা":
      "রিফাইনিং প্রজেক্ট ভাড়া",
  };

  for (const [long, short] of Object.entries(mapping)) {
    if (baseName.includes(long) || long.includes(baseName)) {
      baseName = short;
      break;
    }
  }

  return baseName + dateStr;
};

// Helper to truncate long strings to a word limit for UI chips
const truncateToWords = (str: string, limit: number = 3) => {
  if (!str) return "";
  const words = str.split(" ").filter((w) => w.trim().length > 0);
  if (words.length <= limit) return str;
  return words.slice(0, limit).join(" ") + "...";
};

interface Transaction {
  id: number;
  date: Date;
  description: string;
  amount: number;
  weight: string | null;
  category: string;
  type: "income" | "costing";
}

interface DailyReportModalProps {
  monthId: number;
  isOpen: boolean;
  onClose: () => void;
}

export default function DailyReportModal({
  monthId,
  isOpen,
  onClose,
}: DailyReportModalProps) {
  const router = useRouter();
  const [selectedDate, setSelectedDate] = useState(
    format(new Date(), "yyyy-MM-dd"),
  );
  const [transactions, setTransactions] = useState<Transaction[]>([]);
  const [monthData, setMonthData] = useState<any>(null);
  const [carryBalance, setCarryBalance] = useState(0);
  const [isLoading, setIsLoading] = useState(false);
  const [isCapturing, setIsCapturing] = useState(false);
  const [view, setView] = useState<"select" | "report">("select");

  const [editingId, setEditingId] = useState<number | null>(null);
  const [editDesc, setEditDesc] = useState("");
  const [editAmount, setEditAmount] = useState("");
  const reportAreaRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (!isOpen) {
      setView("select");
      setTransactions([]);
      setEditingId(null);
    }
  }, [isOpen]);

  const fetchDailyData = async () => {
    setIsLoading(true);

    const month = await getMonthById(monthId);
    setMonthData(month);

    const statsBefore = await getMonthlyStatsBeforeDate(monthId, selectedDate);
    const opening = month?.openingBalance || 0;
    const carry = opening + statsBefore.totalIncome - statsBefore.totalCosting;
    setCarryBalance(carry);

    const data = await getDailyTransactions(monthId, selectedDate);
    setTransactions(data as any);

    setIsLoading(false);
    setView("report");
  };

  const incomeTransactions = useMemo(
    () => transactions.filter((t) => t.type === "income"),
    [transactions],
  );

  const costingTransactions = useMemo(
    () => transactions.filter((t) => t.type === "costing"),
    [transactions],
  );

  const totalIncome = incomeTransactions.reduce((sum, t) => sum + t.amount, 0);
  const totalCosting = costingTransactions.reduce(
    (sum, t) => sum + t.amount,
    0,
  );

  const handleDelete = async (id: number) => {
    if (!confirm("Are you sure?")) return;
    const res = await deleteTransaction(id, monthId);
    if (res.success) {
      setTransactions((prev) => prev.filter((t) => t.id !== id));
      router.refresh();
    }
  };

  const handleSaveEdit = async (id: number) => {
    const transaction = transactions.find((t) => t.id === id);
    if (!transaction) return;

    const res = await updateTransaction(id, monthId, {
      description: editDesc,
      amount: parseInt(editAmount),
      date: new Date(transaction.date),
      weight: transaction.weight || undefined,
    });

    if (res.success) {
      setTransactions((prev) =>
        prev.map((t) =>
          t.id === id
            ? { ...t, description: editDesc, amount: parseInt(editAmount) }
            : t,
        ),
      );
      setEditingId(null);
      router.refresh();
    }
  };

  const startEditing = (t: Transaction) => {
    setEditingId(t.id);
    setEditDesc(t.description);
    setEditAmount(t.amount.toString());
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
  <title>দৈনিক আর্থিক বিবরণী - ${selectedDate}</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Serif+Bengali:wght@400;700;900&display=swap');
    body { font-family: 'Noto Serif Bengali', serif; padding: 10mm; background: white; color: black; }
    table { width: 100%; border-collapse: collapse; margin-bottom: 5px; table-layout: fixed; }
    th, td { border: 1px solid black; padding: 4px 6px; font-size: 11px; text-align: left; overflow: hidden; word-break: break-word; }
    .text-right { text-align: right; }
    .font-bold { font-weight: bold; }
    .header { text-align: center; margin-bottom: 15px; border-bottom: 2px solid black; padding-bottom: 8px; }
    .no-print { display: none !important; }
    .section-title { background: #f3f4f6; font-weight: 900; font-size: 10px; display: flex; justify-content: space-between; align-items: center; padding: 4px 8px; border: 1px solid black; }
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
    const node = document.getElementById("report-capture-area");
    if (!node) return;

    setIsCapturing(true);

    // Give React a tick to apply 'isCapturing' state before taking the screenshot
    setTimeout(async () => {
      try {
        const { toPng } = await import("html-to-image");

        const dataUrl = await toPng(node, {
          quality: 1.0,
          backgroundColor: "#ffffff",
          pixelRatio: 2, // High resolution
          filter: (el) => {
            // Exclude anything with 'no-print' class during capture manually if needed,
            // though we hide them conditionally via isCapturing state.
            if (el.classList && el.classList.contains("no-print")) return false;
            return true;
          },
        });

        const link = document.createElement("a");
        link.download = `দৈনিক-রিপোর্ট-${selectedDate}.png`;
        link.href = dataUrl;
        link.click();
      } catch (err) {
        console.error("Failed to save image", err);
        alert("Image saving failed.");
      } finally {
        setIsCapturing(false);
      }
    }, 100);
  };

  return (
    <>
      <AnimatePresence>
        {isOpen && (
          <div
            key="daily-report-drawer"
            className="fixed inset-0 z-50 flex items-center justify-center p-2 sm:p-4"
          >
            {/* Backdrop */}
            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              exit={{ opacity: 0 }}
              onClick={onClose}
              className="absolute inset-0 bg-background/80 backdrop-blur-sm no-print"
            />

            {/* Modal Content */}
            <motion.div
              initial={{ opacity: 0, scale: 0.95, y: 20 }}
              animate={{ opacity: 1, scale: 1, y: 0 }}
              exit={{ opacity: 0, scale: 0.95, y: 20 }}
              className={cn(
                "relative w-full bg-white dark:bg-black rounded-[24px] border border-border shadow-2xl overflow-hidden flex flex-col",
                view === "select"
                  ? "max-w-md h-auto"
                  : "max-w-[1550px] max-h-[98vh]", // Expand for up to 12 rows
              )}
            >
              {/* Header Actions (Always outside capture area so they don't get saved) */}
              <div className="flex items-center justify-between px-6 py-3 border-b border-border no-print shrink-0 bg-slate-50 dark:bg-zinc-900/50">
                <h2 className="text-[15px] font-black tracking-tight text-slate-800 dark:text-zinc-200">
                  {view === "select" ? "দৈনিক রিপোর্ট" : "আর্থিক বিবরণী"}
                </h2>
                <div className="flex items-center gap-2.5">
                  {view === "report" && (
                    <>
                      <button
                        onClick={handleSaveImage}
                        disabled={isCapturing}
                        className="flex items-center gap-1.5 px-3 py-1.5 text-[11px] font-bold rounded-lg bg-indigo-50 text-indigo-700 hover:bg-indigo-100 dark:bg-indigo-900/30 dark:text-indigo-400 transition-colors"
                        title="ছবি হিসেবে সেভ করুন"
                      >
                        <Download className="w-3.5 h-3.5" />
                        সংরক্ষণ
                      </button>
                      <button
                        onClick={handlePrint}
                        className="flex items-center gap-1.5 px-3 py-1.5 text-[11px] font-bold rounded-lg bg-slate-100 text-slate-700 hover:bg-slate-200 dark:bg-zinc-800 dark:text-zinc-300 transition-colors"
                        title="প্রিন্ট করুন"
                      >
                        <Printer className="w-3.5 h-3.5" />
                        প্রিন্ট
                      </button>
                    </>
                  )}
                  <div className="w-px h-5 bg-border mx-1" />
                  <button
                    onClick={onClose}
                    className="p-1.5 rounded-lg bg-rose-50 text-rose-600 hover:bg-rose-100 dark:bg-rose-900/20 dark:text-rose-400 transition-colors"
                  >
                    <X className="w-4 h-4" />
                  </button>
                </div>
              </div>

              {/* Scrollable / Capable Area */}
              <div className="flex-1 overflow-y-auto custom-scrollbar">
                {view === "select" ? (
                  <div className="space-y-4 p-6">
                    <div className="p-4 rounded-xl bg-slate-50 dark:bg-zinc-900/50 border border-border text-center">
                      <Calendar className="w-8 h-8 mx-auto mb-2 text-slate-400" />
                      <p className="text-xs font-bold text-slate-500 uppercase tracking-wider">
                        তারিখ নির্বাচন করুন
                      </p>
                    </div>

                    <input
                      type="date"
                      value={selectedDate}
                      onChange={(e) => setSelectedDate(e.target.value)}
                      className="w-full bg-background border-2 border-slate-200 dark:border-zinc-800 rounded-xl px-4 py-3 text-sm font-bold outline-none focus:border-slate-800 dark:focus:border-zinc-400 transition-all"
                    />

                    <button
                      onClick={fetchDailyData}
                      disabled={isLoading}
                      className="w-full py-4 rounded-xl bg-slate-900 text-white dark:bg-white dark:text-black font-black uppercase tracking-widest text-xs disabled:opacity-50 hover:bg-slate-800 transition-colors shadow-lg shadow-slate-900/20"
                    >
                      {isLoading ? "লোড হচ্ছে..." : "রিপোর্ট তৈরি করুন"}
                    </button>
                  </div>
                ) : (
                  /* THIS IS THE AREA WE CAPTURE FOR SCREENSHOT */
                  <div
                    id="report-capture-area"
                    ref={reportAreaRef}
                    className="p-6 lg:p-8 report-content print:space-y-6 flex flex-col justify-between min-h-full bg-white dark:bg-black"
                  >
                    <div className="space-y-4 lg:space-y-5 flex-1">
                      {/* Professional Company Header */}
                      <div className="text-center pb-4 border-b-2 border-slate-900 dark:border-zinc-600 relative">
                        <h1 className="text-2xl lg:text-[32px] font-black tracking-tight text-slate-900 dark:text-white mb-1 uppercase">
                          বাংলা গোল্ড (প্রাঃ) লিমিটেড
                        </h1>
                        <p className="text-[11px] font-bold text-slate-500 dark:text-zinc-400 uppercase tracking-[0.5em] mb-2">
                          দৈনিক আর্থিক বিবরণী (DAILY STATEMENT)
                        </p>
                        <div className="flex items-center justify-center gap-4 text-[10px] font-black uppercase tracking-widest text-slate-400">
                          <span>তারিখ: {formatBanglaDate(new Date(selectedDate))}</span>
                          <span className="opacity-30">|</span>
                          <span>DATE: {format(new Date(selectedDate), "dd MMMM yyyy")}</span>
                        </div>
                      </div>

                      {/* Financial Ledger Tables (Grid 42% 58%) */}
                      <div className="grid grid-cols-1 lg:grid-cols-[42%_58%] gap-4 lg:gap-5 print:grid-cols-2 print:gap-4 items-start">
                        {/* --- INCOME SECTION --- */}
                        <div className="space-y-0 text-slate-900 dark:text-zinc-100 border-2 border-slate-900 dark:border-zinc-800 rounded-xl overflow-hidden shadow-sm flex flex-col">
                          <div className="flex items-center justify-between px-3 py-1.5 bg-slate-900 text-white dark:bg-zinc-800 shrink-0 border-b border-slate-900">
                            <h3 className="text-[11px] font-black uppercase tracking-[0.1em]">
                              ব্যাবসায়িক আয় (REVENUE)
                            </h3>
                            <TrendingUp className="w-3 h-3 text-emerald-400" />
                          </div>

                          <div className="overflow-x-auto custom-scrollbar w-full">
                            <table className="w-full text-sm text-left border-collapse table-fixed bg-white dark:bg-black min-w-[340px]">
                              <thead className="bg-[#f8fafc] dark:bg-zinc-900/80">
                              <tr>
                                <th className="px-2 py-[5px] font-black uppercase text-slate-600 dark:text-zinc-400 border-b border-slate-300 dark:border-zinc-700 border-r w-[33%] text-[11px]">
                                  খাত
                                </th>
                                <th className="px-2 py-[5px] font-black uppercase text-slate-600 dark:text-zinc-400 border-b border-slate-300 dark:border-zinc-700 border-r w-[42%] text-[11px]">
                                  বিবরণ
                                </th>
                                <th className="px-2 py-[5px] font-black uppercase text-slate-600 dark:text-zinc-400 border-b border-slate-300 dark:border-zinc-700 text-right w-[25%] text-[11px]">
                                  টাকা
                                </th>
                                {!isCapturing && (
                                  <th className="px-1 py-[5px] no-print border-b border-slate-300 w-8"></th>
                                )}
                              </tr>
                            </thead>
                            <tbody className="divide-y divide-slate-200 dark:divide-zinc-800">
                              {incomeTransactions.length > 0 ? (
                                incomeTransactions.map((t, idx) => (
                                  <tr
                                    key={`income-${t.id || idx}`}
                                    className="group hover:bg-slate-50/80 dark:hover:bg-zinc-900/50 transition-colors even:bg-[#fcfdfd] dark:even:bg-zinc-900/20"
                                  >
                                    <td className="px-2 py-1.5 font-bold border-r border-slate-200 dark:border-zinc-800 leading-tight break-words text-[12.5px] lg:text-[13.5px]">
                                      {shortenCategory(t.category)}
                                    </td>
                                    <td className="px-2 py-1.5 border-r border-slate-200 dark:border-zinc-800 leading-tight break-words text-[12.5px] lg:text-[13.5px]">
                                      {editingId === t.id && !isCapturing ? (
                                        <div className="space-y-1">
                                          <input
                                            value={editDesc}
                                            onChange={(e) =>
                                              setEditDesc(e.target.value)
                                            }
                                            className="w-full bg-slate-100 dark:bg-zinc-900 border border-slate-300 dark:border-zinc-700 rounded px-1.5 py-1 text-xs outline-none focus:border-indigo-500 transition-colors"
                                          />
                                          <div className="flex flex-wrap gap-1">
                                            {getSuggestions(t.category).map((sug) => (
                                              <button
                                                key={sug}
                                                type="button"
                                                onClick={() => setEditDesc(sug)}
                                                className="px-1.5 py-0.5 rounded bg-white dark:bg-zinc-800 border border-slate-200 dark:border-zinc-700 text-[9px] font-bold text-slate-500 hover:text-slate-900 dark:hover:text-zinc-200 hover:border-slate-400 transition-all active:scale-95 text-left"
                                                title={sug}
                                              >
                                                {truncateToWords(sug, 3)}
                                              </button>
                                            ))}
                                          </div>
                                        </div>
                                      ) : (
                                        <span>{t.description}</span>
                                      )}
                                    </td>
                                    <td className="px-2 py-1.5 text-right font-black text-slate-900 dark:text-zinc-100 text-[13px] lg:text-[14px]">
                                      {editingId === t.id && !isCapturing ? (
                                        <input
                                          type="number"
                                          value={editAmount}
                                          onChange={(e) =>
                                            setEditAmount(e.target.value)
                                          }
                                          className="w-full bg-slate-100 dark:bg-zinc-900 border border-slate-300 rounded px-1.5 py-1 text-right text-xs"
                                        />
                                      ) : (
                                        formatBanglaAmount(t.amount)
                                      )}
                                    </td>
                                    {!isCapturing && (
                                      <td className="px-1 py-1 text-right no-print w-8">
                                        <div
                                          className={cn(
                                            "flex flex-col items-center justify-center gap-1 transition-opacity",
                                            editingId === t.id
                                              ? "opacity-100"
                                              : "opacity-0 group-hover:opacity-100",
                                          )}
                                        >
                                          {editingId === t.id ? (
                                            <>
                                              <button
                                                onClick={() =>
                                                  handleSaveEdit(t.id)
                                                }
                                                className="p-1 bg-emerald-500 hover:bg-emerald-600 rounded text-white"
                                              >
                                                <Check className="w-2.5 h-2.5" />
                                              </button>
                                              <button
                                                onClick={() =>
                                                  setEditingId(null)
                                                }
                                                className="p-1 bg-rose-500 hover:bg-rose-600 rounded text-white"
                                              >
                                                <X className="w-2.5 h-2.5" />
                                              </button>
                                            </>
                                          ) : (
                                            <button
                                              onClick={() => startEditing(t)}
                                              className="p-1.5 hover:bg-slate-200 rounded text-slate-600"
                                            >
                                              <Edit2 className="w-2.5 h-2.5" />
                                            </button>
                                          )}
                                        </div>
                                      </td>
                                    )}
                                  </tr>
                                ))
                              ) : (
                                <tr>
                                  <td
                                    colSpan={isCapturing ? 3 : 4}
                                    className="px-2 py-6 text-center text-slate-400 italic text-sm"
                                  >
                                    কোন আয় পাওয়া যায়নি
                                  </td>
                                </tr>
                              )}
                            </tbody>
                            <tfoot className="border-t-2 border-slate-900 dark:border-zinc-700 bg-slate-50 dark:bg-zinc-900/30">
                              <tr className="border-b border-slate-200 dark:border-zinc-800">
                                <td
                                  colSpan={2}
                                  className="px-2 py-2 text-right uppercase tracking-[0.1em] text-[10px] sm:text-[11px] font-bold text-blue-800 dark:text-blue-400 border-r border-slate-200 dark:border-zinc-800"
                                >
                                  আগের দিনের আয়:
                                </td>
                                <td className="px-2 py-2 text-right text-blue-900 dark:text-blue-300 font-black text-sm">
                                  ৳ {formatBanglaAmount(carryBalance)}
                                </td>
                                {!isCapturing && <td className="no-print"></td>}
                              </tr>
                              <tr className="bg-[#effdf5] dark:bg-emerald-950/20">
                                <td
                                  colSpan={2}
                                  className="px-2 py-2 text-right uppercase tracking-[0.1em] text-[10px] sm:text-[11px] font-black text-emerald-800 dark:text-emerald-400 border-r border-emerald-200 dark:border-zinc-800"
                                >
                                  মোট (TOTAL REV)
                                </td>
                                <td className="px-2 py-2 text-right text-emerald-900 dark:text-emerald-300 font-black text-[15px]">
                                  ৳ {formatBanglaAmount(totalIncome)}
                                </td>
                                {!isCapturing && <td className="no-print"></td>}
                              </tr>
                            </tfoot>
                          </table>
                          </div>
                        </div>

                        {/* --- COSTING SECTION --- */}
                        <div className="space-y-0 text-slate-900 dark:text-zinc-100 border-2 border-slate-900 dark:border-zinc-800 rounded-xl overflow-hidden shadow-sm flex flex-col">
                          <div className="flex items-center justify-between px-3 py-1.5 bg-slate-900 text-white dark:bg-zinc-800 shrink-0 border-b border-slate-900">
                            <h3 className="text-[11px] font-black uppercase tracking-[0.1em]">
                              ব্যাবসায়িক ব্যয় (EXPENSES)
                            </h3>
                            <TrendingDown className="w-3 h-3 text-rose-400" />
                          </div>

                          <div className="overflow-x-auto custom-scrollbar w-full">
                            <table className="w-full text-sm text-left border-collapse table-fixed bg-white dark:bg-black min-w-[340px]">
                              <thead className="bg-[#f8fafc] dark:bg-zinc-900/80">
                              <tr>
                                <th className="px-2 py-[5px] font-black uppercase text-slate-600 dark:text-zinc-400 border-b border-slate-300 dark:border-zinc-700 border-r w-[33%] text-[11px]">
                                  খাত
                                </th>
                                <th className="px-2 py-[5px] font-black uppercase text-slate-600 dark:text-zinc-400 border-b border-slate-300 dark:border-zinc-700 border-r w-[42%] text-[11px]">
                                  বিবরণ
                                </th>
                                <th className="px-2 py-[5px] font-black uppercase text-slate-600 dark:text-zinc-400 border-b border-slate-300 dark:border-zinc-700 text-right w-[25%] text-[11px]">
                                  টাকা
                                </th>
                                {!isCapturing && (
                                  <th className="px-1 py-[5px] no-print border-b border-slate-300 w-8"></th>
                                )}
                              </tr>
                            </thead>
                            <tbody className="divide-y divide-slate-200 dark:divide-zinc-800">
                              {costingTransactions.length > 0 ? (
                                costingTransactions.map((t, idx) => (
                                  <tr
                                    key={`costing-${t.id || idx}`}
                                    className="group hover:bg-slate-50/80 dark:hover:bg-zinc-900/50 transition-colors even:bg-[#fcfdfd] dark:even:bg-zinc-900/20"
                                  >
                                    <td className="px-2 py-1.5 font-bold border-r border-slate-200 dark:border-zinc-800 leading-tight break-words text-[12.5px] lg:text-[13.5px]">
                                      {shortenCategory(t.category)}
                                    </td>
                                    <td className="px-2 py-1.5 border-r border-slate-200 dark:border-zinc-800 leading-tight break-words text-[12.5px] lg:text-[13.5px]">
                                      {editingId === t.id && !isCapturing ? (
                                        <div className="space-y-1">
                                          <input
                                            value={editDesc}
                                            onChange={(e) =>
                                              setEditDesc(e.target.value)
                                            }
                                            className="w-full bg-slate-100 dark:bg-zinc-900 border border-slate-300 dark:border-zinc-700 rounded px-1.5 py-1 text-xs outline-none focus:border-indigo-500 transition-colors"
                                          />
                                          <div className="flex flex-wrap gap-1">
                                            {getSuggestions(t.category).map((sug) => (
                                              <button
                                                key={sug}
                                                type="button"
                                                onClick={() => setEditDesc(sug)}
                                                className="px-1.5 py-0.5 rounded bg-white dark:bg-zinc-800 border border-slate-200 dark:border-zinc-700 text-[9px] font-bold text-slate-500 hover:text-slate-900 dark:hover:text-zinc-200 hover:border-slate-400 transition-all active:scale-95 text-left"
                                                title={sug}
                                              >
                                                {truncateToWords(sug, 3)}
                                              </button>
                                            ))}
                                          </div>
                                        </div>
                                      ) : (
                                        <span>{t.description}</span>
                                      )}
                                    </td>
                                    <td className="px-2 py-1.5 text-right font-black text-slate-900 dark:text-zinc-100 text-[13px] lg:text-[14px]">
                                      {editingId === t.id && !isCapturing ? (
                                        <input
                                          type="number"
                                          value={editAmount}
                                          onChange={(e) =>
                                            setEditAmount(e.target.value)
                                          }
                                          className="w-full bg-slate-100 dark:bg-zinc-900 border border-slate-300 rounded px-1.5 py-1 text-right text-xs"
                                        />
                                      ) : (
                                        formatBanglaAmount(t.amount)
                                      )}
                                    </td>
                                    {!isCapturing && (
                                      <td className="px-1 py-1 text-right no-print w-8">
                                        <div
                                          className={cn(
                                            "flex flex-col items-center justify-center gap-1 transition-opacity",
                                            editingId === t.id
                                              ? "opacity-100"
                                              : "opacity-0 group-hover:opacity-100",
                                          )}
                                        >
                                          {editingId === t.id ? (
                                            <>
                                              <button
                                                onClick={() =>
                                                  handleSaveEdit(t.id)
                                                }
                                                className="p-1 bg-emerald-500 hover:bg-emerald-600 rounded text-white"
                                              >
                                                <Check className="w-2.5 h-2.5" />
                                              </button>
                                              <button
                                                onClick={() =>
                                                  setEditingId(null)
                                                }
                                                className="p-1 bg-rose-500 hover:bg-rose-600 rounded text-white"
                                              >
                                                <X className="w-2.5 h-2.5" />
                                              </button>
                                            </>
                                          ) : (
                                            <button
                                              onClick={() => startEditing(t)}
                                              className="p-1.5 hover:bg-slate-200 rounded text-slate-600"
                                            >
                                              <Edit2 className="w-2.5 h-2.5" />
                                            </button>
                                          )}
                                        </div>
                                      </td>
                                    )}
                                  </tr>
                                ))
                              ) : (
                                <tr>
                                  <td
                                    colSpan={isCapturing ? 3 : 4}
                                    className="px-2 py-6 text-center text-slate-400 italic text-sm"
                                  >
                                    কোন ব্যয় পাওয়া যায়নি
                                  </td>
                                </tr>
                              )}
                            </tbody>
                            <tfoot className="border-t-2 border-slate-900 dark:border-zinc-700 bg-slate-50 dark:bg-zinc-900/30">
                              <tr className="bg-[#fff1f2] dark:bg-rose-950/20 border-b border-rose-200 dark:border-zinc-800">
                                <td
                                  colSpan={2}
                                  className="px-2 py-2 text-right uppercase tracking-[0.1em] text-[10px] sm:text-[11px] font-black text-rose-800 dark:text-rose-400 border-r border-rose-200 dark:border-zinc-800"
                                >
                                  মোট (TOTAL EXP)
                                </td>
                                <td className="px-2 py-2 text-right text-rose-900 dark:text-rose-300 font-black text-sm">
                                  ৳ {formatBanglaAmount(totalCosting)}
                                </td>
                                {!isCapturing && <td className="no-print"></td>}
                              </tr>
                              <tr className="bg-[#fffbeb] dark:bg-amber-950/20 border-b border-amber-200 dark:border-zinc-800">
                                <td
                                  colSpan={2}
                                  className="px-2 py-2 text-right uppercase tracking-[0.1em] text-[10px] sm:text-[11px] font-bold text-amber-800 dark:text-amber-400 border-r border-amber-200 dark:border-zinc-800"
                                >
                                  আজকের নীট আয়:
                                </td>
                                <td
                                  className={cn(
                                    "px-2 py-2 text-right font-black text-[13px]",
                                    totalIncome - totalCosting >= 0
                                      ? "text-emerald-700 dark:text-emerald-400"
                                      : "text-rose-700 dark:text-rose-400",
                                  )}
                                >
                                  {totalIncome - totalCosting >= 0 ? "+" : "-"}{" "}
                                  ৳{" "}
                                  {formatBanglaAmount(
                                    Math.abs(totalIncome - totalCosting),
                                  )}
                                </td>
                                {!isCapturing && <td className="no-print"></td>}
                              </tr>
                              <tr className="bg-slate-950 text-white dark:bg-white dark:text-black">
                                <td
                                  colSpan={2}
                                  className="px-2 py-2.5 text-right uppercase tracking-[0.15em] text-[10px] sm:text-[12px] font-black border-r border-slate-700/50"
                                >
                                  আজকের নীট স্থিতি (CLOSING):
                                </td>
                                <td className="px-2 py-2.5 text-right font-black text-[17px] tracking-tighter">
                                  ৳{" "}
                                  {formatBanglaAmount(
                                    carryBalance + totalIncome - totalCosting,
                                  )}
                                </td>
                                {!isCapturing && <td className="no-print"></td>}
                              </tr>
                            </tfoot>
                          </table>
                          </div>
                        </div>
                      </div>
                    </div>

                    {/* Signatures & Footer Logic (Pushed to bottom, minimal height constraints) */}
                    <div className="mt-8 pt-4 lg:pt-5 border-t-2 border-slate-900 border-dashed dark:border-zinc-600 relative shrink-0">
                      <div className="flex flex-col sm:flex-row justify-between items-end gap-6 sm:gap-2">
                        {/* Signatures */}
                        <div className="flex gap-16 lg:gap-24 text-[10px] font-black uppercase tracking-[0.2em] text-slate-500 dark:text-zinc-500 w-full sm:w-auto">
                          <div className="space-y-12">
                            <div className="border-t-2 border-slate-900 dark:border-zinc-500 pt-1.5 text-center px-4">
                              হিসাব রক্ষক (ACCOUNTANT)
                            </div>
                          </div>
                          <div className="space-y-12">
                            <div className="border-t-2 border-slate-900 dark:border-zinc-500 pt-1.5 text-center px-6">
                              পরিচালক (DIRECTOR)
                            </div>
                          </div>
                        </div>

                        {/* Timestamp */}
                        <div className="text-[9px] text-right text-slate-400 dark:text-zinc-600 font-bold uppercase tracking-widest flex items-center justify-end gap-1.5 shrink-0">
                          <Clock className="w-2.5 h-2.5" />
                          রিপোর্ট তৈরি:{" "}
                          {toBanglaNumeral(
                            format(new Date(), "dd/MM/yyyy HH:mm"),
                          )}
                        </div>
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
