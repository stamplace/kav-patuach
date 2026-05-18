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

const skyline = [48, 72, 38, 92, 58, 132, 86, 44, 116, 64, 152, 80, 54, 104, 68, 40, 126, 78];

function CityBackdrop() {
  return (
    <>
      <div
        className="absolute inset-0"
        style={{
          background:
            "radial-gradient(circle at 50% -8%, rgba(16,185,129,.46), transparent 27%), radial-gradient(circle at 8% 32%, rgba(14,165,233,.22), transparent 22%), linear-gradient(145deg, #031d1a 0%, #061522 34%, #020711 70%, #000 100%)",
        }}
      />
      <div
        className="absolute inset-0 opacity-20"
        style={{
          backgroundImage:
            "linear-gradient(90deg, rgba(255,255,255,.08) 1px, transparent 1px), linear-gradient(0deg, rgba(255,255,255,.08) 1px, transparent 1px)",
          backgroundSize: "52px 52px",
        }}
      />
      <div
        className="absolute inset-x-0 top-0 h-72 opacity-45"
        style={{
          background:
            "radial-gradient(ellipse at center, rgba(16,185,129,.24), transparent 62%)",
        }}
      />
      <div className="absolute inset-x-0 bottom-0 h-56 bg-gradient-to-t from-black via-black/70 to-transparent" />
      <div className="absolute bottom-0 left-0 right-0 flex h-44 items-end justify-center gap-2 px-4 opacity-45">
        {skyline.map((height, index) => (
          <span
            key={`${height}-${index}`}
            className="w-8 rounded-t-sm border border-white/10 bg-slate-900/80 shadow-[0_0_18px_rgba(16,185,129,.12)]"
            style={{ height: `${height}px` }}
          />
        ))}
      </div>
    </>
  );
}

export function ProductShell({ active, badge, children }: ProductShellProps) {
  return (
    <main dir="rtl" aria-label={badge} className="min-h-screen overflow-hidden bg-[#02070f] text-white">
      <section className="relative min-h-screen px-4 pb-24 pt-4 sm:px-8 sm:pb-8">
        <CityBackdrop />

        <div className="relative mx-auto max-w-7xl">
          <nav className="sticky top-3 z-30 mb-5 flex h-16 items-center justify-between rounded-full border border-white/10 bg-[#04111f]/88 px-4 shadow-2xl shadow-black/55 backdrop-blur-2xl">
            <a href="/" className="text-xl font-black tracking-tight">
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
              className="rounded-full bg-emerald-400 px-5 py-3 text-sm font-black text-[#03120b] shadow-[0_0_34px_rgba(16,185,129,.45)]"
            >
              פתח קריאה
            </a>
          </nav>

          {children}
        </div>

        <nav className="fixed inset-x-3 bottom-3 z-40 grid grid-cols-5 rounded-[1.7rem] border border-white/10 bg-[#041120]/94 p-2 shadow-2xl shadow-black/70 backdrop-blur-2xl md:hidden">
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
