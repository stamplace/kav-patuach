"use client";

import { useMemo, useState } from "react";

type Mode = "day" | "night";
type TabKey = "trust" | "customer" | "zone" | "driver" | "admin";
type RideStep = 0 | 1 | 2 | 3 | 4;

const tabs: Array<{ key: TabKey; label: string; icon: string }> = [
  { key: "trust", label: "אמון", icon: "✓" },
  { key: "customer", label: "לקוח", icon: "●" },
  { key: "zone", label: "מרחב", icon: "✣" },
  { key: "driver", label: "נהג", icon: "▣" },
  { key: "admin", label: "ניהול", icon: "▦" },
];

const rideTitles = [
  "מוכן לפתיחה",
  "מחפש נהגים",
  "נמצאו 3 הצעות",
  "נהג נבחר",
  "הנהג בדרך",
];

const rideCtas = [
  "פתח קריאה",
  "הצג הצעות",
  "בחר נהג",
  "התחל נסיעה",
  "איפוס דמו",
];

const rideMessages: Record<TabKey, string[]> = {
  customer: [
    "פתח קריאה כדי להפעיל את המערכת.",
    "המערכת מחפשת נהגים זמינים באזור.",
    "נמצאו נהגים מתאימים לבחירה.",
    "נהג מתאים נבחר לפי זמן ואמון.",
    "הנהג בדרך לאיסוף.",
  ],
  driver: [
    "מחכה לקריאה חדשה.",
    "קריאה חדשה מחפשת נהג מתאים.",
    "הקריאה זמינה לנהגים באזור.",
    "הנהג נבחר לקריאה.",
    "הנהג מתקדם לאיסוף.",
  ],
  zone: [
    "האזור מוכן לקריאות.",
    "קריאה חדשה נכנסה לאזור.",
    "המערכת מאתרת הצעות באזור חי.",
    "שיבוץ הנהג מעדכן את המרחב.",
    "הקריאה פעילה במרחב.",
  ],
  admin: [
    "אין קריאה פעילה בדמו.",
    "קריאה חדשה נפתחה במערכת.",
    "נמצאו הצעות לשיבוץ.",
    "נהג נבחר ונרשם בלוח הבקרה.",
    "קריאה פעילה במעקב.",
  ],
  trust: [
    "שכבת האמון מוכנה לבדיקה.",
    "המערכת בודקת נהגים זמינים.",
    "הצעות מסוננות לפי אמון.",
    "הנהג עבר אימות והתאמה.",
    "הקריאה מתנהלת עם שכבת אמון פעילה.",
  ],
};

export default function Home() {
  const [mode, setMode] = useState<Mode>("day");
  const [tab, setTab] = useState<TabKey>("customer");
  const [step, setStep] = useState<RideStep>(0);
  const [toast, setToast] = useState<string | null>(null);

  const background = mode === "day"
    ? "/brand/kav-day-city.webp"
    : "/brand/kav-night-city.webp";

  const advance = () => {
    const next = ((step + 1) % 5) as RideStep;
    setStep(next);
    setToast(`${rideTitles[next]} · ${rideMessages.customer[next]}`);
    window.setTimeout(() => setToast(null), 2200);
  };

  return (
    <main className={`app ${mode}`}>
      <div className="bg" style={{ backgroundImage: `url(${background})` }} />
      <div className="veil" />

      <section className="shell">
        <TopBar mode={mode} onMode={() => setMode(mode === "day" ? "night" : "day")} />

        <div className="stage">
          <Header tab={tab} />

          <ActiveCall tab={tab} step={step} />

          {tab === "customer" && <Customer step={step} onAdvance={advance} />}
          {tab === "driver" && <Driver step={step} onAction={advance} />}
          {tab === "zone" && <Zone step={step} />}
          {tab === "admin" && <Admin step={step} />}
          {tab === "trust" && <Trust step={step} />}

          <BottomNav tab={tab} onTab={setTab} />
        </div>
      </section>

      {toast && <div className="toast">{toast}</div>}
    </main>
  );
}

function TopBar({ mode, onMode }: { mode: Mode; onMode: () => void }) {
  return (
    <div className="topbar">
      <button className="primary">פתח קריאה</button>
      <button className="mode" onClick={onMode} aria-label="יום לילה">
        {mode === "day" ? "☀" : "☾"}
      </button>
      <div className="brand"><b>קו</b> פתוח</div>
    </div>
  );
}

function Header({ tab }: { tab: TabKey }) {
  const title: Record<TabKey, string> = {
    customer: "הקריאה שלי",
    driver: "קריאות לעבודה",
    zone: "אזור חי",
    admin: "שליטה",
    trust: "ביטחון ואימות",
  };

  const subtitle: Record<TabKey, string> = {
    customer: "פתח קריאה. קבל נהג מתאים. סע בביטחון.",
    driver: "עלה על הקו. קבל קריאות. עבוד ברור.",
    zone: "רואים את האזור חי.",
    admin: "כל הקריאות, הנהגים והחריגות במקום אחד.",
    trust: "כל נסיעה עוברת דרך שכבת אמון.",
  };

  return (
    <header className="screen-head">
      <div>
        <p className="eyebrow">קו פתוח</p>
        <h1>{title[tab]}</h1>
        <p>{subtitle[tab]}</p>
      </div>
      <div className="seal">{tab === "trust" ? "✓" : "●"}</div>
    </header>
  );
}

function ActiveCall({ tab, step }: { tab: TabKey; step: RideStep }) {
  return (
    <div className="active-call">
      <div className="pulse-dot" />
      <div>
        <b>{rideTitles[step]}</b>
        <span>{rideMessages[tab][step]}</span>
      </div>
    </div>
  );
}

function Customer({ step, onAdvance }: { step: RideStep; onAdvance: () => void }) {
  return (
    <div className="panel">
      <div className="inputs">
        <button>מאיפה אוספים אותך? <span>⌖</span></button>
        <button>יעד הנסיעה <span>⌖</span></button>
      </div>

      <div className="segments">
        <button className="active">עכשיו</button>
        <button>מאוחר יותר</button>
      </div>

      <Progress step={step} />

      <MapSurface mode="customer" />

      <button className="cta" onClick={onAdvance}>{rideCtas[step]}</button>
    </div>
  );
}

function Driver({ step, onAction }: { step: RideStep; onAction: () => void }) {
  return (
    <div className="panel">
      <button className="live" onClick={onAction}>אני על הקו</button>
      <MapSurface mode="driver" />
      <div className="metrics three">
        <Metric label="היום" value="₪740" />
        <Metric label="אמון" value="98%" gold />
        <Metric label="קריאות" value={step > 0 ? "12" : "0"} />
      </div>
      <CallRow title="קריאה מומלצת" meta="רמת גן → ירושלים · 9 דק׳" value="₪240" />
      <CallRow title="קריאה קרובה" meta="בני ברק → פתח תקווה · 4 דק׳" value="₪68" />
    </div>
  );
}

function Zone({ step }: { step: RideStep }) {
  return (
    <div className="panel">
      <MapSurface mode="zone" />
      <div className="metrics three">
        <Metric label="נהגים" value="86" />
        <Metric label="קריאות" value={step > 0 ? "24" : "18"} />
        <Metric label="עומס" value={step > 1 ? "גבוה" : "רגיל"} gold />
      </div>
      <CallRow title="איזון אזור" meta="חסרים 6 נהגים סביב בני ברק" value="נתב" />
      <CallRow title="קריאה חדשה" meta="בני ברק · 4 דק׳" value="פעילה" />
    </div>
  );
}

function Admin({ step }: { step: RideStep }) {
  return (
    <div className="panel">
      <div className="metrics grid">
        <Metric label="קריאות" value="248" />
        <Metric label="נהגים" value="1,458" />
        <Metric label="אמון" value="98%" gold />
        <Metric label="דיווחים" value="23" gold />
      </div>
      <div className="bars">
        {[35, 58, 45, 76, 62, 88, 52, 94].map((h, i) => <span key={i} style={{ height: `${h}%` }} />)}
      </div>
      <CallRow title="קריאה פעילה" meta={rideTitles[step]} value="פתח" />
      <CallRow title="נהג לאישור" meta="רפי כהן · מסמכים ממתינים" value="אשר" />
    </div>
  );
}

function Trust({ step }: { step: RideStep }) {
  return (
    <div className="panel trust">
      <div className="trust-hero">
        <div className="big-seal">✓</div>
        <strong>98%</strong>
        <span>מדד אמון מערכת</span>
      </div>
      <div className="metrics three">
        <Metric label="מסמכים" value="נבדקו" />
        <Metric label="דירוג" value="4.9" gold />
        <Metric label="נסיעות" value="+247" />
      </div>
      <CallRow title="נהג מאומת" meta="זהות, רישיון, ביטוח ותוקף" value={step > 2 ? "מאושר" : "מוכן"} />
      <CallRow title="שירות אנושי" meta="טיפול בקריאות חריגות ודיווחים" value="פעיל" />
      <CallRow title="פרטיות" meta="מידע רגיש נשמר רק לצורך השירות" value="מוגן" />
    </div>
  );
}

function Progress({ step }: { step: RideStep }) {
  const labels = ["פתיחה", "חיפוש", "הצעות", "נהג", "בדרך"];
  return (
    <div className="progress">
      {labels.map((label, i) => (
        <div key={label} className={i <= step ? "on" : ""}>
          <span>{i + 1}</span>
          <small>{label}</small>
        </div>
      ))}
    </div>
  );
}

function MapSurface({ mode }: { mode: "customer" | "driver" | "zone" }) {
  const labels = mode === "zone"
    ? ["אבי", "רפי", "משה", "יוסי", "קריאה חדשה"]
    : ["קריאה פתוחה", "אבי · 4 דק׳", "רפי · 7 דק׳"];

  return (
    <div className={`map ${mode}`}>
      <div className="route" />
      {labels.map((label, i) => <span key={label} className={`pin p${i}`}>{label}</span>)}
    </div>
  );
}

function Metric({ label, value, gold = false }: { label: string; value: string; gold?: boolean }) {
  return (
    <div className={`metric ${gold ? "gold" : ""}`}>
      <strong>{value}</strong>
      <span>{label}</span>
    </div>
  );
}

function CallRow({ title, meta, value }: { title: string; meta: string; value: string }) {
  return (
    <div className="row">
      <div>
        <b>{title}</b>
        <span>{meta}</span>
      </div>
      <em>{value}</em>
    </div>
  );
}

function BottomNav({ tab, onTab }: { tab: TabKey; onTab: (tab: TabKey) => void }) {
  return (
    <nav className="bottom">
      {tabs.map((item) => (
        <button key={item.key} onClick={() => onTab(item.key)} className={tab === item.key ? "active" : ""}>
          <span>{item.icon}</span>
          {item.label}
        </button>
      ))}
    </nav>
  );
}
