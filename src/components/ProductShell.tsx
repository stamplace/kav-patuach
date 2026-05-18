import type { ReactNode } from "react";
import { product } from "@/lib/product";

type ProductShellProps = {
  active: "premium" | "landing" | "customer" | "driver" | "admin";
  badge: string;
  children: ReactNode;
};

const navItems = [
  { key: "premium", label: "פרימיום", href: "/premium" },
  { key: "customer", label: "לקוח", href: "/customer" },
  { key: "driver", label: "נהג", href: "/driver" },
  { key: "admin", label: "מנהל", href: "/admin" },
];

export function ProductShell({ active, badge, children }: ProductShellProps) {
  return (
    <main dir="rtl" className="min-h-screen overflow-hidden bg-[#010713] text-white">
      <section className="relative min-h-screen px-5 py-6 sm:px-8">
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_50%_0%,rgba(16,185,129,.30),transparent_30%),radial-gradient(circle_at_12%_28%,rgba(56,189,248,.18),transparent_24%),linear-gradient(145deg,#020617,#010713_45%,#000)]" />
        <div className="absolute inset-0 opacity-25 bg-[linear-gradient(90deg,rgba(255,255,255,.055)_1px,transparent_1px),linear-gradient(0deg,rgba(255,255,255,.055)_1px,transparent_1px)] bg-[size:54px_54px]" />
        <div className="absolute -bottom-28 left-1/2 h-96 w-[1100px] -translate-x-1/2 rounded-full bg-emerald-400/10 blur-3xl" />

        <div className="relative mx-auto max-w-7xl">
          <nav className="mb-8 flex items-center justify-between rounded-full border border-white/10 bg-white/[0.045] px-5 py-4 shadow-2xl shadow-emerald-950/30 backdrop-blur-xl">
            <a href="/" className="text-xl font-black">
              קו <span className="text-emerald-400">פתוח</span>
            </a>

            <div className="hidden items-center gap-2 text-sm font-bold text-slate-300 md:flex">
              {navItems.map((item) => (
                <a
                  key={item.key}
                  href={item.href}
                  className={[
                    "rounded-full px-4 py-2 transition",
                    active === item.key ? "bg-emerald-400 text-[#03120b]" : "hover:bg-white/10",
                  ].join(" ")}
                >
                  {item.label}
                </a>
              ))}
            </div>

            <a href="/customer" className="rounded-full bg-emerald-400 px-5 py-3 font-black text-[#03120b] shadow-[0_0_32px_rgba(16,185,129,.35)]">
              פתח קריאה
            </a>
          </nav>

          <div className="mb-5 inline-flex rounded-full border border-emerald-300/25 bg-emerald-300/10 px-4 py-2 text-sm font-bold text-emerald-200">
            {badge}
          </div>

          {children}

          <footer className="py-10 text-center text-sm text-slate-400">
            {product.sentence}
          </footer>
        </div>
      </section>
    </main>
  );
}
