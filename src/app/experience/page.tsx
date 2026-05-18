import { ProductShell } from "@/components/ProductShell";
import {
  DriverOfferCard,
  GlowCard,
  LiveMap,
  MetricCard,
  PhoneFrame,
  StatusPill,
  TrustBadge,
} from "@/components/visual/PremiumPrimitives";
import { product } from "@/lib/product";

const driverOffers = [
  { name: "אבי", eta: "4 דקות", trust: "96%", note: "קרוב אליך" },
  { name: "רפי", eta: "7 דקות", trust: "98%", note: "נהג זהב" },
  { name: "משה", eta: "11 דקות", trust: "95%", note: "הצעה טובה" },
];

const metrics = [
  { label: "קריאות פעילות", value: "248" },
  { label: "נהגים על הקו", value: "86" },
  { label: "אמון רשת", value: "98%" },
];

export default function Experience() {
  return (
    <ProductShell active="premium" badge="חוויה פרימיום · Visual Product Engine">
      <section className="grid gap-10 lg:grid-cols-[1fr_470px] lg:items-center">
        <div>
          <StatusPill>Reference Experience</StatusPill>

          <h1 className="mt-6 max-w-4xl text-6xl font-black leading-[.92] tracking-tight sm:text-8xl">
            עיר חיה של קריאות
          </h1>

          <p className="mt-7 max-w-2xl text-3xl font-black leading-tight text-slate-100">
            זה כבר לא דף. זו המחשה חיה של מערכת נסיעות.
          </p>

          <p className="mt-6 max-w-2xl text-lg leading-8 text-slate-300">
            לקוח פותח קריאה, נהגים מאומתים נדלקים על המפה, והמערכת עוטפת את כל הפעולה
            בשכבת אמון, בקרה, תנועה ותגובה בזמן אמת.
          </p>

          <div className="mt-10 grid gap-4 sm:grid-cols-3">
            {metrics.map((metric) => (
              <MetricCard key={metric.label} label={metric.label} value={metric.value} />
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

          <div className="mt-5 rounded-[1.8rem] border border-white/10 bg-white/[0.045] p-4">
            <h2 className="text-center text-2xl font-black">לאן נוסעים?</h2>
            <div className="mt-4 space-y-3">
              <div className="rounded-2xl border border-white/10 bg-black/30 p-4 text-slate-300">
                מאיפה אוספים אותך?
              </div>
              <div className="rounded-2xl border border-white/10 bg-black/30 p-4 text-slate-300">
                יעד הנסיעה
              </div>
            </div>
            <button className="mt-5 w-full rounded-2xl bg-emerald-400 p-4 text-xl font-black text-[#03120b]">
              פתח קריאה
            </button>
          </div>
        </PhoneFrame>
      </section>

      <section className="mt-14 grid gap-6 lg:grid-cols-[1fr_320px]">
        <div>
          <div className="mb-5 flex items-end justify-between gap-4">
            <div>
              <p className="text-sm font-bold text-emerald-300">תגובות נהגים</p>
              <h2 className="text-4xl font-black">נהגים מגיבים לקריאה</h2>
            </div>
            <StatusPill tone="amber">בחירה לפי אמון</StatusPill>
          </div>

          <div className="grid gap-4 md:grid-cols-3">
            {driverOffers.map((offer) => (
              <DriverOfferCard key={offer.name} {...offer} />
            ))}
          </div>
        </div>

        <GlowCard className="flex flex-col justify-between">
          <div>
            <p className="text-sm font-bold text-emerald-300">שכבת אמון</p>
            <h3 className="mt-3 text-3xl font-black">לא רק מחיר</h3>
            <p className="mt-4 leading-7 text-slate-300">
              הנהג נבחר לפי זמן, אמון, התאמה, היסטוריה ואימות. זה ההבדל בין “עוד אפליקציה”
              לבין רשת נסיעות אמינה.
            </p>
          </div>

          <div className="mt-8">
            <TrustBadge value={product.trust} />
          </div>
        </GlowCard>
      </section>
    </ProductShell>
  );
}
