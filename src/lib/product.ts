export const product = {
  name: "קו פתוח",
  subtitle: "רשת קריאות לנהגים ולקוחות",
  sentence: "פותחים קריאה. נהגים מגיבים. נוסעים באמון.",
  trust: "98%",
  endpoints: [
    {
      title: "דף נחיתה",
      path: "/",
      role: "חזון המוצר והצגת ארבע נקודות הקצה",
    },
    {
      title: "לקוח",
      path: "/customer",
      role: "פתיחת קריאה ובחירת נהג",
    },
    {
      title: "נהג",
      path: "/driver",
      role: "מצב אני על הקו וניהול קריאות",
    },
    {
      title: "מנהל",
      path: "/admin",
      role: "בקרה, אישור נהגים ואמון",
    },
  ],
  drivers: [
    { name: "אבי", eta: "4 דקות", trust: "96%", label: "קריאה קרובה" },
    { name: "רפי", eta: "7 דקות", trust: "98%", label: "נהג זהב" },
    { name: "משה", eta: "11 דקות", trust: "95%", label: "הצעה טובה" },
  ],
  adminStats: [
    { label: "נהגים לאישור", value: "12" },
    { label: "קריאות פעילות", value: "248" },
    { label: "דיווחים לבדיקה", value: "23" },
    { label: "אמון רשת", value: "98%" },
  ],
};
