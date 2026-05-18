export default function Landing() {
  return (
    <main dir="rtl" className="min-h-screen bg-slate-950 text-white p-8">
      <section className="mx-auto max-w-5xl py-20">
        <p className="text-emerald-300 font-bold">רשת קריאות לנהגים ולקוחות</p>
        <h1 className="mt-4 text-6xl font-black">קו פתוח</h1>
        <p className="mt-6 text-2xl text-slate-300">פותחים קריאה. נהגים מגיבים. נוסעים באמון.</p>
        <div className="mt-10 grid gap-4 sm:grid-cols-3">
          <a className="rounded-3xl bg-emerald-400 p-6 font-black text-slate-950" href="/customer">ממשק לקוח</a>
          <a className="rounded-3xl bg-white/10 p-6 font-black" href="/driver">ממשק נהג</a>
          <a className="rounded-3xl bg-white/10 p-6 font-black" href="/admin">ממשק מנהל</a>
        </div>
      </section>
    </main>
  );
}
