'use client';

import { logout } from '@/lib/auth';
import { useRouter } from 'next/navigation';
import { LogOut, LayoutDashboard, Settings, User } from 'lucide-react';
import { motion } from 'framer-motion';

export default function DashboardHeader() {
  const router = useRouter();

  const handleLogout = () => {
    logout();
    router.push('/login');
  };

  return (
    <header className="sticky top-0 z-50 w-full bg-white/80 dark:bg-black/80 backdrop-blur-md border-b border-border">
      <div className="container mx-auto px-4 h-20 sm:h-24 flex items-center justify-between max-w-[1700px]">
        <div className="flex items-center gap-4">
          <div className="w-12 h-12 rounded-[18px] bg-black dark:bg-white flex items-center justify-center text-white dark:text-black shadow-lg">
            <LayoutDashboard className="w-6 h-6" />
          </div>
          <div className="flex flex-col">
            <h1 className="text-2xl font-black tracking-tighter text-foreground leading-none">
              DASHBOARD
            </h1>
            <p className="text-[10px] uppercase font-black text-muted-foreground tracking-[0.2em] mt-1 italic">
              Personal Edition
            </p>
          </div>
        </div>

        <div className="flex items-center gap-6">
          <div className="hidden md:flex flex-col text-right">
            <span className="text-xs font-black uppercase tracking-widest text-muted-foreground">Active User</span>
            <span className="text-sm font-bold text-foreground">shaharia</span>
          </div>
          
          <button
            onClick={handleLogout}
            className="w-12 h-12 rounded-2xl border border-border flex items-center justify-center hover:bg-black hover:text-white dark:hover:bg-white dark:hover:text-black transition-all group"
          >
            <LogOut className="w-5 h-5 transition-transform group-hover:scale-90" />
          </button>
        </div>
      </div>
    </header>
  );
}
