import { ProductShell } from "@/components/ProductShell";
import {
  GlowCard,
  LiveMap,
  MetricCard,
  PhoneFrame,
  StatusPill,
  TrustBadge,
  DriverOfferCard,
} from "@/components/visual/PremiumPrimitives";

const driverOffers = [
  { name: "אבי", eta: "4 דק׳", trust: "96%", note: "קרוב אליך" },
  { name: "רפי", eta: "7 דק׳", trust: "98%", note: "נהג זהב" },
  { name: "משה", eta: "11 דק׳", trust: "95%", note: "הצעה טובה" },
];

const liveCalls = [
  { route: "בני ברק → פתח תקווה", eta: "4 דק׳", value: "₪68", status: "פתוחה" },
  { route: "רמת גן → ירושלים", eta: "9 דק׳", value: "₪240", status: "משתלמת" },
  { route: "אלעד → נתב״ג", eta: "14 דק׳", value: "₪180", status: "קבועה" },
];

const adminMetrics = [
  { label: "קריאות", value: "248" },
  { label: "נהגים", value: "1,458" },
  { label: "דיווחים", value: "23" },
  { label: "אמון", value: "98%" },
];

function AppHeader({ title, badge }: { title: string; badge: string }) {
  return (
    <div className="mb-6 flex items-center justify-between gap-4">
      <div>
        <p className="text-sm font-black text-emerald-300">{badge}</p>
        <h1 className="mt-2 text-5xl font-black tracking-tight">{title}</h1>
      </div>
      <StatusPill tone="emerald">Live</StatusPill>
    </div>
  );
}

function PhoneTop() {
  return (
    <div className="mb-5 flex items-center justify-between border-b border-white/10 pb-4">
      <span className="text-xl font-black">
        קו <span className="text-emerald-400">פתוח</span>
      </span>
      <span className="text-2xl leading-none">☰</span>
    </div>
  );
}

function PrimaryAction({ children }: { children: string }) {
  return (
    <button className="w-full rounded-[1.7rem] bg-emerald-400 p-5 text-3xl font-black text-[#03120b] shadow-[0_0_48px_rgba(16,185,129,.34)]">
      {children}
    </button>
  );
}

function Field({ label }: { label: string }) {
  return (
    <div className="rounded-2xl border border-white/10 bg-black/35 p-5 text-xl font-bold text-slate-200">
      {label}
    </div>
  );
}

export function HomeSurface() {
  return (
    <ProductShell active="home" badge="קו פתוח">
      <section className="grid min-h-[76vh] gap-10 lg:grid-cols-[1fr_460px] lg:items-center">
        <div>
          <StatusPill tone="emerald">Live Network</StatusPill>
          <h1 className="mt-6 text-7xl font-black leading-[.9] tracking-tight sm:text-9xl">
            קו <span className="text-emerald-400">פתוח</span>
          </h1>
          <p className="mt-7 max-w-2xl text-3xl font-black leading-tight">
            קריאה. נהג. נסיעה.
          </p>

          <div className="mt-10 grid gap-4 sm:grid-cols-2">
            {[
              { href: "/customer", title: "פתח קריאה" },
              { href: "/driver", title: "אני על הקו" },
              { href: "/admin", title: "לוח בקרה" },
              { href: "/experience", title: "חוויה" },
            ].map((item) => (
              <a key={item.href} href={item.href} className="rounded-[2rem] border border-white/10 bg-white/[0.055] p-6 text-2xl font-black shadow-2xl shadow-black/25 transition hover:-translate-y-1 hover:bg-white/[0.08]">
                {item.title}
              </a>
            ))}
          </div>
        </div>

        <PhoneFrame>
          <PhoneTop />
          <LiveMap className="h-80" />
          <div className="mt-5 grid grid-cols-[1fr_auto] gap-3">
            <GlowCard className="rounded-[1.6rem] p-4">
              <p className="text-sm font-bold text-slate-400">קריאה פעילה</p>
              <p className="mt-1 text-2xl font-black">3 נהגים הגיבו</p>
            </GlowCard>
            <TrustBadge value="98%" />
          </div>
          <a href="/customer" className="mt-5 block rounded-[1.7rem] bg-emerald-400 p-5 text-center text-3xl font-black text-[#03120b]">
            פתח קריאה
          </a>
        </PhoneFrame>
      </section>
    </ProductShell>
  );
}

export function CustomerSurface() {
  return (
    <ProductShell active="customer" badge="לקוח">
      <section className="grid gap-8 lg:grid-cols-[460px_1fr] lg:items-start">
        <PhoneFrame>
          <PhoneTop />
          <h1 className="text-center text-5xl font-black">לאן נוסעים?</h1>

          <div className="mt-7 rounded-[2rem] border border-white/10 bg-white/[0.045] p-5">
            <div className="space-y-4">
              <Field label="מאיפה אוספים אותך?" />
              <Field label="יעד הנסיעה" />
              <div className="grid grid-cols-2 gap-3">
                <button className="rounded-2xl border border-emerald-300 bg-emerald-400/10 p-4 text-xl font-black text-emerald-200">עכשיו</button>
                <button className="rounded-2xl border border-white/10 bg-black/30 p-4 text-xl font-black text-slate-400">מאוחר יותר</button>
              </div>
            </div>

            <LiveMap className="mt-5 h-56" />
            <div className="mt-5">
              <PrimaryAction>פתח קריאה</PrimaryAction>
            </div>
          </div>
        </PhoneFrame>

        <div>
          <AppHeader title="נהגים" badge="3 תגובות" />
          <div className="grid gap-4 md:grid-cols-3">
            {driverOffers.map((offer) => (
              <DriverOfferCard key={offer.name} {...offer} />
            ))}
          </div>

          <div className="mt-6 grid gap-4 md:grid-cols-3">
            <MetricCard label="זמן ממוצע" value="7 דק׳" />
            <MetricCard label="אמון" value="98%" />
            <MetricCard label="נסיעות היום" value="248" />
          </div>
        </div>
      </section>
    </ProductShell>
  );
}

export function DriverSurface() {
  return (
    <ProductShell active="driver" badge="נהג">
      <section className="grid gap-8 lg:grid-cols-[430px_1fr] lg:items-start">
        <PhoneFrame>
          <PhoneTop />
          <div className="mb-5 rounded-[1.7rem] bg-emerald-400 p-5 text-center text-3xl font-black text-[#03120b]">
            אני על הקו
          </div>
          <LiveMap className="h-72" />
          <div className="mt-5 grid grid-cols-2 gap-3">
            <MetricCard label="היום" value="₪740" />
            <MetricCard label="אמון" value="98%" />
          </div>
        </PhoneFrame>

        <div>
          <AppHeader title="קריאות" badge="עבודה חיה" />
          <div className="grid gap-4">
            {liveCalls.map((call) => (
              <GlowCard key={call.route} className="grid gap-4 md:grid-cols-[1fr_auto] md:items-center">
                <div>
                  <StatusPill tone="emerald">{call.status}</StatusPill>
                  <h2 className="mt-3 text-3xl font-black">{call.route}</h2>
                  <p className="mt-2 text-slate-300">{call.eta} ממך</p>
                </div>
                <div className="flex items-center gap-4">
                  <span className="text-4xl font-black text-amber-200">{call.value}</span>
                  <button className="rounded-2xl bg-emerald-400 px-6 py-4 text-xl font-black text-[#03120b]">
                    קבל
                  </button>
                </div>
              </GlowCard>
            ))}
          </div>
        </div>
      </section>
    </ProductShell>
  );
}

export function AdminSurface() {
  return (
    <ProductShell active="admin" badge="ניהול">
      <section>
        <AppHeader title="לוח בקרה" badge="ניהול" />

        <div className="grid gap-4 md:grid-cols-4">
          {adminMetrics.map((metric) => (
            <MetricCard key={metric.label} {...metric} />
          ))}
        </div>

        <div className="mt-6 grid gap-6 lg:grid-cols-[1fr_1fr]">
          <GlowCard>
            <h2 className="text-3xl font-black">קריאות פעילות</h2>
            <div className="mt-5 space-y-4">
              {liveCalls.map((call) => (
                <div key={call.route} className="flex items-center justify-between rounded-2xl border border-white/10 bg-black/25 p-4">
                  <div>
                    <p className="text-xl font-black">{call.route}</p>
                    <p className="text-sm text-slate-400">{call.eta}</p>
                  </div>
                  <span className="rounded-full bg-emerald-400/15 px-3 py-1 font-bold text-emerald-200">{call.status}</span>
                </div>
              ))}
            </div>
          </GlowCard>

          <GlowCard>
            <h2 className="text-3xl font-black">אזורים חמים</h2>
            <LiveMap className="mt-5 h-80" />
          </GlowCard>

          <GlowCard>
            <h2 className="text-3xl font-black">נהגים לאישור</h2>
            <div className="mt-5 space-y-4">
              {["רפי כהן", "אבי לוי", "משה ישראל"].map((name) => (
                <div key={name} className="flex items-center justify-between rounded-2xl border border-white/10 bg-black/25 p-4">
                  <span className="text-xl font-black">{name}</span>
                  <button className="rounded-full bg-emerald-400 px-4 py-2 font-black text-[#03120b]">אשר</button>
                </div>
              ))}
            </div>
          </GlowCard>

          <GlowCard>
            <h2 className="text-3xl font-black">דיווחים לבדיקה</h2>
            <div className="mt-5 space-y-4">
              {["התנהגות לא הולמת", "ביטול חריג", "נהיגה לא בטוחה"].map((item) => (
                <div key={item} className="rounded-2xl border border-amber-300/20 bg-amber-300/10 p-4 font-bold text-amber-100">
                  {item}
                </div>
              ))}
            </div>
          </GlowCard>
        </div>
      </section>
    </ProductShell>
  );
}

export function ExperienceSurface() {
  return (
    <ProductShell active="experience" badge="אפליקציה חיה">
      <section className="grid gap-8">
        <HomeSurface />
      </section>
    </ProductShell>
  );
}
