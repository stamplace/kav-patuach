import {
  GlowCard,
  LiveMap,
  PhoneFrame,
  StatusPill,
  TrustBadge,
  DriverOfferCard,
  MetricCard,
} from "@/components/visual/PremiumPrimitives";

const driverOffers = [
  { name: "אבי", eta: "4 דקות", trust: "96%", note: "קרוב אליך" },
  { name: "רפי", eta: "7 דקות", trust: "98%", note: "נהג זהב" },
  { name: "משה", eta: "11 דקות", trust: "95%", note: "הצעה טובה" },
];

const adminMetrics = [
  { label: "קריאות פעילות", value: "248" },
  { label: "נהגים מחוברים", value: "1,458" },
  { label: "דיווחים לבדיקה", value: "23" },
  { label: "שביעות רצון", value: "98%" },
];

export function ReferenceHeroPoster() {
  return (
    <section className="relative overflow-hidden rounded-[3rem] border border-white/10 bg-black/30 p-8 shadow-[0_0_120px_rgba(16,185,129,.12)]">
      <div className="absolute inset-0 bg-[radial-gradient(circle_at_50%_35%,rgba(16,185,129,.28),transparent_28%),linear-gradient(180deg,rgba(2,6,23,.15),rgba(0,0,0,.88))]" />
      <div className="absolute inset-0 opacity-25 bg-[linear-gradient(90deg,rgba(255,255,255,.055)_1px,transparent_1px),linear-gradient(0deg,rgba(255,255,255,.055)_1px,transparent_1px)] bg-[size:52px_52px]" />

      <div className="relative mx-auto grid max-w-6xl gap-10 lg:grid-cols-[1fr_420px] lg:items-center">
        <div>
          <p className="text-sm font-black tracking-[.35em] text-emerald-300">רשת קריאות לנהגים ולקוחות</p>
          <h1 className="mt-5 text-7xl font-black leading-[.9] tracking-tight sm:text-9xl">
            קו <span className="text-emerald-400">פתוח</span>
          </h1>
          <p className="mt-6 max-w-2xl text-3xl font-black leading-tight text-slate-100">
            פותחים קריאה. בוחרים נהג. נוסעים יחד.
          </p>

          <div className="mt-10 grid gap-4 sm:grid-cols-3">
            {["נוסעים באמון", "נהגים עצמאיים", "לקוחות מחוברים"].map((item) => (
              <GlowCard key={item} className="p-4">
                <p className="text-lg font-black">{item}</p>
              </GlowCard>
            ))}
          </div>
        </div>

        <PhoneFrame>
          <div className="mb-5 flex items-center justify-between">
            <span className="font-black">קו <span className="text-emerald-400">פתוח</span></span>
            <StatusPill tone="blue">Live</StatusPill>
          </div>
          <LiveMap className="h-80" />
          <a href="/experience" className="mt-5 block rounded-2xl bg-emerald-400 p-4 text-center text-xl font-black text-[#03120b]">
            פתח חוויה
          </a>
        </PhoneFrame>
      </div>
    </section>
  );
}

export function ReferenceCustomerCallForm() {
  return (
    <PhoneFrame>
      <div className="mb-5 flex items-center justify-between">
        <span className="font-black">קו <span className="text-emerald-400">פתוח</span></span>
        <span className="text-2xl">☰</span>
      </div>

      <h2 className="text-center text-5xl font-black">לאן נוסעים?</h2>

      <div className="mt-7 rounded-[2rem] border border-white/10 bg-white/[0.045] p-5">
        <div className="space-y-4">
          <div className="rounded-2xl border border-white/10 bg-black/35 p-5 text-xl text-slate-200">
            מאיפה אוספים אותך?
          </div>
          <div className="rounded-2xl border border-white/10 bg-black/35 p-5 text-xl text-slate-200">
            יעד הנסיעה
          </div>
          <div className="grid grid-cols-2 gap-3">
            <button className="rounded-2xl border border-emerald-300 bg-emerald-400/10 p-4 text-xl font-black text-emerald-200">
              עכשיו
            </button>
            <button className="rounded-2xl border border-white/10 bg-black/30 p-4 text-xl font-black text-slate-400">
              מאוחר יותר
            </button>
          </div>
        </div>

        <LiveMap className="mt-5 h-56" />

        <button className="mt-5 w-full rounded-[1.7rem] bg-emerald-400 p-5 text-3xl font-black text-[#03120b] shadow-[0_0_40px_rgba(16,185,129,.28)]">
          פתח קריאה
        </button>
      </div>
    </PhoneFrame>
  );
}

export function ReferenceTrustPhone() {
  return (
    <PhoneFrame>
      <div className="mb-5 flex items-center justify-between">
        <span className="font-black">קו <span className="text-emerald-400">פתוח</span></span>
        <span className="text-2xl">☰</span>
      </div>

      <div className="text-center">
        <p className="text-2xl font-black text-slate-200">שכבת האמון שלנו</p>
        <div className="mx-auto mt-6 grid h-28 w-28 place-items-center rounded-full border border-amber-300/35 bg-amber-300/10 text-5xl text-amber-200 shadow-[0_0_60px_rgba(251,191,36,.18)]">
          ✓
        </div>
      </div>

      <div className="mt-6 rounded-[2rem] border border-emerald-300/30 bg-emerald-400/10 p-5 text-center">
        <p className="text-lg font-black">מדד אמון</p>
        <p className="text-7xl font-black text-emerald-300">98%</p>
      </div>

      <div className="mt-5 grid grid-cols-2 gap-4">
        {["נהג מאומת", "מסמכים נבדקו", "נסיעות סגורות", "תגובות לקוחות"].map((item) => (
          <GlowCard key={item} className="p-4 text-center">
            <p className="font-black">{item}</p>
            <p className="mt-2 text-emerald-300">✓</p>
          </GlowCard>
        ))}
      </div>
    </PhoneFrame>
  );
}

export function ReferenceDriverMapPhone() {
  return (
    <PhoneFrame>
      <div className="mb-5 flex items-center justify-between">
        <span className="font-black">קו <span className="text-emerald-400">פתוח</span></span>
        <StatusPill>אני על הקו</StatusPill>
      </div>

      <LiveMap className="h-72" />

      <div className="mt-5 space-y-3">
        {[
          "קריאה קרובה · 2.1 ק״מ",
          "קריאה משתלמת · 5.8 ק״מ",
          "קריאה קרובה · 3.4 ק״מ",
        ].map((item) => (
          <GlowCard key={item} className="p-4">
            <p className="font-black">{item}</p>
            <p className="mt-1 text-sm text-slate-400">שינוע רכב · סטנדרטי</p>
          </GlowCard>
        ))}
      </div>
    </PhoneFrame>
  );
}

export function ReferenceDriverOfferStack() {
  return (
    <div className="grid gap-4">
      {driverOffers.map((offer) => (
        <DriverOfferCard key={offer.name} {...offer} />
      ))}
    </div>
  );
}

export function ReferenceAdminCommandCenter() {
  return (
    <section className="rounded-[3rem] border border-white/10 bg-white/[0.04] p-6 shadow-[0_0_120px_rgba(16,185,129,.10)]">
      <div className="mb-6 flex items-center justify-between">
        <div>
          <p className="text-sm font-black text-emerald-300">Command Center</p>
          <h2 className="text-5xl font-black">לוח בקרה</h2>
        </div>
        <StatusPill tone="emerald">Live</StatusPill>
      </div>

      <div className="grid gap-4 md:grid-cols-4">
        {adminMetrics.map((metric) => (
          <MetricCard key={metric.label} {...metric} />
        ))}
      </div>

      <div className="mt-6 grid gap-6 lg:grid-cols-2">
        <GlowCard>
          <h3 className="text-3xl font-black">קריאות פעילות</h3>
          <div className="mt-5 space-y-4">
            {["תל אביב יפו", "הרצליה", "חולון", "ראשון לציון"].map((city) => (
              <div key={city} className="flex items-center justify-between rounded-2xl border border-white/10 bg-black/25 p-4">
                <span className="font-bold">{city}</span>
                <span className="rounded-full bg-emerald-400/15 px-3 py-1 text-emerald-200">בשידור</span>
              </div>
            ))}
          </div>
        </GlowCard>

        <GlowCard>
          <h3 className="text-3xl font-black">אזורים חמים</h3>
          <LiveMap className="mt-5 h-72" />
        </GlowCard>
      </div>
    </section>
  );
}
