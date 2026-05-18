export default function Customer() {
  return (
    <main dir="rtl" className="min-h-screen bg-slate-950 text-white p-8">
      <section className="mx-auto max-w-3xl py-16">
        <p className="text-emerald-300 font-bold">לקוח</p>
        <h1 className="mt-4 text-5xl font-black">פתח קריאה</h1>
        <div className="mt-8 rounded-3xl bg-white/10 p-6">
          <p className="text-2xl font-bold">לאן נוסעים?</p>
          <div className="mt-5 space-y-3">
            <div className="rounded-2xl bg-black/30 p-4 text-slate-300">מאיפה אוספים אותך?</div>
            <div className="rounded-2xl bg-black/30 p-4 text-slate-300">יעד הנסיעה</div>
            <button className="w-full rounded-2xl bg-emerald-400 p-4 font-black text-slate-950">פתח קריאה</button>
          </div>
        </div>
      </section>
    </main>
  );
}
