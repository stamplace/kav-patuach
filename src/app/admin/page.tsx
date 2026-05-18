export default function Admin() {
  return (
    <main dir="rtl" className="min-h-screen bg-slate-950 text-white p-8">
      <section className="mx-auto max-w-5xl py-16">
        <p className="text-emerald-300 font-bold">ניהול</p>
        <h1 className="mt-4 text-5xl font-black">לוח בקרה</h1>
        <div className="mt-8 grid gap-4 sm:grid-cols-4">
          {["נהגים לאישור", "קריאות פעילות", "דיווחים לבדיקה", "פעילות היום"].map((item) => (
            <div key={item} className="rounded-3xl bg-white/10 p-6">
              <p className="font-black">{item}</p>
              <p className="mt-2 text-3xl font-black text-emerald-300">12</p>
            </div>
          ))}
        </div>
      </section>
    </main>
  );
}
