'use client';

import { Plus } from 'lucide-react';
import { motion } from 'framer-motion';

interface AddMonthCardProps {
  onClick: () => void;
}

export default function AddMonthCard({ onClick }: AddMonthCardProps) {
  return (
    <motion.button
      whileHover={{ scale: 1.01 }}
      whileTap={{ scale: 0.98 }}
      onClick={onClick}
      className="group relative h-full min-h-[220px] w-full"
    >
      <div className="absolute -top-2.5 left-6 w-12 h-3 bg-muted border-dashed border border-b-0 border-border rounded-t-lg group-hover:bg-foreground transition-all duration-300" />
      
      <div className="h-full border-2 border-dashed border-border rounded-[32px] p-8 flex flex-col items-center justify-center gap-5 group-hover:border-foreground group-hover:bg-muted/30 transition-all duration-300 bg-white/50 dark:bg-black/50">
        <div className="p-5 rounded-3xl bg-muted text-muted-foreground group-hover:bg-foreground group-hover:text-background transition-all duration-300">
          <Plus className="w-8 h-8" strokeWidth={2.5} />
        </div>
        <div className="text-center">
          <h3 className="text-lg font-black tracking-tight text-foreground uppercase italic group-hover:not-italic transition-all">Add Entry</h3>
          <p className="text-[10px] font-black uppercase tracking-widest text-muted-foreground mt-1">New Folder</p>
        </div>
      </div>
    </motion.button>
  );
}
