import { product } from "@/lib/product";

const offers = [
  { name: "אבי", eta: "4 דקות", trust: "96%", note: "קרוב אליך" },
  { name: "רפי", eta: "7 דקות", trust: "98%", note: "נהג זהב" },
  { name: "משה", eta: "11 דקות", trust: "95%", note: "הצעה טובה" },
];

export default function Customer() {
  return (
    <main dir="rtl" className="min-h-screen bg-[#020617] px-5 py-6 text-white">
      <section className="mx-auto max-w-6xl">
        <nav className="mb-8 flex items-center justify-between rounded-full border border-white/10 bg-white/[0.04] px-5 py-4">
          <a href="/" className="font-black">{product.name}</a>
          <span className="rounded-full bg-emerald-400/15 px-4 py-2 text-sm font-bold text-emerald-200">ממשק לקוח</span>
        </nav>

        <div className="grid gap-8 lg:grid-cols-[420px_1fr] lg:items-start">
          <section className="rounded-[2.5rem] border border-white/10 bg-white/[0.05] p-5 shadow-[0_0_80px_rgba(16,185,129,.14)]">
            <div className="rounded-[2rem] bg-[#07111f] p-5">
              <p className="text-sm font-bold text-emerald-300">פעולת ליבה</p>
              <h1 className="mt-3 text-5xl font-black">פתח קריאה</h1>
              <p className="mt-4 leading-7 text-slate-300">
                במקום להזמין מונית — פותחים צורך. הנהגים באזור מגיבים, ואתה בוחר לפי אמון וזמן.
              </p>

              <div className="mt-8 space-y-4">
                <label className="block">
                  <span className="mb-2 block text-sm font-bold text-slate-300">מאיפה אוספים אותך?</span>
                  <div className="rounded-2xl border border-white/10 bg-black/30 p-4 text-slate-200">רחוב רבי עקיבא 12, בני ברק</div>
                </label>

                <label className="block">
                  <span className="mb-2 block text-sm font-bold text-slate-300">יעד הנסיעה</span>
                  <div className="rounded-2xl border border-white/10 bg-black/30 p-4 text-slate-200">פתח תקווה, מרכז העיר</div>
                </label>

                <div className="grid grid-cols-2 gap-3">
                  <button className="rounded-2xl bg-emerald-400 p-4 font-black text-slate-950">עכשיו</button>
                  <button className="rounded-2xl border border-white/10 bg-white/5 p-4 font-black">מאוחר יותר</button>
                </div>

                <button className="w-full rounded-2xl bg-emerald-400 p-5 text-xl font-black text-slate-950 shadow-[0_0_40px_rgba(16,185,129,.25)]">
                  פתח קריאה
                </button>
              </div>
            </div>
          </section>

          <section className="grid gap-6">
            <div className="relative h-80 overflow-hidden rounded-[2.5rem] border border-emerald-300/20 bg-[#07111f] p-5">
              <div className="absolute inset-0 bg-[linear-gradient(90deg,rgba(255,255,255,.06)_1px,transparent_1px),linear-gradient(0deg,rgba(255,255,255,.06)_1px,transparent_1px)] bg-[size:42px_42px] opacity-40" />
              <div className="absolute right-10 top-10 rounded-2xl border border-emerald-300/20 bg-black/55 px-4 py-3 text-sm">קריאה פתוחה</div>
              <div className="absolute bottom-10 left-8 rounded-2xl border border-amber-300/20 bg-black/55 px-4 py-3 text-sm text-amber-200">3 נהגים הגיבו</div>
              <div className="absolute left-1/2 top-1/2 grid h-24 w-24 -translate-x-1/2 -translate-y-1/2 place-items-center rounded-full border border-emerald-300 bg-emerald-400/20 text-4xl shadow-[0_0_60px_rgba(16,185,129,.5)]">
                ◉
              </div>
            </div>

            <div>
              <h2 className="mb-4 text-3xl font-black">תגובות נהגים</h2>
              <div className="grid gap-4 md:grid-cols-3">
                {offers.map((offer) => (
                  <article key={offer.name} className="rounded-3xl border border-white/10 bg-white/[0.05] p-5">
                    <div className="mb-5 flex items-center justify-between">
                      <div>
                        <p className="text-2xl font-black">{offer.name}</p>
                        <p className="text-sm text-slate-300">{offer.note}</p>
                      </div>
                      <span className="rounded-full bg-amber-300/15 px-3 py-1 text-sm font-bold text-amber-200">
                        אמון {offer.trust}
                      </span>
                    </div>
                    <p className="text-emerald-300 font-black">{offer.eta} ממך</p>
                    <button className="mt-5 w-full rounded-2xl border border-white/10 bg-white/10 p-3 font-black">
                      בחר נהג
                    </button>
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
