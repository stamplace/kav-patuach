import { ProductShell } from "@/components/ProductShell";
import { product } from "@/lib/product";

const queue = [
  { name: "רפי כהן", type: "נהג לאישור", status: "מסמכים לבדיקה" },
  { name: "אבי לוי", type: "דיווח לקוח", status: "דורש בדיקה" },
  { name: "קו בני ברק", type: "אזור חם", status: "פעילות גבוהה" },
];

const liveCalls = [
  { route: "בני ברק → פתח תקווה", driver: "רפי", state: "נהג בדרך" },
  { route: "אלעד → נתב״ג", driver: "משה", state: "קריאה פתוחה" },
  { route: "רמת גן → ירושלים", driver: "אבי", state: "הצעה נשלחה" },
];

export default function Admin() {
  return (
    <ProductShell active="admin" badge="ממשק מנהל · בקרה ואמון">
      <header className="mb-8 rounded-[2.5rem] border border-white/10 bg-white/[0.05] p-7">
        <p className="text-sm font-bold text-emerald-300">בקרה ואמון</p>
        <h1 className="mt-3 text-5xl font-black">לוח בקרה</h1>
        <p className="mt-4 max-w-2xl leading-7 text-slate-300">
          שכבת הניהול שומרת על אימות נהגים, קריאות פעילות, דיווחים, אזורים חמים ומדד אמון לרשת.
        </p>
      </header>

      <section className="grid gap-4 md:grid-cols-4">
        {product.adminStats.map((stat) => (
          <article key={stat.label} className="rounded-3xl border border-white/10 bg-white/[0.05] p-6">
            <p className="text-sm font-bold text-slate-300">{stat.label}</p>
            <p className="mt-3 text-4xl font-black text-emerald-300">{stat.value}</p>
          </article>
        ))}
      </section>

      <section className="mt-8 grid gap-8 lg:grid-cols-[1fr_420px]">
        <div className="rounded-[2.5rem] border border-white/10 bg-white/[0.05] p-6">
          <div className="mb-5 flex items-center justify-between">
            <div>
              <p className="text-sm font-bold text-emerald-300">פעילות בזמן אמת</p>
              <h2 className="text-3xl font-black">קריאות פעילות</h2>
            </div>
            <span className="rounded-full bg-emerald-400/15 px-4 py-2 text-sm font-bold text-emerald-200">Live</span>
          </div>

          <div className="grid gap-4">
            {liveCalls.map((call) => (
              <article key={call.route} className="grid gap-4 rounded-3xl border border-white/10 bg-black/25 p-5 md:grid-cols-[1fr_auto] md:items-center">
                <div>
                  <h3 className="text-2xl font-black">{call.route}</h3>
                  <p className="mt-2 text-slate-300">נהג: {call.driver}</p>
                </div>
                <span className="rounded-2xl border border-emerald-300/20 bg-emerald-400/10 px-4 py-3 font-black text-emerald-200">
                  {call.state}
                </span>
              </article>
            ))}
          </div>
        </div>

        <aside className="rounded-[2.5rem] border border-white/10 bg-white/[0.05] p-6">
          <p className="text-sm font-bold text-amber-300">דורש תשומת לב</p>
          <h2 className="mt-2 text-3xl font-black">תור בקרה</h2>

          <div className="mt-6 grid gap-4">
            {queue.map((item) => (
              <article key={item.name} className="rounded-3xl border border-white/10 bg-black/25 p-5">
                <p className="text-xl font-black">{item.name}</p>
                <p className="mt-2 text-slate-300">{item.type}</p>
                <p className="mt-4 rounded-full bg-amber-300/15 px-3 py-2 text-sm font-bold text-amber-200">
                  {item.status}
                </p>
              </article>
            ))}
          </div>
        </aside>
      </section>
    </ProductShell>
  );
}
