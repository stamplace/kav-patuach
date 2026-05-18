import { product } from "@/lib/product";

const flows = [
  {
    title: "לקוח",
    headline: "פותח קריאה",
    text: "הלקוח לא מזמין מונית. הוא פותח צורך חי על המפה.",
    cta: "פתח קריאה",
    path: "/customer",
  },
  {
    title: "נהג",
    headline: "עולה על הקו",
    text: "הנהג רואה קריאות, בוחר עבודה, ומנהל את היום שלו כעסק עצמאי.",
    cta: "אני על הקו",
    path: "/driver",
  },
  {
    title: "מנהל",
    headline: "שומר אמון",
    text: "המערכת מאשרת נהגים, בודקת דיווחים ושומרת על סדר.",
    cta: "לוח בקרה",
    path: "/admin",
  },
];

const signals = [
  "קריאות פתוחות",
  "נהגים מאומתים",
  "בחירה לפי אמון",
  "מפת פעילות חיה",
  "ניהול אזורים",
  "בקרה ודיווחים",
];

export default function Premium() {
  return (
    <main dir="rtl" className="min-h-screen overflow-hidden bg-[#010713] text-white">
      <section className="relative min-h-screen px-5 py-6 sm:px-8">
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_50%_0%,rgba(16,185,129,.30),transparent_30%),radial-gradient(circle_at_12%_28%,rgba(56,189,248,.18),transparent_24%),linear-gradient(145deg,#020617,#010713_45%,#000)]" />
        <div className="absolute inset-0 opacity-30 bg-[linear-gradient(90deg,rgba(255,255,255,.055)_1px,transparent_1px),linear-gradient(0deg,rgba(255,255,255,.055)_1px,transparent_1px)] bg-[size:54px_54px]" />
        <div className="absolute -bottom-28 left-1/2 h-96 w-[1100px] -translate-x-1/2 rounded-full bg-emerald-400/10 blur-3xl" />

        <div className="relative mx-auto max-w-7xl">
          <nav className="mb-8 flex items-center justify-between rounded-full border border-white/10 bg-white/[0.045] px-5 py-4 shadow-2xl shadow-emerald-950/30 backdrop-blur-xl">
            <a href="/" className="text-xl font-black">
              קו <span className="text-emerald-400">פתוח</span>
            </a>
            <div className="hidden items-center gap-2 text-sm font-bold text-slate-300 sm:flex">
              <a href="/customer" className="rounded-full px-4 py-2 hover:bg-white/10">לקוח</a>
              <a href="/driver" className="rounded-full px-4 py-2 hover:bg-white/10">נהג</a>
              <a href="/admin" className="rounded-full px-4 py-2 hover:bg-white/10">מנהל</a>
            </div>
            <a href="/customer" className="rounded-full bg-emerald-400 px-5 py-3 font-black text-[#03120b] shadow-[0_0_32px_rgba(16,185,129,.35)]">
              פתח קריאה
            </a>
          </nav>

          <section className="grid min-h-[82vh] gap-10 lg:grid-cols-[1fr_470px] lg:items-center">
            <div>
              <p className="mb-5 inline-flex rounded-full border border-emerald-300/25 bg-emerald-300/10 px-4 py-2 text-sm font-bold text-emerald-200">
                מוצר פרימיום · רשת קריאות חיה
              </p>

              <h1 className="max-w-4xl text-6xl font-black leading-[.92] tracking-tight sm:text-8xl">
                {product.name}
              </h1>

              <p className="mt-7 max-w-2xl text-3xl font-black leading-tight text-slate-100">
                {product.sentence}
              </p>

              <p className="mt-6 max-w-2xl text-lg leading-8 text-slate-300">
                תחנת מוניות בלי תחנה: לקוחות פותחים קריאות, נהגים עצמאיים מגיבים,
                והמערכת בונה שכבת אמון חיה סביב כל נסיעה.
              </p>

              <div className="mt-10 grid gap-3 sm:grid-cols-2">
                {signals.map((signal) => (
                  <div key={signal} className="rounded-2xl border border-white/10 bg-white/[0.05] p-4 font-bold text-slate-200 shadow-xl shadow-black/20">
                    <span className="ml-2 text-emerald-300">●</span>
                    {signal}
                  </div>
                ))}
              </div>
            </div>

            <div className="relative mx-auto w-full max-w-[440px]">
              <div className="absolute -inset-8 rounded-[4rem] bg-emerald-400/20 blur-3xl" />
              <div className="relative rounded-[3rem] border border-white/15 bg-black p-3 shadow-[0_0_100px_rgba(16,185,129,.22)]">
                <div className="rounded-[2.35rem] border border-white/10 bg-[#07111f] p-5">
                  <div className="mb-5 flex items-center justify-between">
                    <span className="font-black">קו <span className="text-emerald-400">פתוח</span></span>
                    <span className="rounded-full bg-white/10 px-3 py-1 text-xs text-slate-300">Live</span>
                  </div>

                  <div className="relative h-80 overflow-hidden rounded-[2rem] border border-emerald-300/20 bg-[#020617]">
                    <div className="absolute inset-0 bg-[linear-gradient(90deg,rgba(255,255,255,.06)_1px,transparent_1px),linear-gradient(0deg,rgba(255,255,255,.06)_1px,transparent_1px)] bg-[size:36px_36px] opacity-45" />
                    <div className="absolute left-1/2 top-1/2 h-40 w-40 -translate-x-1/2 -translate-y-1/2 rounded-full bg-emerald-400/20 blur-3xl" />
                    <div className="absolute right-8 top-8 rounded-2xl border border-emerald-300/20 bg-black/55 px-4 py-3 text-sm">קריאה פתוחה</div>
                    <div className="absolute bottom-8 left-8 rounded-2xl border border-amber-300/20 bg-black/55 px-4 py-3 text-sm text-amber-200">אמון {product.trust}</div>
                    <div className="absolute left-1/2 top-1/2 grid h-24 w-24 -translate-x-1/2 -translate-y-1/2 place-items-center rounded-full border border-emerald-300 bg-emerald-400/20 text-4xl shadow-[0_0_70px_rgba(16,185,129,.55)]">
                      ◉
                    </div>
                    <div className="absolute right-16 bottom-20 h-3 w-3 rounded-full bg-emerald-300 shadow-[0_0_20px_rgba(16,185,129,.9)]" />
                    <div className="absolute left-20 top-24 h-3 w-3 rounded-full bg-emerald-300 shadow-[0_0_20px_rgba(16,185,129,.9)]" />
                    <div className="absolute left-28 bottom-28 h-3 w-3 rounded-full bg-amber-300 shadow-[0_0_20px_rgba(251,191,36,.9)]" />
                  </div>

                  <div className="mt-5 rounded-[1.8rem] border border-white/10 bg-white/[0.045] p-4">
                    <h2 className="text-center text-2xl font-black">לאן נוסעים?</h2>
                    <div className="mt-4 space-y-3">
                      <div className="rounded-2xl border border-white/10 bg-black/30 p-4 text-slate-300">מאיפה אוספים אותך?</div>
                      <div className="rounded-2xl border border-white/10 bg-black/30 p-4 text-slate-300">יעד הנסיעה</div>
                    </div>
                    <button className="mt-5 w-full rounded-2xl bg-emerald-400 p-4 text-xl font-black text-[#03120b]">
                      פתח קריאה
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </section>

          <section className="grid gap-5 pb-12 lg:grid-cols-3">
            {flows.map((flow) => (
              <a key={flow.title} href={flow.path} className="group rounded-[2rem] border border-white/10 bg-white/[0.055] p-6 shadow-2xl shadow-black/20 transition hover:-translate-y-1 hover:bg-white/[0.08]">
                <p className="text-sm font-bold text-emerald-300">{flow.title}</p>
                <h2 className="mt-3 text-3xl font-black">{flow.headline}</h2>
                <p className="mt-4 min-h-16 leading-7 text-slate-300">{flow.text}</p>
                <div className="mt-6 inline-flex rounded-2xl bg-emerald-400 px-5 py-3 font-black text-[#03120b]">
                  {flow.cta}
                </div>
              </a>
            ))}
          </section>
        </div>
      </section>
    </main>
  );
}
