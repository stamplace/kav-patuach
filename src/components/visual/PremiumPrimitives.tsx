import type { ReactNode } from "react";

type BaseProps = {
  children?: ReactNode;
  className?: string;
};

export function GlowCard({ children, className = "" }: BaseProps) {
  return (
    <div className={`rounded-[2rem] border border-white/10 bg-white/[0.055] p-5 shadow-2xl shadow-black/25 backdrop-blur-xl ${className}`}>
      {children}
    </div>
  );
}

export function StatusPill({ children, tone = "emerald" }: BaseProps & { tone?: "emerald" | "amber" | "blue" }) {
  const tones = {
    emerald: "border-emerald-300/25 bg-emerald-300/10 text-emerald-200",
    amber: "border-amber-300/25 bg-amber-300/10 text-amber-200",
    blue: "border-sky-300/25 bg-sky-300/10 text-sky-200",
  };

  return (
    <span className={`inline-flex rounded-full border px-4 py-2 text-sm font-black ${tones[tone]}`}>
      {children}
    </span>
  );
}

export function TrustBadge({ value = "98%" }: { value?: string }) {
  return (
    <div className="rounded-2xl border border-amber-300/25 bg-amber-300/10 px-4 py-3 text-amber-100 shadow-[0_0_30px_rgba(251,191,36,.12)]">
      <p className="text-xs font-bold text-amber-200/80">מדד אמון</p>
      <p className="text-3xl font-black">{value}</p>
    </div>
  );
}

export function CallBubble({ label, className = "" }: { label: string; className?: string }) {
  return (
    <div className={`absolute rounded-2xl border border-emerald-300/25 bg-black/55 px-4 py-3 text-sm font-bold text-emerald-100 shadow-[0_0_30px_rgba(16,185,129,.16)] backdrop-blur ${className}`}>
      {label}
    </div>
  );
}

export function DriverMarker({ label, className = "" }: { label: string; className?: string }) {
  return (
    <div className={`absolute grid place-items-center ${className}`}>
      <div className="h-4 w-4 rounded-full bg-emerald-300 shadow-[0_0_24px_rgba(16,185,129,.95)]" />
      <div className="mt-2 rounded-full border border-white/10 bg-black/60 px-3 py-1 text-[11px] font-black text-emerald-100 backdrop-blur">
        {label}
      </div>
    </div>
  );
}

export function LiveMap({ className = "" }: { className?: string }) {
  return (
    <div className={`relative overflow-hidden rounded-[2rem] border border-emerald-300/20 bg-[#020617] ${className}`}>
      <div className="absolute inset-0 bg-[linear-gradient(90deg,rgba(255,255,255,.06)_1px,transparent_1px),linear-gradient(0deg,rgba(255,255,255,.06)_1px,transparent_1px)] bg-[size:38px_38px] opacity-45" />
      <div className="absolute inset-0 bg-[radial-gradient(circle_at_52%_48%,rgba(16,185,129,.25),transparent_26%),radial-gradient(circle_at_25%_25%,rgba(56,189,248,.16),transparent_20%)]" />

      <div className="absolute left-[18%] top-[60%] h-[2px] w-[68%] -rotate-12 rounded-full bg-emerald-300/40 shadow-[0_0_22px_rgba(16,185,129,.55)]" />
      <div className="absolute left-[28%] top-[34%] h-[2px] w-[48%] rotate-[28deg] rounded-full bg-sky-300/30 shadow-[0_0_18px_rgba(56,189,248,.45)]" />
      <div className="absolute left-[35%] top-[72%] h-[2px] w-[34%] -rotate-[42deg] rounded-full bg-amber-300/30 shadow-[0_0_18px_rgba(251,191,36,.45)]" />

      <div className="absolute left-1/2 top-1/2 grid h-28 w-28 -translate-x-1/2 -translate-y-1/2 place-items-center rounded-full border border-emerald-300 bg-emerald-400/20 text-4xl shadow-[0_0_80px_rgba(16,185,129,.62)]">
        ◉
      </div>

      <DriverMarker label="אבי · 4 דק׳" className="right-[14%] top-[22%]" />
      <DriverMarker label="רפי · 7 דק׳" className="left-[18%] top-[30%]" />
      <DriverMarker label="משה · 11 דק׳" className="left-[30%] bottom-[20%]" />

      <div className="absolute right-8 top-8 rounded-2xl border border-emerald-300/25 bg-black/65 px-4 py-3 text-sm font-black text-emerald-100 shadow-[0_0_30px_rgba(16,185,129,.18)] backdrop-blur">
        קריאה פתוחה
      </div>

      <div className="absolute bottom-8 left-8 rounded-2xl border border-amber-300/25 bg-black/65 px-4 py-3 text-sm font-black text-amber-100 shadow-[0_0_30px_rgba(251,191,36,.16)] backdrop-blur">
        3 נהגים זמינים
      </div>
    </div>
  );
}

export function PhoneFrame({ children }: BaseProps) {
  return (
    <div className="relative mx-auto w-full max-w-[440px]">
      <div className="absolute -inset-8 rounded-[4rem] bg-emerald-400/20 blur-3xl" />
      <div className="relative rounded-[3rem] border border-white/15 bg-black p-3 shadow-[0_0_110px_rgba(16,185,129,.24)]">
        <div className="rounded-[2.35rem] border border-white/10 bg-[#07111f] p-5">
          {children}
        </div>
      </div>
    </div>
  );
}

export function MetricCard({ label, value }: { label: string; value: string }) {
  return (
    <GlowCard>
      <p className="text-sm font-bold text-slate-300">{label}</p>
      <p className="mt-3 text-4xl font-black text-emerald-300">{value}</p>
    </GlowCard>
  );
}

export function DriverOfferCard({ name, eta, trust, note }: { name: string; eta: string; trust: string; note: string }) {
  return (
    <GlowCard>
      <div className="mb-5 flex items-center justify-between gap-4">
        <div>
          <p className="text-2xl font-black">{name}</p>
          <p className="text-sm text-slate-300">{note}</p>
        </div>
        <StatusPill tone="amber">אמון {trust}</StatusPill>
      </div>
      <p className="font-black text-emerald-300">{eta} ממך</p>
      <button className="mt-5 w-full rounded-2xl border border-white/10 bg-white/10 p-3 font-black">
        בחר נהג
      </button>
    </GlowCard>
  );
}
