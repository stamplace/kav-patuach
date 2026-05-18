import { product } from "@/lib/product";

const promises = [
  "קריאה במקום הזמנה",
  "נהגים מאומתים על הקו",
  "בחירה לפי אמון וזמינות",
  "בקרה מרכזית בלי לחנוק את הנהגים",
];

export default function Landing() {
  return (
    <main dir="rtl" className="min-h-screen overflow-hidden bg-[#030712] text-white">
      <section className="relative px-5 py-8 sm:px-10">
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_top,#10b98133,transparent_35%),radial-gradient(circle_at_left,#38bdf833,transparent_28%)]" />

        <div className="relative mx-auto max-w-7xl">
          <nav className="flex items-center justify-between rounded-full border border-white/10 bg-white/[0.04] px-5 py-4 backdrop-blur">
            <div>
              <p className="text-xl font-black">{product.name}</p>
              <p className="text-xs text-emerald-300">{product.subtitle}</p>
            </div>
            <a href="/customer" className="rounded-full bg-emerald-400 px-5 py-3 font-black text-slate-950">
              פתח קריאה
            </a>
          </nav>

          <div className="grid min-h-[78vh] gap-10 py-16 lg:grid-cols-[1.05fr_.95fr] lg:items-center">
            <div>
              <p className="mb-5 inline-flex rounded-full border border-emerald-300/25 bg-emerald-300/10 px-4 py-2 text-sm font-bold text-emerald-200">
                תחנת מוניות בלי תחנה
              </p>

              <h1 className="max-w-4xl text-6xl font-black leading-[0.95] tracking-tight sm:text-8xl">
                {product.name}
              </h1>

              <p className="mt-7 max-w-2xl text-3xl font-black leading-tight text-slate-100">
                {product.sentence}
              </p>

              <p className="mt-6 max-w-2xl text-lg leading-8 text-slate-300">
                תשתית קריאות שבה לקוח פותח צורך, נהגים מאומתים מגיבים בזמן אמת,
                והמנהל שומר על סדר, אמון ובקרה.
              </p>

              <div className="mt-10 flex flex-wrap gap-4">
                <a href="/customer" className="rounded-2xl bg-emerald-400 px-7 py-4 text-lg font-black text-slate-950">
                  כניסה ללקוח
                </a>
                <a href="/driver" className="rounded-2xl border border-white/15 bg-white/10 px-7 py-4 text-lg font-black">
                  כניסה לנהג
                </a>
                <a href="/admin" className="rounded-2xl border border-white/15 bg-white/10 px-7 py-4 text-lg font-black">
                  כניסה למנהל
                </a>
              </div>
            </div>

            <div className="rounded-[2.5rem] border border-white/10 bg-white/[0.05] p-5 shadow-[0_0_80px_rgba(16,185,129,.16)]">
              <div className="rounded-[2rem] bg-[#07111f] p-5">
                <div className="mb-5 flex items-center justify-between">
                  <span className="font-black">מפת קריאות חיה</span>
                  <span className="rounded-full bg-emerald-400/15 px-3 py-1 text-sm text-emerald-200">Live</span>
                </div>

                <div className="relative h-80 overflow-hidden rounded-[1.75rem] border border-emerald-300/20 bg-[#020617]">
                  <div className="absolute inset-0 bg-[linear-gradient(90deg,rgba(255,255,255,.06)_1px,transparent_1px),linear-gradient(0deg,rgba(255,255,255,.06)_1px,transparent_1px)] bg-[size:40px_40px] opacity-50" />
                  <div className="absolute left-1/2 top-1/2 h-36 w-36 -translate-x-1/2 -translate-y-1/2 rounded-full bg-emerald-400/20 blur-3xl" />
                  <div className="absolute right-8 top-8 rounded-2xl border border-emerald-300/20 bg-black/50 px-4 py-3 text-sm">קריאה פתוחה</div>
                  <div className="absolute bottom-10 left-8 rounded-2xl border border-amber-300/20 bg-black/50 px-4 py-3 text-sm text-amber-200">אמון {product.trust}</div>
                  <div className="absolute left-1/2 top-1/2 grid h-24 w-24 -translate-x-1/2 -translate-y-1/2 place-items-center rounded-full border border-emerald-300 bg-emerald-400/20 text-4xl shadow-[0_0_60px_rgba(16,185,129,.5)]">
                    ◉
                  </div>
                </div>

                <div className="mt-5 grid gap-3 sm:grid-cols-2">
                  {promises.map((item) => (
                    <div key={item} className="rounded-2xl border border-white/10 bg-white/[0.04] p-4 font-bold text-slate-200">
                      {item}
                    </div>
                  ))}
                </div>
              </div>
            </div>
          </div>

          <section className="grid gap-4 pb-10 sm:grid-cols-2 lg:grid-cols-4">
            {product.endpoints.map((endpoint) => (
              <a key={endpoint.path} href={endpoint.path} className="rounded-3xl border border-white/10 bg-white/[0.05] p-6 transition hover:bg-white/[0.08]">
                <p className="text-2xl font-black">{endpoint.title}</p>
                <p className="mt-3 text-sm leading-6 text-slate-300">{endpoint.role}</p>
                <p className="mt-5 font-mono text-emerald-300">{endpoint.path}</p>
              </a>
            ))}
          </section>
        </div>
      </section>
    </main>
  );
}
