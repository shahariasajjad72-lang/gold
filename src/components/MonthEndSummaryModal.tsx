"use client";

import { useState, useEffect, useRef } from "react";
import { X, Printer, Download, FileText } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { format } from "date-fns";
import { getMonthEndSummary, addTransaction } from "@/lib/actions";
import { INCOME_CATEGORIES, COSTING_CATEGORIES, BANK_CATEGORIES } from "@/lib/constants";
import { formatBanglaAmount, toBanglaNumeral } from "@/lib/utils/bangla-date";

interface MonthEndSummaryModalProps {
  monthId: number;
  isOpen: boolean;
  onClose: () => void;
}

const COMPANY_NAME = "বাংলা গোল্ড (প্রাঃ) লিমিটেড";

export default function MonthEndSummaryModal({ monthId, isOpen, onClose }: MonthEndSummaryModalProps) {
  const [summaryData, setSummaryData] = useState<any>(null);
  const [isLoading, setIsLoading] = useState(false);
  const [isCapturing, setIsCapturing] = useState(false);
  const printAreaRef = useRef<HTMLDivElement>(null);
  
  const [showAdjust, setShowAdjust] = useState(false);
  const [adjustData, setAdjustData] = useState({ category: "", description: "অ্যাডজাস্টমেন্ট এন্ট্রি (Missing Ref)", type: "costing" as "income" | "costing", amount: 0 });
  const [isAdjusting, setIsAdjusting] = useState(false);

  useEffect(() => {
    if (isOpen) fetchData();
  }, [isOpen, monthId]);

  const fetchData = async () => {
    setIsLoading(true);
    const data = await getMonthEndSummary(monthId);
    setSummaryData(data);
    setIsLoading(false);
  };

  const handleAdjustSubmit = async () => {
    if(!adjustData.category || adjustData.amount <= 0) return alert("Please fill category and amount properly");
    setIsAdjusting(true);
    await addTransaction({
      monthId,
      type: adjustData.type,
      category: adjustData.category,
      amount: adjustData.amount,
      date: new Date(),
      description: adjustData.description || "অ্যাডজাস্টমেন্ট এন্ট্রি",
    });
    setShowAdjust(false);
    setIsAdjusting(false);
    fetchData(); // reload stats
  };

  const handlePrint = () => {
    const node = printAreaRef.current;
    if (!node) return;

    const printWindow = window.open("", "_blank", "width=1000,height=800");
    if (!printWindow) return;

    printWindow.document.write(`<!DOCTYPE html>
<html lang="bn">
<head>
  <meta charset="UTF-8" />
  <title>মাস সমাপ্তি আর্থিক বিবরণী - ${month?.name}</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Serif+Bengali:wght@400;700;900&display=swap');
    body { font-family: 'Noto Serif Bengali', serif; padding: 10mm; background: white; color: black; }
    table { width: 100%; border-collapse: collapse; margin-bottom: 5px; table-layout: fixed; }
    th, td { border: 1px solid black; padding: 4px 6px; font-size: 11px; text-align: left; overflow: hidden; word-break: break-word; }
    .text-right { text-align: right; }
    .font-bold { font-weight: bold; }
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
    const node = printAreaRef.current;
    if (!node) return;

    setIsCapturing(true);

    // Give React a tick to apply 'isCapturing' state
    setTimeout(async () => {
      try {
        const { toPng } = await import("html-to-image");

        const dataUrl = await toPng(node, {
          quality: 1.0,
          backgroundColor: "#ffffff",
          pixelRatio: 2,
        });

        const link = document.createElement("a");
        link.download = `মাসিক-সারসংক্ষেপ-${month?.name || "report"}.png`;
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

  // Categories that are paid via bank and should NOT reduce the 'Cash Hand' (Net Balance)
  const BANK_SIDE_CATEGORIES = [
    "ব্যাংক এ যাবতীয় জমা (মাস-সাল)",
  ];

  // Categories that should not even appear in the PDF's Expense list
  const HIDDEN_FROM_LIST = [
    "ব্যাংক এ যাবতীয় জমা (মাস-সাল)"
  ];

  const { month, incomeByCategory, costingByCategory, bankCalculated } = summaryData || {};
  
  // Calculate total income from all actual categories received
  const totalIncome = Object.values(incomeByCategory || {}).reduce((s: number, v) => s + (v as number), 0);
  
  // 1. Total Costing for the PDF Table rows
  // This uses the actual values from the object to ensure nothing is missed
  const totalCosting = Object.entries(costingByCategory || {}).reduce((s: number, [cat, val]) => {
    if (HIDDEN_FROM_LIST.includes(cat)) return s;
    return s + (val as number);
  }, 0);

  const filteredCostingCategories = COSTING_CATEGORIES.filter(c => !HIDDEN_FROM_LIST.includes(c));

  const openingBankBalance = BANK_CATEGORIES.reduce((s, c) => s + (bankCalculated?.[c]?.opening || 0), 0);
  const closingBankBalance = BANK_CATEGORIES.reduce((s, c) => s + (bankCalculated?.[c]?.closing || 0), 0);
  
  const cashInitial = month?.openingBalance || 0;
  // Net Balance (Closing Cash) matches Database EXACTLY
  const cashClosing = month?.netBalance || 0;

  // Grand Total Left = Previous Month Assets (Bank + Cash) + Current Month Income
  const grandTotalIncome = totalIncome + (openingBankBalance + cashInitial);
  
  // Grand Total Right = Current Month Assets (Bank + Cash) + Current Month Expense
  const grandTotalCosting = totalCosting + (closingBankBalance + cashClosing);
  const maxRows = Math.max(INCOME_CATEGORIES.length, filteredCostingCategories.length);
  const incomeRows = [...INCOME_CATEGORIES, ...Array(Math.max(0, maxRows - INCOME_CATEGORIES.length)).fill("")];
  const costingRows = [...filteredCostingCategories, ...Array(Math.max(0, maxRows - filteredCostingCategories.length)).fill("")];

  const gap = grandTotalIncome - grandTotalCosting;
  const hasMismatch = Math.abs(gap) > 0;

  const ORDERED_BANKS = [
    "প্রিমিয়ার ব্যাংক",
    "ঢাকা ব্যাংক",
    ...BANK_CATEGORIES.filter(b => b !== "প্রিমিয়ার ব্যাংক" && b !== "ঢাকা ব্যাংক")
  ];

  // Shared table cell style strings for the printable area
  const td = (extra = "") => `border:1px solid #000;padding:2px 5px;font-size:10px;line-height:1.4;${extra}`;

  return (
    <AnimatePresence>
      {isOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-2 sm:p-4">
          <motion.div
            initial={{ opacity: 0 }} animate={{ opacity: 1 }} exit={{ opacity: 0 }}
            onClick={onClose}
            className="absolute inset-0 bg-black/60 backdrop-blur-sm"
          />

          <motion.div
            initial={{ opacity: 0, scale: 0.96, y: 24 }}
            animate={{ opacity: 1, scale: 1, y: 0 }}
            exit={{ opacity: 0, scale: 0.96, y: 24 }}
            transition={{ type: "spring", damping: 28, stiffness: 300 }}
            className="relative w-full max-w-5xl max-h-[94vh] bg-white dark:bg-zinc-950 rounded-3xl shadow-2xl overflow-hidden flex flex-col border border-amber-200/50"
          >
            {/* ─── Modal Header ─── */}
            <div className="flex items-center justify-between px-6 py-3.5 border-b border-amber-100 bg-gradient-to-r from-amber-50 to-orange-50 dark:from-zinc-900 dark:to-zinc-900 shrink-0">
              <div className="flex items-center gap-3">
                <div className="p-2 rounded-xl bg-amber-500 text-white shadow-sm shadow-amber-500/30">
                  <FileText className="w-4 h-4" />
                </div>
                <div>
                  <p className="text-[10px] font-black uppercase tracking-widest text-amber-600 dark:text-amber-400">Monthly Ledger</p>
                  <h2 className="text-sm font-black text-slate-800 dark:text-zinc-100">মাস সমাপ্তি আর্থিক বিবরণী</h2>
                </div>
              </div>
              <div className="flex items-center gap-2">
                <button onClick={handleSaveImage} disabled={isCapturing || isLoading}
                  className="flex items-center gap-1.5 px-4 py-2 text-[11px] font-bold rounded-xl bg-amber-100 text-amber-800 hover:bg-amber-200 transition-colors disabled:opacity-40 border border-amber-200">
                  <Download className="w-4 h-4" /> ছবি
                </button>
                <button onClick={handlePrint} disabled={isLoading}
                  className="flex items-center gap-1.5 px-4 py-2 text-[11px] font-bold rounded-xl bg-slate-800 text-white hover:bg-slate-700 transition-colors disabled:opacity-40">
                  <Printer className="w-4 h-4" /> প্রিন্ট
                </button>
                <button onClick={onClose}
                  className="p-2 rounded-xl bg-rose-50 text-rose-500 hover:bg-rose-100 transition-colors border border-rose-100 ml-1">
                  <X className="w-5 h-5" />
                </button>
              </div>
            </div>

            {/* ─── Gap Warning & Adjust Actions ─── */}
            {!isLoading && hasMismatch && !isCapturing && (
              <div className="bg-red-50 dark:bg-red-900/20 border-b border-red-200 dark:border-red-900/40 px-6 py-3 flex justify-between items-center shrink-0">
                <div>
                  <p className="text-red-700 dark:text-red-400 font-bold text-sm tracking-wide">⚠️ হিসাবের গরমিল পাওয়া গেছে!</p>
                  <p className="text-red-600 dark:text-red-300 text-[11px] mt-0.5">
                    রিপোর্টের ডান দিক ও বাম দিকের মাঝে <strong>{formatBanglaAmount(Math.abs(gap))}</strong> টাকার পার্থক্য রয়েছে।
                  </p>
                </div>
                <button 
                  onClick={() => {
                    setAdjustData({
                      type: gap > 0 ? "costing" : "income",
                      amount: Math.abs(gap),
                      category: "",
                      description: "অ্যাডজাস্টমেন্ট এন্ট্রি (Missing Ref)"
                    });
                    setShowAdjust(!showAdjust);
                  }}
                  className="bg-red-600 hover:bg-red-700 text-white px-4 py-1.5 rounded-lg text-xs font-bold shadow-sm transition-colors"
                >
                  {showAdjust ? "বাতিল করুন" : "হিসাব সমন্বয় করুন"}
                </button>
              </div>
            )}
            
            {/* Adjust Inline Form */}
            {showAdjust && !isCapturing && (
              <div className="bg-amber-50 dark:bg-zinc-900 border-b border-amber-200 dark:border-zinc-800 px-6 py-4 flex flex-col gap-3 shrink-0 shadow-sm z-10 relative">
                <p className="text-sm font-bold text-zinc-800 dark:text-zinc-200">সমন্বয়ের জন্য সঠিক এন্ট্রি দিন (গ্যাপ শূন্য করতে):</p>
                <div className="grid grid-cols-1 sm:grid-cols-5 gap-3">
                  <select 
                    value={adjustData.type}
                    onChange={(e) => setAdjustData({...adjustData, type: e.target.value as "income"|"costing", category: ""})}
                    className="border border-zinc-300 dark:border-zinc-700 dark:bg-zinc-800 dark:text-white rounded p-2 text-xs font-semibold"
                  >
                    <option value="income">আয় (INCOME)</option>
                    <option value="costing">ব্যয় (EXPENSE)</option>
                  </select>
                  
                  <select
                    value={adjustData.category}
                    onChange={(e) => setAdjustData({...adjustData, category: e.target.value})}
                    className="border border-zinc-300 dark:border-zinc-700 dark:bg-zinc-800 dark:text-white rounded p-2 text-xs font-semibold sm:col-span-2"
                  >
                    <option value="">-- ক্যাটাগরি বেছে নিন --</option>
                    {(adjustData.type === 'income' ? INCOME_CATEGORIES : COSTING_CATEGORIES).filter(c => !HIDDEN_FROM_LIST.includes(c)).map(cat => {
                      const displayCat = cat.replace(/\(মাস-সাল\)/g, `(${month?.name}-${month?.year})`);
                      return <option key={cat} value={displayCat}>{displayCat}</option>
                    })}
                  </select>

                  <input 
                    type="number"
                    value={adjustData.amount || ""}
                    onChange={(e) => setAdjustData({...adjustData, amount: Number(e.target.value)})}
                    className="border border-zinc-300 dark:border-zinc-700 dark:bg-zinc-800 dark:text-white rounded p-2 text-xs font-bold"
                    placeholder="টাকা"
                  />

                  <input 
                    type="text"
                    value={adjustData.description}
                    onChange={(e) => setAdjustData({...adjustData, description: e.target.value})}
                    className="border border-zinc-300 dark:border-zinc-700 dark:bg-zinc-800 dark:text-white rounded p-2 text-xs"
                    placeholder="বিবরণ"
                  />
                </div>
                <div className="flex justify-end gap-2 mt-1">
                  <button onClick={handleAdjustSubmit} disabled={isAdjusting} className="bg-emerald-600 hover:bg-emerald-700 text-white px-6 py-1.5 rounded-lg text-xs font-bold shadow disabled:opacity-50">
                    {isAdjusting ? "সেভ হচ্ছে..." : "এন্ট্রি সেভ করুন"}
                  </button>
                </div>
              </div>
            )}

            {/* ─── Scrollable Content ─── */}
            <div className="flex-1 overflow-y-auto p-4 lg:p-8">
              {isLoading ? (
                <div className="flex flex-col items-center justify-center py-32 gap-4">
                  <div className="w-12 h-12 border-4 border-amber-400/20 border-t-amber-500 rounded-full animate-spin" />
                  <p className="text-xs font-black uppercase tracking-widest text-amber-500">ডাটা প্রস্তুত হচ্ছে...</p>
                </div>
              ) : summaryData ? (
                /* ================================================
                   PRINTABLE AREA — inline styles only inside here
                   ================================================ */
                <div ref={printAreaRef}
                  style={{ fontFamily: "'Noto Serif Bengali', 'SolaimanLipi', serif", fontSize: "11px", color: "#000", background: "#fff", minWidth: "680px" }}>

                  {/* === COMPANY HEADER === */}
                  <div style={{ textAlign: "center", borderBottom: "3px double #000", paddingBottom: "8px", marginBottom: "10px" }}>
                    <h1 style={{ fontSize: "16px", fontWeight: 900, margin: 0 }}>{COMPANY_NAME}</h1>
                    <p style={{ fontSize: "11px", fontWeight: 700, margin: "2px 0 0" }}>এক নজরে মাসিক আয় ও ব্যয়ের বিবরণ</p>
                    <p style={{ fontSize: "10px", margin: "1px 0 0" }}>
                      ({month?.name} {toBanglaNumeral(month?.year)} সাল)
                    </p>
                  </div>

                  {/* === BANK SECTION === */}
                  <table style={{ width: "100%", borderCollapse: "collapse", marginBottom: "4px" }}>
                    <thead>
                      <tr style={{ background: "#f3f4f6" }}>
                        <th style={{ ...{ border: "1px solid #000", padding: "3px 5px", textAlign: "left", fontSize: "10px", fontWeight: 900, width: "38%" } }}>গত মাসের ব্যাংক ও নগদ স্থিতি</th>
                        <th style={{ border: "1px solid #000", padding: "3px 5px", textAlign: "right", fontSize: "10px", fontWeight: 900, width: "12%" }}>পরিমাণ</th>
                        <th style={{ border: "1px solid #000", padding: "3px 5px", textAlign: "left", fontSize: "10px", fontWeight: 900, width: "38%" }}>এই মাসের ব্যাংক ও নগদ স্থিতি</th>
                        <th style={{ border: "1px solid #000", padding: "3px 5px", textAlign: "right", fontSize: "10px", fontWeight: 900, width: "12%" }}>পরিমাণ</th>
                      </tr>
                    </thead>
                    <tbody>
                      {(() => {
                        const allRows: Array<{ name: string; opening: number; closing: number }> = [];
                        
                        // Handle the 6 banks
                        ORDERED_BANKS.forEach((bank, idx) => {
                          const bankData = bankCalculated?.[bank] || { opening: 0, closing: 0 };
                          allRows.push({ name: bank, opening: bankData.opening, closing: bankData.closing });
                        });

                        // Insert "নগদ হাতে জমা" after the second bank (index 1)
                        allRows.splice(2, 0, { name: "নগদ হাতে জমা", opening: cashInitial, closing: cashClosing });

                        return allRows.map((row, i) => (
                          <tr key={i}>
                            <td style={{ border: "1px solid #000", padding: "2px 5px", fontSize: "10px" }}>{row.name}</td>
                            <td style={{ border: "1px solid #000", padding: "2px 5px", textAlign: "right", fontSize: "10px", fontWeight: 600 }}>
                              {formatBanglaAmount(row.opening)}
                            </td>
                            <td style={{ border: "1px solid #000", padding: "2px 5px", fontSize: "10px" }}>{row.name}</td>
                            <td style={{ border: "1px solid #000", padding: "2px 5px", textAlign: "right", fontSize: "10px", fontWeight: 600 }}>
                              {formatBanglaAmount(row.closing)}
                            </td>
                          </tr>
                        ));
                      })()}
                      <tr>
                        <td colSpan={2} style={{ border: "1px solid #000", padding: "3px 5px", textAlign: "right", fontSize: "10px", fontWeight: 900, color: "#92400e", fontStyle: "italic" }}>
                          গত মাসে ব্যাংক ও নগদ মোট: <strong>{formatBanglaAmount(openingBankBalance + cashInitial)}</strong>
                        </td>
                        <td colSpan={2} style={{ border: "1px solid #000", padding: "3px 5px", textAlign: "right", fontSize: "10px", fontWeight: 900, color: "#92400e", fontStyle: "italic" }}>
                          এই মাসে ব্যাংক ও নগদ মোট: <strong>{formatBanglaAmount(closingBankBalance + cashClosing)}</strong>
                        </td>
                      </tr>
                    </tbody>
                  </table>

                  {/* === MAIN LEDGER: INCOME | COSTING === */}
                  <table style={{ width: "100%", borderCollapse: "collapse" }}>
                    <thead>
                      <tr style={{ background: "#1e293b", color: "#fff" }}>
                        <th style={{ border: "1px solid #000", padding: "4px 6px", textAlign: "center", fontSize: "10px", fontWeight: 900, width: "40%" }}>আয়ের বিবরণ (INCOME)</th>
                        <th style={{ border: "1px solid #000", padding: "4px 6px", textAlign: "right", fontSize: "10px", fontWeight: 900, width: "10%" }}>টাকা</th>
                        <th style={{ border: "1px solid #000", padding: "4px 6px", textAlign: "center", fontSize: "10px", fontWeight: 900, width: "40%" }}>ব্যয়ের বিবরণ (EXPENSE)</th>
                        <th style={{ border: "1px solid #000", padding: "4px 6px", textAlign: "right", fontSize: "10px", fontWeight: 900, width: "10%" }}>টাকা</th>
                      </tr>
                    </thead>
                    <tbody>
                      {Array.from({ length: maxRows }).map((_, idx) => {
                        const incCat = incomeRows[idx];
                        const costCat = costingRows[idx];
                        const incAmt = incCat ? (incomeByCategory?.[incCat] || 0) : 0;
                        const costAmt = (() => {
                          if (!costCat) return 0;
                          const val = costingByCategory?.[costCat] || 0;
                          return val as number;
                        })();
                        const isAdjustmentIncome = incCat && (incCat.includes("ব্যাংক হতে প্রাপ্ত লভ্যাংশ"));
                        const isAdjustmentCost = costCat && (costCat.includes("ব্যাংক এর মাধ্যমে পেমেন্ট") || costCat.includes("ব্যাংক এর আবগারি শুল্ক"));
                        
                        const rowBg = idx % 2 === 1 ? "#fafafa" : "#fff";
                        const incBg = isAdjustmentIncome ? "#f0fdf4" : "transparent"; // Light green for bank income
                        const costBg = isAdjustmentCost ? "#fff7ed" : "transparent"; // Light orange for bank costing
                        
                        return (
                          <tr key={idx} style={{ background: rowBg }}>
                            <td style={{ border: "1px solid #000", padding: "2px 5px", fontSize: "10px", backgroundColor: incBg }}>
                              {incCat ? incCat.replace(/\(মাস-সাল\)/g, "").trim() : ""}
                            </td>
                            <td style={{ border: "1px solid #000", padding: "2px 5px", textAlign: "right", fontSize: "10px", fontWeight: incAmt > 0 ? 700 : 400, backgroundColor: incBg }}>
                              {incCat ? (incAmt > 0 ? formatBanglaAmount(incAmt) : "—") : ""}
                            </td>
                            <td style={{ border: "1px solid #000", padding: "2px 5px", fontSize: "10px", backgroundColor: costBg }}>
                              {costCat ? costCat.replace(/\(মাস-সাল\)/g, "").trim() : ""}
                            </td>
                            <td style={{ border: "1px solid #000", padding: "2px 5px", textAlign: "right", fontSize: "10px", fontWeight: costAmt > 0 ? 700 : 400, backgroundColor: costBg }}>
                              {costCat ? (costAmt > 0 ? formatBanglaAmount(costAmt) : "—") : ""}
                            </td>
                          </tr>
                        );
                      })}

                      {/* Subtotals */}
                      <tr style={{ borderTop: "2px solid #000" }}>
                        <td style={{ border: "1px solid #000", padding: "3px 5px", textAlign: "right", fontWeight: 900, color: "#92400e", fontStyle: "italic", fontSize: "10px" }}>মোট আয়:</td>
                        <td style={{ border: "1px solid #000", padding: "3px 5px", textAlign: "right", fontWeight: 900, color: "#92400e", fontSize: "10px" }}>{formatBanglaAmount(totalIncome)}</td>
                        <td style={{ border: "1px solid #000", padding: "3px 5px", textAlign: "right", fontWeight: 900, color: "#92400e", fontStyle: "italic", fontSize: "10px" }}>মোট ব্যয়:</td>
                        <td style={{ border: "1px solid #000", padding: "3px 5px", textAlign: "right", fontWeight: 900, color: "#92400e", fontSize: "10px" }}>{formatBanglaAmount(totalCosting)}</td>
                      </tr>

                      {/* Grand totals */}
                      <tr style={{ borderTop: "3px double #000" }}>
                        <td style={{ border: "1px solid #000", padding: "4px 6px", textAlign: "center", fontWeight: 900, background: "#1e293b", color: "#fff", fontSize: "11px" }}>সর্বমোট টাকা</td>
                        <td style={{ border: "1px solid #000", padding: "4px 6px", textAlign: "right", fontWeight: 900, background: "#1e293b", color: "#fff", fontSize: "11px" }}>{formatBanglaAmount(grandTotalIncome)}</td>
                        <td style={{ border: "1px solid #000", padding: "4px 6px", textAlign: "center", fontWeight: 900, background: "#1e293b", color: "#fff", fontSize: "11px" }}>সর্বমোট টাকা</td>
                        <td style={{ border: "1px solid #000", padding: "4px 6px", textAlign: "right", fontWeight: 900, background: "#1e293b", color: "#fff", fontSize: "11px" }}>{formatBanglaAmount(grandTotalCosting)}</td>
                      </tr>
                    </tbody>
                  </table>

                  {/* Footer */}
                  <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-end", marginTop: "28px", paddingTop: "8px", borderTop: "1px dashed #9ca3af" }}>
                    <div style={{ display: "flex", gap: "48px", fontSize: "9px", color: "#6b7280", fontWeight: 700, textTransform: "uppercase" }}>
                      <div style={{ textAlign: "center" }}>
                        <div style={{ borderTop: "1px solid #000", marginTop: "32px", paddingTop: "4px", paddingLeft: "20px", paddingRight: "20px" }}>হিসাব রক্ষক</div>
                      </div>
                      <div style={{ textAlign: "center" }}>
                        <div style={{ borderTop: "1px solid #000", marginTop: "32px", paddingTop: "4px", paddingLeft: "20px", paddingRight: "20px" }}>পরিচালক</div>
                      </div>
                    </div>
                    <div style={{ fontSize: "8px", color: "#9ca3af", fontStyle: "italic", textAlign: "right" }}>
                      প্রিন্ট: {toBanglaNumeral(format(new Date(), "dd-MM-yyyy hh:mm a"))}
                    </div>
                  </div>
                </div>
              ) : null}
            </div>
          </motion.div>
        </div>
      )}
    </AnimatePresence>
  );
}
