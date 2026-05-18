export default function Driver() {
  return (
    <main dir="rtl" className="min-h-screen bg-slate-950 text-white p-8">
      <section className="mx-auto max-w-4xl py-16">
        <p className="text-emerald-300 font-bold">נהג</p>
        <h1 className="mt-4 text-5xl font-black">אני על הקו</h1>
        <div className="mt-8 grid gap-4 sm:grid-cols-3">
          {["קריאה קרובה", "קריאה משתלמת", "נהג זהב"].map((item) => (
            <div key={item} className="rounded-3xl bg-white/10 p-6">
              <p className="font-black">{item}</p>
              <p className="mt-2 text-slate-300">אמון 98% · 5 דקות</p>
            </div>
          ))}
        </div>
      </section>
    </main>
  );
}
