import { ProductShell } from "@/components/ProductShell";
import {
  ReferenceAdminCommandCenter,
  ReferenceCustomerCallForm,
  ReferenceDriverMapPhone,
  ReferenceDriverOfferStack,
  ReferenceHeroPoster,
  ReferenceTrustPhone,
} from "@/components/visual/ReferenceScenes";

export default function Experience() {
  return (
    <ProductShell active="experience" badge="Reference Experience · בנוי לפי תמונות הרפרנס">
      <section className="grid gap-10">
        <ReferenceHeroPoster />

        <section className="grid gap-8 lg:grid-cols-2 lg:items-start">
          <div>
            <div className="mb-5">
              <p className="text-sm font-black text-emerald-300">Customer Reference</p>
              <h2 className="text-5xl font-black">פתיחת קריאה</h2>
              <p className="mt-3 max-w-xl leading-7 text-slate-300">
                מסך לקוח שנראה כמו אפליקציה אמיתית: שאלה גדולה, שדות עמוקים, מפה חיה וכפתור פעולה זוהר.
              </p>
            </div>
            <ReferenceCustomerCallForm />
          </div>

          <div>
            <div className="mb-5">
              <p className="text-sm font-black text-amber-300">Trust Reference</p>
              <h2 className="text-5xl font-black">שכבת אמון</h2>
              <p className="mt-3 max-w-xl leading-7 text-slate-300">
                אמון כיכולת מוצרית מרכזית: מדד, אימות, מסמכים, ביקורות ותחושת ביטחון.
              </p>
            </div>
            <ReferenceTrustPhone />
          </div>
        </section>

        <section className="grid gap-8 lg:grid-cols-[460px_1fr] lg:items-start">
          <div>
            <div className="mb-5">
              <p className="text-sm font-black text-emerald-300">Driver Reference</p>
              <h2 className="text-5xl font-black">מרחב נהגים</h2>
              <p className="mt-3 max-w-xl leading-7 text-slate-300">
                נהגים על הקו, קריאות פתוחות, אזורי פעילות, זמן הגעה והצעות בחירה.
              </p>
            </div>
            <ReferenceDriverMapPhone />
          </div>

          <div>
            <div className="mb-5">
              <p className="text-sm font-black text-emerald-300">Offer Stack</p>
              <h2 className="text-5xl font-black">נהגים מגיבים</h2>
              <p className="mt-3 max-w-xl leading-7 text-slate-300">
                כרטיסי הצעה עם זמן, אמון, סוג הצעה ופעולת בחירה.
              </p>
            </div>
            <ReferenceDriverOfferStack />
          </div>
        </section>

        <ReferenceAdminCommandCenter />
      </section>
    </ProductShell>
  );
}
