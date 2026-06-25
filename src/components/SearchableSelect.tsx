"use client";

import { useState, useRef, useEffect } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { ChevronDown, Search, Check } from 'lucide-react';
import { cn } from '@/lib/utils';

interface SearchableSelectProps {
  options: { value: string; label: string }[];
  value: string;
  onChange: (value: string) => void;
  placeholder?: string;
  icon?: React.ReactNode;
}

export default function SearchableSelect({ options, value, onChange, placeholder = "Select...", icon }: SearchableSelectProps) {
  const [isOpen, setIsOpen] = useState(false);
  const [search, setSearch] = useState('');
  const wrapperRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      if (wrapperRef.current && !wrapperRef.current.contains(event.target as Node)) {
        setIsOpen(false);
      }
    }
    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, [wrapperRef]);

  const filteredOptions = options.filter(opt => 
    opt.label.toLowerCase().includes(search.toLowerCase()) || 
    opt.value.toLowerCase().includes(search.toLowerCase())
  );

  const selectedOption = options.find(opt => opt.value === value);

  return (
    <div className="relative w-full" ref={wrapperRef}>
      <div 
        className={cn(
          "w-full pl-14 pr-12 py-3.5 sm:py-4 rounded-2xl border transition-all cursor-pointer flex items-center justify-between font-bold text-sm",
          isOpen 
            ? "bg-background border-indigo-500 shadow-[0_0_0_4px_rgba(99,102,241,0.1)]" 
            : "bg-muted/30 border-border/50 hover:border-border"
        )}
        onClick={() => setIsOpen(!isOpen)}
      >
        <div className="absolute left-4 top-1/2 -translate-y-1/2 p-1.5 rounded-lg bg-muted text-muted-foreground">
          {icon}
        </div>
        <span className="truncate flex-1 text-left text-foreground">
          {selectedOption ? selectedOption.label : placeholder}
        </span>
        <ChevronDown className={cn("w-4 h-4 text-muted-foreground transition-transform duration-300", isOpen && "rotate-180")} />
      </div>

      <AnimatePresence>
        {isOpen && (
          <motion.div
            initial={{ opacity: 0, y: -10, scale: 0.95 }}
            animate={{ opacity: 1, y: 0, scale: 1 }}
            exit={{ opacity: 0, y: -10, scale: 0.95 }}
            transition={{ duration: 0.15 }}
            className="absolute z-50 w-full mt-2 bg-white dark:bg-zinc-950 border border-border/50 rounded-2xl shadow-2xl overflow-hidden"
          >
            <div className="p-2 border-b border-border/50 relative bg-muted/20">
              <Search className="absolute left-4 top-1/2 -translate-y-1/2 w-4 h-4 text-muted-foreground" />
              <input
                autoFocus
                type="text"
                placeholder="Search category..."
                value={search}
                onChange={(e) => setSearch(e.target.value)}
                className="w-full pl-10 pr-4 py-2.5 bg-background border border-border/50 rounded-xl outline-none text-sm font-bold focus:border-indigo-500/50 transition-colors placeholder:text-muted-foreground/50"
                onClick={(e) => e.stopPropagation()}
              />
            </div>
            <div className="max-h-[240px] overflow-y-auto custom-scrollbar p-1.5 bg-background">
              {filteredOptions.length > 0 ? (
                filteredOptions.map((opt) => (
                  <div
                    key={opt.value}
                    className={cn(
                      "px-3 py-3 rounded-xl cursor-pointer text-[13px] font-bold flex items-center justify-between transition-colors mb-1 last:mb-0",
                      value === opt.value 
                        ? "bg-indigo-50 text-indigo-700 dark:bg-indigo-500/20 dark:text-indigo-300" 
                        : "hover:bg-muted/50 text-foreground"
                    )}
                    onClick={() => {
                      onChange(opt.value);
                      setIsOpen(false);
                      setSearch('');
                    }}
                  >
                    <span className="truncate pr-4" title={opt.label}>{opt.label}</span>
                    {value === opt.value && <Check className="w-4 h-4 flex-shrink-0" />}
                  </div>
                ))
              ) : (
                <div className="px-4 py-8 text-center text-sm text-muted-foreground/50 italic font-bold">
                  No matches found.
                </div>
              )}
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </div>
  );
}
