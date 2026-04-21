'use client';

import { useState, useEffect, useRef } from 'react';
import { getGlobalBankStatement } from '@/lib/actions';
import { motion, AnimatePresence } from 'framer-motion';
import { Printer, Download, X, Building2, Calendar, Activity } from 'lucide-react';
import { formatBanglaAmount, formatBanglaDate } from '@/lib/utils/bangla-date';
import { format } from 'date-fns';

const COMPANY_NAME = "বাংলা গোল্ড (প্রাঃ) লিমিটেড";

interface Props {
  category: string | null;
  isOpen: boolean;
  onClose: () => void;
}

export default function GlobalBankStatementModal({ category, isOpen, onClose }: Props) {
  const [data, setData] = useState<any>(null);
  const [isLoading, setIsLoading] = useState(false);
  const [isCapturing, setIsCapturing] = useState(false);
  const printAreaRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (isOpen && category) {
      fetchStatement();
    } else {
      setData(null);
    }
  }, [isOpen, category]);

  const fetchStatement = async () => {
    setIsLoading(true);
    const result = await getGlobalBankStatement(category!);
    setData(result);
    setIsLoading(false);
  };

  const handlePrint = () => {
    const node = printAreaRef.current;
    if (!node) return;

    const printWindow = window.open("", "_blank", "width=900,height=1000");
    if (!printWindow) return;

    printWindow.document.write(`<!DOCTYPE html>
<html lang="bn">
<head>
  <meta charset="UTF-8" />
  <title>${COMPANY_NAME} – ব্যাংক বিবরণী</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Serif+Bengali:wght@400;600;700;900&display=swap');
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: 'Noto Serif Bengali', serif; font-size: 10pt; color: #000; background: #fff; padding: 8mm; }
    table { width: 100%; border-collapse: collapse; }
    td, th { border: 1px solid #000; padding: 6px; font-size: 10pt; }
    .text-right { text-align: right; }
    .text-center { text-align: center; }
    .font-bold { font-weight: 700; }
    @media print {
      @page { size: A4 portrait; margin: 10mm; }
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
        link.download = `bank-statement-${category || "report"}.png`;
        link.href = dataUrl;
        link.click();
      } catch (e) { console.error(e); }
      finally { setIsCapturing(false); }
    }, 150);
  };

  if (!isOpen) return null;

  let currentBalance = data?.openingBalance || 0;
  const transactions = data?.transactions || [];
  
  // Calculate final total
  const finalBalance = transactions.reduce((acc: number, t: any) => {
    return t.type === 'income' ? acc + t.amount : acc - t.amount;
  }, currentBalance);

  return (
    <AnimatePresence>
      <div className="fixed inset-0 z-50 flex items-center justify-center p-2 sm:p-4">
        <motion.div
          initial={{ opacity: 0 }} animate={{ opacity: 1 }} exit={{ opacity: 0 }}
          onClick={onClose}
          className="absolute inset-0 bg-black/60 backdrop-blur-sm"
        />

        <motion.div
          initial={{ opacity: 0, scale: 0.96, y: 20 }}
          animate={{ opacity: 1, scale: 1, y: 0 }}
          exit={{ opacity: 0, scale: 0.96, y: 20 }}
          className="relative w-full max-w-4xl max-h-[94vh] bg-white dark:bg-zinc-950 rounded-3xl shadow-2xl overflow-hidden flex flex-col border border-border"
        >
          {/* Header */}
          <div className="flex items-center justify-between px-6 py-4 border-b border-border bg-muted/50 shrink-0">
            <div className="flex items-center gap-3">
              <div className="p-2 rounded-xl bg-blue-500 text-white shadow-sm">
                <Building2 className="w-5 h-5" />
              </div>
              <div>
                <p className="text-[10px] font-black uppercase tracking-widest text-muted-foreground">Historical Ledger</p>
                <h2 className="text-base font-black text-foreground">{category}</h2>
              </div>
            </div>
            <div className="flex items-center gap-2">
              <button 
                onClick={handleSaveImage} 
                className="p-2 rounded-xl bg-background border border-border hover:bg-muted text-foreground transition-all flex items-center gap-2 text-xs font-bold"
              >
                <Download className="w-4 h-4" /> <span>Image</span>
              </button>
              <button 
                onClick={handlePrint} 
                className="p-2 rounded-xl bg-foreground text-background hover:opacity-90 transition-all flex items-center gap-2 text-xs font-bold"
              >
                <Printer className="w-4 h-4" /> <span>Print</span>
              </button>
              <button onClick={onClose} className="p-2 rounded-xl bg-rose-50 text-rose-500 hover:bg-rose-100 ml-2">
                <X className="w-5 h-5" />
              </button>
            </div>
          </div>

          {/* Content */}
          <div className="flex-1 overflow-y-auto p-4 bg-background">
            {isLoading ? (
              <div className="flex flex-col items-center justify-center h-64 gap-3">
                <div className="w-8 h-8 border-4 border-blue-200 border-t-blue-600 rounded-full animate-spin" />
                <p className="text-xs font-bold text-muted-foreground uppercase tracking-widest">Loading Ledger...</p>
              </div>
            ) : (
              <div ref={printAreaRef} className="bg-white p-8 max-w-3xl mx-auto shadow-sm border border-zinc-100 rounded-2xl" style={{ fontFamily: "'Noto Serif Bengali', serif", color: "#000" }}>
                
                {/* Print Header */}
                <div style={{ textAlign: "center", borderBottom: "3px double #000", paddingBottom: "15px", marginBottom: "20px" }}>
                  <h1 style={{ fontSize: "20px", fontWeight: 900, margin: 0 }}>{COMPANY_NAME}</h1>
                  <p style={{ fontSize: "14px", fontWeight: 700, margin: "5px 0" }}>পূর্ণাঙ্গ ব্যাংক বিবরণী (Full Ledger)</p>
                  <p style={{ fontSize: "12px", background: "#f3f4f6", display: "inline-block", padding: "4px 10px", borderRadius: "4px", fontWeight: 700 }}>
                    ব্যাংক/খাত: {category}
                  </p>
                </div>

                {/* Ledger Table */}
                <table style={{ width: "100%", borderCollapse: "collapse" }}>
                  <thead>
                    <tr style={{ background: "#1e293b", color: "#fff" }}>
                      <th style={{ border: "1px solid #000", padding: "8px", textAlign: "left", width: "15%", fontSize: "11px" }}>তারিখ (Date)</th>
                      <th style={{ border: "1px solid #000", padding: "8px", textAlign: "left", width: "40%", fontSize: "11px" }}>বিবরণ (Description)</th>
                      <th style={{ border: "1px solid #000", padding: "8px", textAlign: "right", width: "15%", fontSize: "11px" }}>জমা (Credit)</th>
                      <th style={{ border: "1px solid #000", padding: "8px", textAlign: "right", width: "15%", fontSize: "11px" }}>খরচ (Debit)</th>
                      <th style={{ border: "1px solid #000", padding: "8px", textAlign: "right", width: "15%", fontSize: "11px" }}>ব্যালেন্স (Balance)</th>
                    </tr>
                  </thead>
                  <tbody>
                    {/* Opening Balance Row */}
                    <tr style={{ background: "#f8fafc" }}>
                      <td style={{ border: "1px solid #000", padding: "6px" }}>—</td>
                      <td style={{ border: "1px solid #000", padding: "6px", fontWeight: 700 }}>** প্রারম্ভিক ব্যাংক স্থিতি (Initial Balance) **</td>
                      <td style={{ border: "1px solid #000", padding: "6px", textAlign: "right" }}>{data?.openingBalance > 0 ? formatBanglaAmount(data.openingBalance) : "—"}</td>
                      <td style={{ border: "1px solid #000", padding: "6px", textAlign: "right" }}>{data?.openingBalance < 0 ? formatBanglaAmount(Math.abs(data.openingBalance)) : "—"}</td>
                      <td style={{ border: "1px solid #000", padding: "6px", textAlign: "right", fontWeight: 900, color: "#1d4ed8" }}>{formatBanglaAmount(data?.openingBalance || 0)}</td>
                    </tr>

                    {/* Transaction Rows */}
                    {transactions.map((t: any, i: number) => {
                      const isCredit = t.type === 'income';
                      currentBalance += (isCredit ? t.amount : -t.amount);
                      
                      return (
                        <tr key={i} style={{ background: i % 2 === 0 ? "#fff" : "#fafafa" }}>
                          <td style={{ border: "1px solid #000", padding: "6px", fontSize: "11px" }}>{formatBanglaDate(new Date(t.date))}</td>
                          <td style={{ border: "1px solid #000", padding: "6px", fontSize: "11px" }}>{t.description || "—"}</td>
                          <td style={{ border: "1px solid #000", padding: "6px", textAlign: "right", fontSize: "11px", fontWeight: isCredit ? 700 : 400 }}>{isCredit ? formatBanglaAmount(t.amount) : "—"}</td>
                          <td style={{ border: "1px solid #000", padding: "6px", textAlign: "right", fontSize: "11px", fontWeight: !isCredit ? 700 : 400 }}>{!isCredit ? formatBanglaAmount(t.amount) : "—"}</td>
                          <td style={{ border: "1px solid #000", padding: "6px", textAlign: "right", fontSize: "11px", fontWeight: 600 }}>{formatBanglaAmount(currentBalance)}</td>
                        </tr>
                      );
                    })}

                    {transactions.length === 0 && (
                      <tr>
                        <td colSpan={5} style={{ border: "1px solid #000", padding: "20px", textAlign: "center", fontStyle: "italic", color: "#666" }}>
                          কোন লেনদেন পাওয়া যায়নি
                        </td>
                      </tr>
                    )}

                    {/* Closing Balance Row */}
                    <tr style={{ background: "#1e293b", color: "#fff" }}>
                      <td colSpan={2} style={{ border: "1px solid #000", padding: "10px", textAlign: "right", fontWeight: 900, fontSize: "12px" }}>সর্বশেষ ব্যাংক স্থিতি (Final Balance):</td>
                      <td colSpan={3} style={{ border: "1px solid #000", padding: "10px", textAlign: "right", fontWeight: 900, fontSize: "14px" }}>
                        {formatBanglaAmount(finalBalance)}
                      </td>
                    </tr>
                  </tbody>
                </table>

                <div style={{ marginTop: "40px", fontSize: "9px", color: "#666", textAlign: "right", fontStyle: "italic" }}>
                  Generation time: {format(new Date(), "dd-MM-yyyy hh:mm a")}
                </div>
              </div>
            )}
          </div>
        </motion.div>
      </div>
    </AnimatePresence>
  );
}
