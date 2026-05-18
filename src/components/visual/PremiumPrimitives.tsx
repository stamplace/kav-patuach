import type { ReactNode } from "react";

type BaseProps = {
  children?: ReactNode;
  className?: string;
};

export function GlowCard({ children, className = "" }: BaseProps) {
  return (
    <div className={`rounded-[1.8rem] border border-white/10 bg-[#071523]/76 p-5 shadow-[0_26px_80px_rgba(0,0,0,.40)] backdrop-blur-2xl ${className}`}>
      {children}
    </div>
  );
}

export function StatusPill({ children, tone = "emerald" }: BaseProps & { tone?: "emerald" | "amber" | "blue" }) {
  const tones = {
    emerald: "border-emerald-300/25 bg-emerald-300/12 text-emerald-100 shadow-[0_0_24px_rgba(16,185,129,.14)]",
    amber: "border-amber-300/25 bg-amber-300/12 text-amber-100 shadow-[0_0_24px_rgba(251,191,36,.12)]",
    blue: "border-sky-300/25 bg-sky-300/12 text-sky-100 shadow-[0_0_24px_rgba(56,189,248,.12)]",
  };

  return (
    <span className={`inline-flex rounded-full border px-4 py-2 text-xs font-black tracking-wide backdrop-blur-xl ${tones[tone]}`}>
      {children}
    </span>
  );
}

export function TrustBadge({ value = "98%" }: { value?: string }) {
  return (
    <div className="rounded-2xl border border-amber-300/30 bg-amber-300/10 px-4 py-3 text-amber-100 shadow-[0_0_34px_rgba(251,191,36,.16)]">
      <p className="text-[11px] font-black text-amber-200/80">אמון</p>
      <p className="text-3xl font-black">{value}</p>
    </div>
  );
}

export function CallBubble({ label, className = "" }: { label: string; className?: string }) {
  return (
    <div className={`absolute rounded-2xl border border-emerald-300/25 bg-black/65 px-4 py-3 text-xs font-black text-emerald-100 shadow-[0_0_30px_rgba(16,185,129,.20)] backdrop-blur ${className}`}>
      {label}
    </div>
  );
}

export function DriverMarker({ label, className = "" }: { label: string; className?: string }) {
  return (
    <div className={`absolute grid place-items-center ${className}`}>
      <div className="h-4 w-4 rounded-full bg-emerald-300 shadow-[0_0_26px_rgba(16,185,129,1)]" />
      <div className="mt-2 rounded-full border border-white/10 bg-black/70 px-3 py-1 text-[11px] font-black text-emerald-100 backdrop-blur">
        {label}
      </div>
    </div>
  );
}

export function LiveMap({ className = "" }: { className?: string }) {
  return (
    <div className={`relative overflow-hidden rounded-[2rem] border border-emerald-300/20 bg-[#020817] ${className}`}>
      <div
        className="absolute inset-0 opacity-55"
        style={{
          backgroundImage:
            "linear-gradient(90deg, rgba(255,255,255,.07) 1px, transparent 1px), linear-gradient(0deg, rgba(255,255,255,.07) 1px, transparent 1px)",
          backgroundSize: "34px 34px",
        }}
      />
      <div
        className="absolute inset-0"
        style={{
          background:
            "radial-gradient(circle at 50% 48%, rgba(16,185,129,.34), transparent 25%), radial-gradient(circle at 28% 28%, rgba(56,189,248,.18), transparent 18%), linear-gradient(135deg, rgba(2,6,23,.1), rgba(0,0,0,.55))",
        }}
      />

      <div className="absolute left-[14%] top-[61%] h-[3px] w-[74%] -rotate-12 rounded-full bg-emerald-300/50 shadow-[0_0_28px_rgba(16,185,129,.72)]" />
      <div className="absolute left-[24%] top-[35%] h-[2px] w-[50%] rotate-[28deg] rounded-full bg-sky-300/34 shadow-[0_0_20px_rgba(56,189,248,.48)]" />
      <div className="absolute left-[34%] top-[74%] h-[2px] w-[38%] -rotate-[42deg] rounded-full bg-amber-300/34 shadow-[0_0_20px_rgba(251,191,36,.48)]" />

      <div className="absolute left-1/2 top-1/2 grid h-28 w-28 -translate-x-1/2 -translate-y-1/2 place-items-center rounded-full border border-emerald-300 bg-emerald-400/18 text-4xl shadow-[0_0_86px_rgba(16,185,129,.70)]">
        ◉
      </div>

      <DriverMarker label="אבי · 4 דק׳" className="right-[12%] top-[22%]" />
      <DriverMarker label="רפי · 7 דק׳" className="left-[15%] top-[30%]" />
      <DriverMarker label="משה · 11 דק׳" className="left-[28%] bottom-[18%]" />

      <CallBubble label="קריאה פתוחה" className="right-5 top-5" />
      <CallBubble label="3 נהגים זמינים" className="bottom-5 left-5 border-amber-300/25 text-amber-100" />
    </div>
  );
}

export function PhoneFrame({ children }: BaseProps) {
  return (
    <div className="relative mx-auto w-full max-w-[350px] sm:max-w-[420px]">
      <div className="absolute -inset-7 rounded-[4rem] bg-emerald-400/22 blur-3xl" />
      <div className="relative rounded-[3rem] border border-white/20 bg-black p-2.5 shadow-[0_0_130px_rgba(16,185,129,.30),inset_0_0_24px_rgba(255,255,255,.08)]">
        <div className="pointer-events-none absolute left-1/2 top-3 z-20 h-7 w-28 -translate-x-1/2 rounded-full bg-black shadow-[0_0_18px_rgba(0,0,0,.7)]" />
        <div className="rounded-[2.45rem] border border-white/10 bg-[#07111f] p-4 pt-9 shadow-[inset_0_0_48px_rgba(15,23,42,.9)] sm:p-5 sm:pt-10">
          {children}
        </div>
      </div>
    </div>
  );
}

export function MetricCard({ label, value }: { label: string; value: string }) {
  return (
    <GlowCard className="p-4 sm:p-5">
      <p className="text-xs font-black text-slate-400">{label}</p>
      <p className="mt-2 text-4xl font-black tracking-tight text-emerald-300">{value}</p>
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
