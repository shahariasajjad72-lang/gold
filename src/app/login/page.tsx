import LoginForm from '@/components/LoginForm';

export default function LoginPage() {
  return (
    <main className="min-h-screen w-full flex items-center justify-center bg-background p-6 relative overflow-hidden">
      {/* Decorative Blur Backgrounds */}
      <div className="absolute top-[-10%] left-[-10%] w-[40%] h-[40%] bg-brand-primary/10 blur-[120px] rounded-full" />
      <div className="absolute bottom-[-10%] right-[-10%] w-[40%] h-[40%] bg-brand-secondary/10 blur-[120px] rounded-full" />
      
      <div className="z-10 w-full flex flex-col items-center">
        <div className="mb-8 flex flex-col items-center gap-2">
          <div className="w-16 h-16 rounded-2xl bg-gradient-to-br from-brand-primary to-brand-secondary flex items-center justify-center text-white shadow-2xl shadow-brand-primary/40 transform -rotate-6">
            <span className="text-3xl font-bold font-mono">FT</span>
          </div>
          <h2 className="text-xl font-black tracking-tighter uppercase italic text-muted-foreground/50">FinanceTracker</h2>
        </div>
        
        <LoginForm />
        
        <footer className="mt-12 text-sm text-muted-foreground/60 flex items-center gap-4">
          <p>© 2026 Finance Tracker Inc.</p>
          <span className="w-1 h-1 bg-muted-foreground/20 rounded-full" />
          <p>Privacy Policy</p>
        </footer>
      </div>
    </main>
  );
}
