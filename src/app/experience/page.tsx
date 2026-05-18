import { ProductShell } from "@/components/ProductShell";
import { GlowCard, LiveMap, MetricCard, PhoneFrame, StatusPill, TrustBadge } from "@/components/visual/PremiumPrimitives";

export default function Experience() {
  return (
    <ProductShell active="experience" badge="חוויה">
      <section className="grid gap-8">
        <section className="grid min-h-[72vh] gap-10 lg:grid-cols-[1fr_460px] lg:items-center">
          <div>
            <StatusPill tone="emerald">Live Network</StatusPill>
            <h1 className="mt-6 text-7xl font-black leading-[.9] tracking-tight sm:text-9xl">
              קו פתוח
            </h1>
            <p className="mt-7 max-w-2xl text-3xl font-black leading-tight text-slate-100">
              קריאה. נהג. נסיעה.
            </p>

            <div className="mt-10 grid gap-4 sm:grid-cols-3">
              <MetricCard label="קריאות" value="248" />
              <MetricCard label="נהגים" value="1,458" />
              <MetricCard label="אמון" value="98%" />
            </div>
          </div>

          <PhoneFrame>
            <div className="mb-5 flex items-center justify-between border-b border-white/10 pb-4">
              <span className="text-xl font-black">
                קו <span className="text-emerald-400">פתוח</span>
              </span>
              <StatusPill tone="blue">Live</StatusPill>
            </div>

            <LiveMap className="h-80" />

            <div className="mt-5 grid grid-cols-[1fr_auto] gap-3">
              <GlowCard className="rounded-[1.6rem] p-4">
                <p className="text-sm font-bold text-slate-400">מצב רשת</p>
                <p className="mt-1 text-2xl font-black">פעילה</p>
              </GlowCard>
              <TrustBadge value="98%" />
            </div>
          </PhoneFrame>
        </section>

        <section className="grid gap-4 lg:grid-cols-3">
          {[
            { href: "/customer", title: "לקוח", action: "פתח קריאה" },
            { href: "/driver", title: "נהג", action: "אני על הקו" },
            { href: "/admin", title: "ניהול", action: "לוח בקרה" },
          ].map((item) => (
            <a key={item.href} href={item.href} className="rounded-[2rem] border border-white/10 bg-white/[0.055] p-6 shadow-2xl shadow-black/25 transition hover:-translate-y-1 hover:bg-white/[0.08]">
              <p className="text-sm font-black text-emerald-300">{item.title}</p>
              <h2 className="mt-3 text-4xl font-black">{item.action}</h2>
              <p className="mt-5 font-mono text-emerald-300">{item.href}</p>
            </a>
          ))}
        </section>
      </section>
    </ProductShell>
  );
}
