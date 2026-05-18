import { ProductShell } from "@/components/ProductShell";
import { GlowCard, LiveMap, PhoneFrame, StatusPill, TrustBadge } from "@/components/visual/PremiumPrimitives";
import { product } from "@/lib/product";

const links = [
  { href: "/experience", title: "חוויה", text: "המחשה חיה לפי תמונות הרפרנס" },
  { href: "/customer", title: "לקוח", text: "פתיחת קריאה ובחירת נהג" },
  { href: "/driver", title: "נהג", text: "אני על הקו וקריאות באזור" },
  { href: "/admin", title: "מנהל", text: "לוח בקרה, אמון ודיווחים" },
];

export default function Landing() {
  return (
    <ProductShell active="experience" badge="קו פתוח · Reference Product Surface">
      <section className="grid min-h-[76vh] gap-10 lg:grid-cols-[1fr_460px] lg:items-center">
        <div>
          <StatusPill tone="emerald">נבנה לפי תמונות הרפרנס</StatusPill>

          <h1 className="mt-6 max-w-4xl text-6xl font-black leading-[.92] tracking-tight sm:text-8xl">
            קו <span className="text-emerald-400">פתוח</span>
          </h1>

          <p className="mt-7 max-w-2xl text-3xl font-black leading-tight text-slate-100">
            {product.sentence}
          </p>

          <p className="mt-6 max-w-2xl text-lg leading-8 text-slate-300">
            תשתית קריאות פרימיום: עיר חיה, מפה זוהרת, נהגים מאומתים,
            מדדי אמון ודשבורד בקרה — לא עוד אתר, אלא מוצר תחבורה חזותי.
          </p>

          <div className="mt-10 grid gap-4 sm:grid-cols-2">
            {links.map((item) => (
              <a key={item.href} href={item.href} className="rounded-[2rem] border border-white/10 bg-white/[0.055] p-5 shadow-2xl shadow-black/25 transition hover:-translate-y-1 hover:bg-white/[0.08]">
                <p className="text-2xl font-black">{item.title}</p>
                <p className="mt-3 leading-7 text-slate-300">{item.text}</p>
                <p className="mt-5 font-mono text-emerald-300">{item.href}</p>
              </a>
            ))}
          </div>
        </div>

        <PhoneFrame>
          <div className="mb-5 flex items-center justify-between">
            <span className="font-black">
              קו <span className="text-emerald-400">פתוח</span>
            </span>
            <StatusPill tone="blue">Live</StatusPill>
          </div>

          <LiveMap className="h-80" />

          <div className="mt-5 grid grid-cols-[1fr_auto] gap-3">
            <GlowCard className="rounded-[1.6rem] p-4">
              <p className="text-sm font-bold text-slate-400">פעולה ראשית</p>
              <p className="mt-1 text-2xl font-black">פתח קריאה</p>
            </GlowCard>
            <TrustBadge value="98%" />
          </div>

          <a href="/experience" className="mt-5 block w-full rounded-2xl bg-emerald-400 p-4 text-center text-xl font-black text-[#03120b] shadow-[0_0_36px_rgba(16,185,129,.25)]">
            פתח חוויה
          </a>
        </PhoneFrame>
      </section>
    </ProductShell>
  );
}
