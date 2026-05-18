# קו פתוח — Premium Asset Pipeline

## למה זה נדרש

אי אפשר להגיע לשפה של תמונות Image2 עם CustomPainter בלבד.
התמונות כוללות:
- עיר אמיתית / תחושת צילום
- תאורת לילה
- עומק אווירי
- טקסטורת מפה
- Glow טבעי
- קומפוזיציית פרסום

הקוד צריך להיות UI דק מעל נכסים חזותיים, לא לנסות לצייר הכול לבד.

## נכסים נדרשים

assets/brand/kav-night-city.webp
רקע לילה, מובייל 9:16, עיר/כבישים/אורות, כהה, פרימיום.

assets/brand/kav-day-city.webp
רקע יום/שקיעה, מובייל 9:16, נקי, לא ירוק מדי.

assets/brand/kav-map-dark.webp
טקסטורת מפה כהה, כבישים דקים, עומק, ללא טקסטים.

assets/brand/kav-map-light.webp
טקסטורת מפה בהירה־פרימיום, לא שטוחה.

## חוק עיצוב

התמונה נותנת עומק.
ה־UI נותן פעולה.

אין לצייר פוסטר בקוד.
אין להציף ירוק.
אין טקסט ענק.

## פלטת יעד

Night:
#020611 background
#07111D panel
#0E1A26 glass
#19D98B action
#6EF2BD signal
#E8B95E trust

Day:
#F4F7F4 background
#DDE7E3 surface
#10202A text
#0FA878 action
#D9A94D trust

## גופן יעד

Noto Sans Hebrew או Heebo.
ברירת מחדל מוצעת: Noto Sans Hebrew לממשק חד ומקצועי.
