"use client";

import { useState, useEffect, useRef } from "react";
import { X, Printer, Download, FileText } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import { format } from "date-fns";
import { getMonthEndSummary } from "@/lib/actions";
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

  useEffect(() => {
    if (isOpen) fetchData();
  }, [isOpen, monthId]);

  const fetchData = async () => {
    setIsLoading(true);
    const data = await getMonthEndSummary(monthId);
    setSummaryData(data);
    setIsLoading(false);
  };

  // ✅ Isolated-window print — completely avoids CSS conflicts with other modals
  const handlePrint = () => {
    const node = printAreaRef.current;
    if (!node) return;

    const printWindow = window.open("", "_blank", "width=960,height=1100");
    if (!printWindow) return;

    printWindow.document.write(`<!DOCTYPE html>
<html lang="bn">
<head>
  <meta charset="UTF-8" />
  <title>${COMPANY_NAME} – মাস সমাপ্তি</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Serif+Bengali:wght@400;600;700;900&display=swap');
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: 'Noto Serif Bengali', serif; font-size: 10pt; color: #000; background: #fff; padding: 8mm; }
    table { width: 100%; border-collapse: collapse; }
    td, th { border: 1px solid #000; padding: 2px 4px; font-size: 9.5pt; line-height: 1.4; }
    .text-right { text-align: right; }
    .text-center { text-align: center; }
    .font-bold { font-weight: 700; }
    .font-black { font-weight: 900; }
    .bg-dark { background: #1e293b; color: white; }
    .bg-grey { background: #f3f4f6; }
    .color-amber { color: #92400e; }
    .color-green { color: #166534; }
    .color-red { color: #991b1b; }
    .color-blue { color: #1e40af; }
    .section-header { background: #f3f4f6; font-weight: 900; font-size: 9pt; text-align: center; letter-spacing: 0.05em; text-transform: uppercase; }
    @media print {
      @page { size: A4 portrait; margin: 8mm; }
      body { padding: 0; }
    }
  </style>
</head>
<body>
${node.innerHTML}
</body>
</html>`);

    printWindow.document.close();
    printWindow.focus();
    setTimeout(() => { printWindow.print(); printWindow.close(); }, 600);
  };

  const handleSaveImage = async () => {
    const node = printAreaRef.current;
    if (!node) return;
    setIsCapturing(true);
    setTimeout(async () => {
      try {
        const { toPng } = await import("html-to-image");
        const dataUrl = await toPng(node, { quality: 1.0, backgroundColor: "#fff", pixelRatio: 2 });
        const link = document.createElement("a");
        link.download = `মাস-সমাপ্তি-${summaryData?.month?.name || "report"}.png`;
        link.href = dataUrl;
        link.click();
      } catch (e) { console.error(e); }
      finally { setIsCapturing(false); }
    }, 150);
  };

  const { month, incomeByCategory, costingByCategory, bankByCategory } = summaryData || {};
  const totalIncome = INCOME_CATEGORIES.reduce((s, c) => s + (incomeByCategory?.[c] || 0), 0);
  const totalCosting = COSTING_CATEGORIES.reduce((s, c) => s + (costingByCategory?.[c] || 0), 0);
  const totalBankCredit = BANK_CATEGORIES.reduce((s, c) => s + (bankByCategory?.[c]?.credit || 0), 0);
  const totalBankDebit = BANK_CATEGORIES.reduce((s, c) => s + (bankByCategory?.[c]?.debit || 0), 0);
  const openingBalance = month?.openingBalance || 0;
  const grandTotalIncome = openingBalance + totalIncome + totalBankCredit;
  const grandTotalCosting = totalCosting + totalBankDebit;
  const netBalance = totalIncome - totalCosting;

  const maxRows = Math.max(INCOME_CATEGORIES.length, COSTING_CATEGORIES.length);
  const incomeRows = [...INCOME_CATEGORIES, ...Array(Math.max(0, maxRows - INCOME_CATEGORIES.length)).fill("")];
  const costingRows = [...COSTING_CATEGORIES, ...Array(Math.max(0, maxRows - COSTING_CATEGORIES.length)).fill("")];

  // Shared table cell style strings for the printable area (inline styles only — works in print window)
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
                      {BANK_CATEGORIES.map((bank, i) => {
                        const bankData = bankByCategory?.[bank];
                        const netBank = bankData ? (bankData.credit - bankData.debit) : 0;
                        return (
                          <tr key={bank}>
                            <td style={{ border: "1px solid #000", padding: "2px 5px", fontSize: "10px" }}>{bank}</td>
                            <td style={{ border: "1px solid #000", padding: "2px 5px", textAlign: "right", fontSize: "10px", fontWeight: 600 }}>
                              {i === 0 && openingBalance > 0 ? formatBanglaAmount(openingBalance) : "—"}
                            </td>
                            <td style={{ border: "1px solid #000", padding: "2px 5px", fontSize: "10px" }}>{bank}</td>
                            <td style={{ border: "1px solid #000", padding: "2px 5px", textAlign: "right", fontSize: "10px", fontWeight: 600 }}>
                              {netBank !== 0 ? formatBanglaAmount(netBank) : "—"}
                            </td>
                          </tr>
                        );
                      })}
                      <tr>
                        <td colSpan={2} style={{ border: "1px solid #000", padding: "3px 5px", textAlign: "right", fontSize: "10px", fontWeight: 900, color: "#92400e", fontStyle: "italic" }}>
                          গত মাসে নগদ ও ব্যাংকে মোট: <strong>{formatBanglaAmount(openingBalance)}</strong>
                        </td>
                        <td colSpan={2} style={{ border: "1px solid #000", padding: "3px 5px", textAlign: "right", fontSize: "10px", fontWeight: 900, color: "#92400e", fontStyle: "italic" }}>
                          এই মাসে নগদ ও ব্যাংকে মোট: <strong>{formatBanglaAmount(totalBankCredit - totalBankDebit)}</strong>
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
                        const costAmt = costCat ? (costingByCategory?.[costCat] || 0) : 0;
                        const rowBg = idx % 2 === 1 ? "#fafafa" : "#fff";
                        return (
                          <tr key={idx} style={{ background: rowBg }}>
                            <td style={{ border: "1px solid #000", padding: "2px 5px", fontSize: "10px" }}>
                              {incCat ? incCat.replace(/\(মাস-সাল\)/g, "").trim() : ""}
                            </td>
                            <td style={{ border: "1px solid #000", padding: "2px 5px", textAlign: "right", fontSize: "10px", fontWeight: incAmt > 0 ? 700 : 400 }}>
                              {incCat ? (incAmt > 0 ? formatBanglaAmount(incAmt) : "—") : ""}
                            </td>
                            <td style={{ border: "1px solid #000", padding: "2px 5px", fontSize: "10px" }}>
                              {costCat ? costCat.replace(/\(মাস-সাল\)/g, "").trim() : ""}
                            </td>
                            <td style={{ border: "1px solid #000", padding: "2px 5px", textAlign: "right", fontSize: "10px", fontWeight: costAmt > 0 ? 700 : 400 }}>
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
                        <td style={{ border: "1px solid #000", padding: "4px 6px", textAlign: "center", fontWeight: 900, background: "#1e293b", color: "#fff", fontSize: "11px" }}>সর্বমোট আয়</td>
                        <td style={{ border: "1px solid #000", padding: "4px 6px", textAlign: "right", fontWeight: 900, background: "#1e293b", color: "#fff", fontSize: "11px" }}>{formatBanglaAmount(grandTotalIncome)}</td>
                        <td style={{ border: "1px solid #000", padding: "4px 6px", textAlign: "center", fontWeight: 900, background: "#1e293b", color: "#fff", fontSize: "11px" }}>সর্বমোট ব্যয়</td>
                        <td style={{ border: "1px solid #000", padding: "4px 6px", textAlign: "right", fontWeight: 900, background: "#1e293b", color: "#fff", fontSize: "11px" }}>{formatBanglaAmount(grandTotalCosting)}</td>
                      </tr>

                      {/* Net balance */}
                      <tr style={{ background: "#fffbeb" }}>
                        <td colSpan={2} style={{ border: "1px solid #000", padding: "4px 6px", textAlign: "center", fontWeight: 900, fontSize: "10.5px" }}>
                          মাসিক নীট উদ্বৃত্ত (আয় − ব্যয়):&nbsp;
                          <span style={{ color: netBalance >= 0 ? "#15803d" : "#b91c1c", fontSize: "11px" }}>
                            {formatBanglaAmount(Math.abs(netBalance))} {netBalance >= 0 ? "(উদ্বৃত্ত)" : "(ঘাটতি)"}
                          </span>
                        </td>
                        <td colSpan={2} style={{ border: "1px solid #000", padding: "4px 6px", textAlign: "center", fontWeight: 900, fontSize: "10.5px" }}>
                          সমাপ্তি নগদ স্থিতি:&nbsp;
                          <span style={{ color: "#1d4ed8", fontSize: "11px" }}>
                            {formatBanglaAmount(openingBalance + totalIncome - totalCosting)}
                          </span>
                        </td>
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
