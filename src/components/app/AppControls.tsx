import type { ReactNode } from "react";
import { GlowCard, StatusPill } from "@/components/visual/PremiumPrimitives";

export function NeonButton({ children, href }: { children: ReactNode; href?: string }) {
  const className =
    "block w-full rounded-[1.7rem] bg-emerald-400 p-5 text-center text-2xl font-black text-[#03120b] shadow-[0_0_48px_rgba(16,185,129,.34)] transition hover:scale-[1.01]";

  if (href) {
    return (
      <a href={href} className={className}>
        {children}
      </a>
    );
  }

  return <button className={className}>{children}</button>;
}

export function AppField({ label, value }: { label: string; value?: string }) {
  return (
    <div className="rounded-2xl border border-white/10 bg-black/35 p-5">
      <p className="text-xs font-black text-slate-500">{label}</p>
      <p className="mt-1 text-xl font-black text-slate-100">{value || label}</p>
    </div>
  );
}

export function SegmentControl({ active = "עכשיו", items = ["עכשיו", "מאוחר יותר"] }: { active?: string; items?: string[] }) {
  return (
    <div className="grid grid-cols-2 gap-3">
      {items.map((item) => (
        <button
          key={item}
          className={[
            "rounded-2xl border p-4 text-lg font-black",
            item === active
              ? "border-emerald-300 bg-emerald-400/15 text-emerald-100"
              : "border-white/10 bg-black/30 text-slate-400",
          ].join(" ")}
        >
          {item}
        </button>
      ))}
    </div>
  );
}

export function ActionPanel({ title, subtitle, children }: { title: string; subtitle?: string; children: ReactNode }) {
  return (
    <GlowCard className="p-6">
      <div className="mb-5 flex items-center justify-between gap-4">
        <div>
          <p className="text-sm font-black text-emerald-300">{subtitle}</p>
          <h2 className="mt-1 text-3xl font-black">{title}</h2>
        </div>
        <StatusPill tone="emerald">Live</StatusPill>
      </div>
      {children}
    </GlowCard>
  );
}

export function RouteCard({
  route,
  eta,
  value,
  status,
  action = "קבל",
}: {
  route: string;
  eta: string;
  value: string;
  status: string;
  action?: string;
}) {
  return (
    <GlowCard className="grid gap-4 p-5 md:grid-cols-[1fr_auto] md:items-center">
      <div>
        <StatusPill tone="emerald">{status}</StatusPill>
        <h3 className="mt-3 text-3xl font-black">{route}</h3>
        <p className="mt-2 text-slate-300">{eta} ממך</p>
      </div>
      <div className="flex items-center gap-4">
        <span className="text-4xl font-black text-amber-200">{value}</span>
        <button className="rounded-2xl bg-emerald-400 px-6 py-4 text-xl font-black text-[#03120b]">
          {action}
        </button>
      </div>
    </GlowCard>
  );
}
