import type { ReactNode } from "react";

type SurfaceKey =
  | "home"
  | "premium"
  | "experience"
  | "landing"
  | "customer"
  | "driver"
  | "admin";

type ProductShellProps = {
  active: SurfaceKey;
  badge: string;
  children: ReactNode;
};

const navItems: { key: SurfaceKey; label: string; href: string }[] = [
  { key: "home", label: "בית", href: "/" },
  { key: "experience", label: "חוויה", href: "/experience" },
  { key: "customer", label: "לקוח", href: "/customer" },
  { key: "driver", label: "נהג", href: "/driver" },
  { key: "admin", label: "ניהול", href: "/admin" },
];

export function ProductShell({ active, badge, children }: ProductShellProps) {
  return (
    <main dir="rtl" className="min-h-screen overflow-hidden bg-[#02070f] text-white">
      <section className="relative min-h-screen px-4 pb-24 pt-4 sm:px-8 sm:pb-8">
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_50%_-4%,rgba(16,185,129,.42),transparent_28%),radial-gradient(circle_at_8%_25%,rgba(56,189,248,.20),transparent_23%),linear-gradient(145deg,#06251f_0%,#05111d_34%,#02070f_72%,#000_100%)]" />
        <div className="absolute inset-0 opacity-20 bg-[linear-gradient(90deg,rgba(255,255,255,.08)_1px,transparent_1px),linear-gradient(0deg,rgba(255,255,255,.08)_1px,transparent_1px)] bg-[size:52px_52px]" />
        <div className="absolute inset-x-0 bottom-0 h-64 bg-[linear-gradient(180deg,transparent,rgba(0,0,0,.45)),radial-gradient(circle_at_50%_100%,rgba(16,185,129,.22),transparent_38%)]" />
        <div className="absolute bottom-0 left-0 right-0 h-40 opacity-35 [background:linear-gradient(90deg,transparent_0_4%,rgba(255,255,255,.20)_4%_4.3%,transparent_4.3%_10%,rgba(16,185,129,.45)_10%_10.25%,transparent_10.25%_18%,rgba(255,255,255,.15)_18%_18.35%,transparent_18.35%_27%,rgba(255,255,255,.22)_27%_27.25%,transparent_27.25%_40%,rgba(16,185,129,.38)_40%_40.3%,transparent_40.3%_55%,rgba(255,255,255,.18)_55%_55.25%,transparent_55.25%_70%,rgba(16,185,129,.42)_70%_70.3%,transparent_70.3%_100%)]" />

        <div className="relative mx-auto max-w-7xl">
          <nav className="sticky top-3 z-30 mb-5 flex h-16 items-center justify-between rounded-full border border-white/10 bg-[#061421]/82 px-4 shadow-2xl shadow-black/40 backdrop-blur-2xl sm:h-18 sm:px-5">
            <a href="/" className="text-lg font-black tracking-tight sm:text-xl">
              קו <span className="text-emerald-400">פתוח</span>
            </a>

            <div className="hidden items-center gap-1 text-sm font-black text-slate-300 md:flex">
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

            <a
              href="/customer"
              className="rounded-full bg-emerald-400 px-5 py-3 text-sm font-black text-[#03120b] shadow-[0_0_34px_rgba(16,185,129,.38)]"
            >
              פתח קריאה
            </a>
          </nav>

          <div className="mb-4 inline-flex rounded-full border border-emerald-300/20 bg-emerald-300/10 px-4 py-2 text-xs font-black text-emerald-100 backdrop-blur-xl sm:mb-6">
            {badge}
          </div>

          {children}
        </div>

        <nav className="fixed inset-x-3 bottom-3 z-40 grid grid-cols-5 rounded-[1.7rem] border border-white/10 bg-[#041120]/92 p-2 shadow-2xl shadow-black/60 backdrop-blur-2xl md:hidden">
          {navItems.map((item) => (
            <a
              key={item.key}
              href={item.href}
              className={[
                "rounded-[1.2rem] px-2 py-3 text-center text-xs font-black transition",
                active === item.key ? "bg-emerald-400 text-[#03120b]" : "text-slate-300",
              ].join(" ")}
            >
              {item.label}
            </a>
          ))}
        </nav>
      </section>
    </main>
  );
}
