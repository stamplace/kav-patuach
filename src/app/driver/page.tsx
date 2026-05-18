import { product } from "@/lib/product";

const calls = [
  { title: "בני ברק → פתח תקווה", tag: "קריאה קרובה", eta: "4 דקות", value: "₪68" },
  { title: "רמת גן → ירושלים", tag: "קריאה משתלמת", eta: "9 דקות", value: "₪240" },
  { title: "אלעד → נתב״ג", tag: "נסיעה קבועה", eta: "14 דקות", value: "₪180" },
];

const driverStats = [
  { label: "הכנסה היום", value: "₪740" },
  { label: "קריאות שנענו", value: "18" },
  { label: "אמון נהג", value: "98%" },
];

export default function Driver() {
  return (
    <main dir="rtl" className="min-h-screen bg-[#020617] px-5 py-6 text-white">
      <section className="mx-auto max-w-6xl">
        <nav className="mb-8 flex items-center justify-between rounded-full border border-white/10 bg-white/[0.04] px-5 py-4">
          <a href="/" className="font-black">{product.name}</a>
          <span className="rounded-full bg-emerald-400/15 px-4 py-2 text-sm font-bold text-emerald-200">ממשק נהג</span>
        </nav>

        <div className="grid gap-8 lg:grid-cols-[390px_1fr]">
          <aside className="rounded-[2.5rem] border border-white/10 bg-white/[0.05] p-5 shadow-[0_0_80px_rgba(16,185,129,.12)]">
            <div className="rounded-[2rem] bg-[#07111f] p-5">
              <p className="text-sm font-bold text-emerald-300">מצב עבודה</p>
              <h1 className="mt-3 text-5xl font-black">אני על הקו</h1>
              <p className="mt-4 leading-7 text-slate-300">
                הנהג רואה קריאות פתוחות באזור, מגיב בזמן אמת, ומנהל את היום שלו כמו עסק עצמאי.
              </p>

              <button className="mt-8 w-full rounded-2xl bg-emerald-400 p-5 text-xl font-black text-slate-950 shadow-[0_0_40px_rgba(16,185,129,.25)]">
                מחובר לקריאות
              </button>

              <div className="mt-6 grid gap-3">
                {driverStats.map((stat) => (
                  <div key={stat.label} className="flex items-center justify-between rounded-2xl border border-white/10 bg-black/25 p-4">
                    <span className="font-bold text-slate-300">{stat.label}</span>
                    <span className="text-2xl font-black text-emerald-300">{stat.value}</span>
                  </div>
                ))}
              </div>
            </div>
          </aside>

          <section className="grid gap-6">
            <div className="relative h-72 overflow-hidden rounded-[2.5rem] border border-emerald-300/20 bg-[#07111f] p-5">
              <div className="absolute inset-0 bg-[linear-gradient(90deg,rgba(255,255,255,.06)_1px,transparent_1px),linear-gradient(0deg,rgba(255,255,255,.06)_1px,transparent_1px)] bg-[size:42px_42px] opacity-40" />
              <div className="absolute right-8 top-8 rounded-2xl border border-emerald-300/20 bg-black/55 px-4 py-3 text-sm">אזור פעילות: גוש דן</div>
              <div className="absolute bottom-8 left-8 rounded-2xl border border-amber-300/20 bg-black/55 px-4 py-3 text-sm text-amber-200">3 קריאות חדשות</div>
              <div className="absolute left-1/2 top-1/2 grid h-24 w-24 -translate-x-1/2 -translate-y-1/2 place-items-center rounded-full border border-emerald-300 bg-emerald-400/20 text-4xl shadow-[0_0_60px_rgba(16,185,129,.5)]">
                ●
              </div>
            </div>

            <div>
              <div className="mb-4 flex items-end justify-between gap-4">
                <div>
                  <p className="text-sm font-bold text-emerald-300">קריאות פתוחות באזור</p>
                  <h2 className="text-3xl font-black">בחר קריאה לעבוד עליה</h2>
                </div>
                <span className="rounded-full border border-white/10 bg-white/5 px-4 py-2 text-sm text-slate-300">מתעדכן בזמן אמת</span>
              </div>

              <div className="grid gap-4">
                {calls.map((call) => (
                  <article key={call.title} className="grid gap-4 rounded-3xl border border-white/10 bg-white/[0.05] p-5 md:grid-cols-[1fr_auto] md:items-center">
                    <div>
                      <span className="rounded-full bg-emerald-400/15 px-3 py-1 text-sm font-bold text-emerald-200">{call.tag}</span>
                      <h3 className="mt-3 text-2xl font-black">{call.title}</h3>
                      <p className="mt-2 text-slate-300">{call.eta} ממך · לקוח ממתין לתגובה</p>
                    </div>
                    <div className="flex items-center gap-3">
                      <span className="text-3xl font-black text-amber-200">{call.value}</span>
                      <button className="rounded-2xl bg-emerald-400 px-5 py-4 font-black text-slate-950">
                        קבל קריאה
                      </button>
                    </div>
                  </article>
                ))}
              </div>
            </div>
          </section>
        </div>
      </section>
    </main>
  );
}
