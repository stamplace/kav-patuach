import 'package:flutter/material.dart';

const kBg = Color(0xFF02070F);
const kPanel = Color(0xFF071523);
const kPhone = Color(0xFF07111F);
const kGreen = Color(0xFF12E391);
const kGreenSoft = Color(0xFF62F2B6);
const kGold = Color(0xFFF6C66D);

void main() {
  runApp(const KavPatuachApp());
}

class KavPatuachApp extends StatelessWidget {
  const KavPatuachApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'קו פתוח',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: kBg,
      ),
      home: const AppHome(),
    );
  }
}

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  int selected = 3;

  final tabs = const [
    AppTab('ניהול', Icons.dashboard_rounded),
    AppTab('נהג', Icons.local_taxi_rounded),
    AppTab('הצעות', Icons.how_to_vote_rounded),
    AppTab('לקוח', Icons.person_rounded),
    AppTab('אמון', Icons.verified_user_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: [
            const CityBackdrop(),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
                child: Column(
                  children: [
                    TopBar(onCall: () => setState(() => selected = 3)),
                    const SizedBox(height: 18),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 280),
                        child: AppStage(
                          key: ValueKey(selected),
                          selected: selected,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    BottomNav(
                      tabs: tabs,
                      selected: selected,
                      onSelect: (value) => setState(() => selected = value),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppTab {
  final String label;
  final IconData icon;
  const AppTab(this.label, this.icon);
}

class AppStage extends StatelessWidget {
  final int selected;

  const AppStage({required this.selected, super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < 760;

    if (selected == 3) {
      return const CustomerBookingScene();
    }

    if (selected == 1) {
      return const DriverLiveScene();
    }

    if (selected == 2) {
      return const DriverOffersScene();
    }

    final title = switch (selected) {
      0 => 'לוח בקרה',
      1 => 'אני על הקו',
      2 => 'קו פתוח',
      3 => 'לאן נוסעים?',
      _ => 'שכבת אמון',
    };

    final subtitle = switch (selected) {
      0 => 'קריאות. נהגים. אמון.',
      1 => 'קריאות חיות באזור.',
      2 => 'קריאה. נהג. נסיעה.',
      3 => 'פתח קריאה ובחר נהג.',
      _ => 'נוסעים בטוח.',
    };

    if (selected == 4) {
      return const TrustReferenceScene();
    }

    final phoneMode = switch (selected) {
      0 => PhoneMode.admin,
      1 => PhoneMode.driver,
      3 => PhoneMode.customer,
      4 => PhoneMode.trust,
      _ => PhoneMode.home,
    };

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: compact ? 680 : 720),
        child: compact
            ? Column(
                children: [
                  BrandBlock(title: title, subtitle: subtitle, centered: true),
                  const SizedBox(height: 24),
                  PremiumPhone(mode: phoneMode),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: BrandBlock(title: title, subtitle: subtitle)),
                  const SizedBox(width: 36),
                  SizedBox(width: 430, child: PremiumPhone(mode: phoneMode)),
                ],
              ),
      ),
    );
  }
}

enum PhoneMode { home, customer, driver, admin, trust }





class TrustReferenceScene extends StatelessWidget {
  const TrustReferenceScene({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < 620;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Padding(
            padding: EdgeInsets.only(
              top: compact ? 8 : 30,
              bottom: 12,
            ),
            child: Column(
              children: [
                const GlassLabel('בטוח ומאומת'),
                const SizedBox(height: 18),
                Text(
                  'שכבת האמון',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: compact ? 50 : 74,
                    height: .92,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -2,
                  ),
                ),
                const SizedBox(height: 20),
                GlassPanel(
                  radius: 36,
                  child: Padding(
                    padding: EdgeInsets.all(compact ? 18 : 24),
                    child: Column(
                      children: const [
                        TrustSealLarge(),
                        SizedBox(height: 18),
                        TrustScorePanel(),
                        SizedBox(height: 16),
                        TrustCapabilityGrid(),
                        SizedBox(height: 16),
                        TrustBottomPromise(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TrustSealLarge extends StatelessWidget {
  const TrustSealLarge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 142,
      height: 142,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: kGold.withOpacity(.08),
        border: Border.all(color: kGold.withOpacity(.55), width: 2),
        boxShadow: [
          BoxShadow(color: kGold.withOpacity(.22), blurRadius: 70),
          BoxShadow(color: kGreen.withOpacity(.16), blurRadius: 90),
        ],
      ),
      child: const Icon(Icons.verified_user_rounded, color: kGold, size: 72),
    );
  }
}

class TrustScorePanel extends StatelessWidget {
  const TrustScorePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 126,
      radius: 30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'מדד אמון',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 5),
          Text(
            '98%',
            style: TextStyle(
              color: kGreenSoft,
              fontSize: 58,
              height: .9,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class TrustCapabilityGrid extends StatelessWidget {
  const TrustCapabilityGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Row(
          children: [
            Expanded(
              child: TrustCapabilityCard(
                icon: Icons.person_rounded,
                title: 'נהג מאומת',
                value: 'מאושר',
                accent: kGreenSoft,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TrustCapabilityCard(
                icon: Icons.description_rounded,
                title: 'מסמכים',
                value: 'נבדקו',
                accent: kGreenSoft,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TrustCapabilityCard(
                icon: Icons.local_taxi_rounded,
                title: 'נסיעות',
                value: '+247',
                accent: kGreenSoft,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TrustCapabilityCard(
                icon: Icons.star_rounded,
                title: 'לקוחות',
                value: '4.9/5',
                accent: kGold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TrustCapabilityCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color accent;

  const TrustCapabilityCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.accent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 124,
      radius: 26,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: accent, size: 30),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              color: accent,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class TrustBottomPromise extends StatelessWidget {
  const TrustBottomPromise({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 62,
      radius: 31,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.lock_rounded, color: kGold, size: 22),
          SizedBox(width: 8),
          Text(
            'פרטיות · אימות · שירות אנושי',
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class DriverOffersScene extends StatelessWidget {
  const DriverOffersScene({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < 620;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Padding(
            padding: EdgeInsets.only(
              top: compact ? 8 : 30,
              bottom: 12,
            ),
            child: Column(
              children: [
                const GlassLabel('הקריאה שלך פתוחה'),
                const SizedBox(height: 18),
                Text(
                  '3 נהגים הגיבו',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: compact ? 48 : 72,
                    height: .92,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -2,
                  ),
                ),
                const SizedBox(height: 20),
                GlassPanel(
                  radius: 36,
                  child: Padding(
                    padding: EdgeInsets.all(compact ? 18 : 24),
                    child: Column(
                      children: const [
                        OfferStatusHeart(),
                        SizedBox(height: 18),
                        DriverOfferReferenceCard(
                          name: 'אבי',
                          eta: '4 דק׳',
                          trust: '96%',
                          badge: 'הצעה משתלמת',
                          tone: OfferTone.green,
                        ),
                        SizedBox(height: 12),
                        DriverOfferReferenceCard(
                          name: 'רפי',
                          eta: '7 דק׳',
                          trust: '98%',
                          badge: 'הצעה טובה',
                          tone: OfferTone.green,
                        ),
                        SizedBox(height: 12),
                        DriverOfferReferenceCard(
                          name: 'משה',
                          eta: '11 דק׳',
                          trust: '99%',
                          badge: 'נהג זהב',
                          tone: OfferTone.gold,
                        ),
                        SizedBox(height: 18),
                        NeonButton(label: 'בחר הצעה'),
                        SizedBox(height: 12),
                        Text(
                          'נהגים שאומתו על ידי קו פתוח',
                          style: TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OfferStatusHeart extends StatelessWidget {
  const OfferStatusHeart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 86,
          height: 86,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kGreen.withOpacity(.10),
            border: Border.all(color: kGreenSoft.withOpacity(.45)),
            boxShadow: [
              BoxShadow(color: kGreen.withOpacity(.28), blurRadius: 48),
            ],
          ),
          child: const Icon(Icons.favorite_rounded, color: kGreenSoft, size: 38),
        ),
        const SizedBox(height: 10),
        const Text(
          'בחר נהג לפי אמון, זמן והצעה',
          style: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

enum OfferTone { green, gold }

class DriverOfferReferenceCard extends StatelessWidget {
  final String name;
  final String eta;
  final String trust;
  final String badge;
  final OfferTone tone;

  const DriverOfferReferenceCard({
    required this.name,
    required this.eta,
    required this.trust,
    required this.badge,
    required this.tone,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final accent = tone == OfferTone.gold ? kGold : kGreenSoft;
    final icon = tone == OfferTone.gold ? Icons.workspace_premium_rounded : Icons.verified_rounded;

    return GlassPanel(
      height: 112,
      radius: 28,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            DriverAvatar(accent: accent),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$name · $eta · אמון $trust',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: List.generate(
                      5,
                      (index) => const Icon(Icons.star_rounded, color: kGold, size: 20),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(icon, color: accent, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        badge,
                        style: TextStyle(
                          color: accent,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              eta.replaceAll(' דק׳', ''),
              style: TextStyle(
                color: accent,
                fontSize: 42,
                fontWeight: FontWeight.w900,
                height: .9,
              ),
            ),
            const SizedBox(width: 3),
            Text(
              'דק׳',
              style: TextStyle(
                color: accent,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DriverAvatar extends StatelessWidget {
  final Color accent;

  const DriverAvatar({required this.accent, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF101B28),
            border: Border.all(color: accent, width: 2),
            boxShadow: [
              BoxShadow(color: accent.withOpacity(.25), blurRadius: 26),
            ],
          ),
          child: Icon(Icons.person_rounded, color: Colors.white.withOpacity(.86), size: 34),
        ),
        Positioned(
          right: -2,
          bottom: -2,
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accent,
              border: Border.all(color: kPhone, width: 2),
            ),
            child: const Icon(Icons.check_rounded, color: Color(0xFF03120B), size: 15),
          ),
        ),
      ],
    );
  }
}

class DriverLiveScene extends StatelessWidget {
  const DriverLiveScene({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < 620;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 920),
          child: Padding(
            padding: EdgeInsets.only(
              top: compact ? 8 : 30,
              bottom: 12,
            ),
            child: Column(
              children: [
                const GlassLabel('נהג'),
                const SizedBox(height: 18),
                Text(
                  'אני על הקו',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: compact ? 54 : 78,
                    height: .9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -2,
                  ),
                ),
                const SizedBox(height: 22),
                GlassPanel(
                  radius: 36,
                  child: Padding(
                    padding: EdgeInsets.all(compact ? 18 : 24),
                    child: Column(
                      children: [
                        const NeonSwitch(),
                        const SizedBox(height: 18),
                        SizedBox(
                          height: compact ? 280 : 390,
                          child: const LiveMapCanvas(),
                        ),
                        const SizedBox(height: 18),
                        const DriverLiveStatsStrip(),
                        const SizedBox(height: 16),
                        const DriverLiveCallCard(
                          title: 'קריאה קרובה',
                          route: 'בני ברק → פתח תקווה',
                          eta: '4 דק׳ ממך',
                          price: '₪68',
                        ),
                        const SizedBox(height: 10),
                        const DriverLiveCallCard(
                          title: 'קריאה משתלמת',
                          route: 'רמת גן → ירושלים',
                          eta: '9 דק׳ ממך',
                          price: '₪240',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DriverLiveStatsStrip extends StatelessWidget {
  const DriverLiveStatsStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: DriverStatBox(label: 'הכנסה היום', value: '₪740', icon: Icons.payments_rounded)),
        SizedBox(width: 10),
        Expanded(child: DriverStatBox(label: 'אמון הנהג', value: '98%', icon: Icons.verified_user_rounded)),
        SizedBox(width: 10),
        Expanded(child: DriverStatBox(label: 'קריאות', value: '12', icon: Icons.local_taxi_rounded)),
      ],
    );
  }
}

class DriverStatBox extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const DriverStatBox({
    required this.label,
    required this.value,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 92,
      radius: 24,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: kGreenSoft, size: 22),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: kGreenSoft,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white60,
              fontSize: 11,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class DriverLiveCallCard extends StatelessWidget {
  final String title;
  final String route;
  final String eta;
  final String price;

  const DriverLiveCallCard({
    required this.title,
    required this.route,
    required this.eta,
    required this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 86,
      radius: 24,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kGreen.withOpacity(.14),
                border: Border.all(color: kGreenSoft.withOpacity(.55)),
                boxShadow: [
                  BoxShadow(color: kGreen.withOpacity(.18), blurRadius: 24),
                ],
              ),
              child: const Icon(Icons.local_taxi_rounded, color: kGreen),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '$route · $eta',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              price,
              style: const TextStyle(
                color: kGold,
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: kGreen,
                boxShadow: [
                  BoxShadow(color: kGreen.withOpacity(.25), blurRadius: 24),
                ],
              ),
              alignment: Alignment.center,
              child: const Text(
                'קבל',
                style: TextStyle(
                  color: Color(0xFF03120B),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomerBookingScene extends StatelessWidget {
  const CustomerBookingScene({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < 620;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Padding(
            padding: EdgeInsets.only(
              top: compact ? 8 : 34,
              bottom: 12,
            ),
            child: Column(
              children: [
                const GlassLabel('לקוח'),
                const SizedBox(height: 18),
                Text(
                  'לאן נוסעים?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: compact ? 54 : 76,
                    height: .9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -2,
                  ),
                ),
                const SizedBox(height: 22),
                GlassPanel(
                  radius: 34,
                  child: Padding(
                    padding: EdgeInsets.all(compact ? 18 : 24),
                    child: Column(
                      children: [
                        const AppInput(label: 'מאיפה אוספים אותך?'),
                        const SizedBox(height: 12),
                        const AppInput(label: 'יעד הנסיעה'),
                        const SizedBox(height: 12),
                        const SegmentRow(),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: compact ? 230 : 330,
                          child: const LiveMapCanvas(),
                        ),
                        const SizedBox(height: 18),
                        const NeonButton(label: 'פתח קריאה'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const TrustStrip(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TrustStrip extends StatelessWidget {
  const TrustStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 58,
      radius: 29,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.verified_user_rounded, color: kGold, size: 24),
          SizedBox(width: 10),
          Text(
            'נהגים נבחרים',
            style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white70),
          ),
          SizedBox(width: 12),
          Text('·', style: TextStyle(color: kGold, fontWeight: FontWeight.w900)),
          SizedBox(width: 12),
          Text(
            'ביטוח מלא',
            style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white70),
          ),
          SizedBox(width: 12),
          Text('·', style: TextStyle(color: kGold, fontWeight: FontWeight.w900)),
          SizedBox(width: 12),
          Text(
            'דירוגים אמיתיים',
            style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

class CityBackdrop extends StatelessWidget {
  const CityBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CityBackdropPainter(),
      child: const SizedBox.expand(),
    );
  }
}

class CityBackdropPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF063D32),
          Color(0xFF061522),
          Color(0xFF02070F),
          Color(0xFF000000),
        ],
      ).createShader(Offset.zero & size);

    canvas.drawRect(Offset.zero & size, bg);

    final topGlow = Paint()
      ..shader = RadialGradient(
        colors: [
          kGreen.withOpacity(.42),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(size.width * .5, size.height * .04),
          radius: size.width * .72,
        ),
      );

    canvas.drawCircle(Offset(size.width * .5, size.height * .04), size.width * .72, topGlow);

    final grid = Paint()
      ..color = Colors.white.withOpacity(.055)
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += 54) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }

    for (double y = 0; y < size.height; y += 54) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final skylinePaint = Paint()..color = const Color(0xFF05101B).withOpacity(.78);
    final lightPaint = Paint()..color = kGreen.withOpacity(.38);
    final heights = [42, 86, 58, 136, 72, 168, 94, 46, 122, 88, 54, 148, 76, 112];

    final w = size.width / heights.length;

    for (var i = 0; i < heights.length; i++) {
      final h = heights[i].toDouble();
      final rect = Rect.fromLTWH(i * w + 3, size.height - h, w - 6, h);
      canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(4)), skylinePaint);
      if (i.isEven) {
        canvas.drawCircle(Offset(rect.center.dx, rect.top + 18), 2.2, lightPaint);
      }
    }

    final fade = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.transparent, Colors.black.withOpacity(.82)],
      ).createShader(Rect.fromLTWH(0, size.height * .64, size.width, size.height * .36));

    canvas.drawRect(Rect.fromLTWH(0, size.height * .64, size.width, size.height * .36), fade);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TopBar extends StatelessWidget {
  final VoidCallback onCall;

  const TopBar({required this.onCall, super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 72,
      radius: 38,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            const BrandSmall(),
            const Spacer(),
            GestureDetector(
              onTap: onCall,
              child: const NeonButton(label: 'פתח קריאה', compact: true),
            ),
          ],
        ),
      ),
    );
  }
}

class BrandSmall extends StatelessWidget {
  const BrandSmall({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text.rich(
      TextSpan(
        children: [
          TextSpan(text: 'קו ', style: TextStyle(color: Colors.white)),
          TextSpan(text: 'פתוח', style: TextStyle(color: kGreen)),
        ],
      ),
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
    );
  }
}

class BrandBlock extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool centered;

  const BrandBlock({
    required this.title,
    required this.subtitle,
    this.centered = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        const GlassLabel('Live Network'),
        const SizedBox(height: 18),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: title.contains('קו פתוח') ? 'קו ' : title,
                style: const TextStyle(color: Colors.white),
              ),
              if (title.contains('קו פתוח'))
                const TextSpan(
                  text: 'פתוח',
                  style: TextStyle(color: kGreen),
                ),
            ],
          ),
          textAlign: centered ? TextAlign.center : TextAlign.right,
          style: const TextStyle(
            fontSize: 72,
            height: .9,
            fontWeight: FontWeight.w900,
            letterSpacing: -3,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          subtitle,
          textAlign: centered ? TextAlign.center : TextAlign.right,
          style: const TextStyle(
            fontSize: 28,
            height: 1.1,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: centered ? WrapAlignment.center : WrapAlignment.start,
          children: const [
            MiniPromise('נוסעים באמון'),
            MiniPromise('נהגים עצמאיים'),
            MiniPromise('לקוחות מחוברים'),
          ],
        ),
      ],
    );
  }
}

class PremiumPhone extends StatelessWidget {
  final PhoneMode mode;

  const PremiumPhone({required this.mode, super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: .52,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.white.withOpacity(.2), width: 2),
          boxShadow: [
            BoxShadow(color: kGreen.withOpacity(.30), blurRadius: 90, spreadRadius: 4),
            const BoxShadow(color: Colors.black, blurRadius: 34, offset: Offset(0, 26)),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(41),
          child: Stack(
            children: [
              Container(color: kPhone),
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 112,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 48, 20, 20),
                child: Column(
                  children: [
                    const PhoneHeader(),
                    const SizedBox(height: 18),
                    Expanded(child: PhoneContent(mode: mode)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PhoneHeader extends StatelessWidget {
  const PhoneHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.notifications_none_rounded, color: Colors.white70),
        Spacer(),
        BrandSmall(),
        Spacer(),
        Icon(Icons.menu_rounded, color: Colors.white70),
      ],
    );
  }
}

class PhoneContent extends StatelessWidget {
  final PhoneMode mode;

  const PhoneContent({required this.mode, super.key});

  @override
  Widget build(BuildContext context) {
    return switch (mode) {
      PhoneMode.customer => const CustomerPhone(),
      PhoneMode.driver => const DriverPhone(),
      PhoneMode.admin => const AdminPhone(),
      PhoneMode.trust => const TrustPhone(),
      PhoneMode.home => const DriverPhone(),
    };
  }
}

class DriverPhone extends StatelessWidget {
  const DriverPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        NeonSwitch(),
        SizedBox(height: 16),
        Expanded(flex: 6, child: LiveMapCanvas()),
        SizedBox(height: 14),
        CallList(),
        SizedBox(height: 14),
        Row(
          children: [
            Expanded(child: TrustMiniCard()),
            SizedBox(width: 12),
            Expanded(child: IncomeMiniCard()),
          ],
        ),
      ],
    );
  }
}

class CustomerPhone extends StatelessWidget {
  const CustomerPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'לאן נוסעים?',
          style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900),
        ),
        SizedBox(height: 18),
        AppInput(label: 'מאיפה אוספים אותך?'),
        SizedBox(height: 12),
        AppInput(label: 'יעד הנסיעה'),
        SizedBox(height: 12),
        SegmentRow(),
        SizedBox(height: 16),
        Expanded(child: LiveMapCanvas()),
        SizedBox(height: 16),
        NeonButton(label: 'פתח קריאה'),
      ],
    );
  }
}

class AdminPhone extends StatelessWidget {
  const AdminPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'לוח בקרה',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
        ),
        SizedBox(height: 16),
        MetricGrid(),
        SizedBox(height: 16),
        Expanded(child: LiveMapCanvas()),
        SizedBox(height: 16),
        ControlRows(),
      ],
    );
  }
}

class TrustPhone extends StatelessWidget {
  const TrustPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'שכבת האמון שלנו',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
        ),
        SizedBox(height: 18),
        TrustSeal(),
        SizedBox(height: 16),
        TrustScore(),
        SizedBox(height: 16),
        MetricGrid(),
      ],
    );
  }
}

class NeonSwitch extends StatelessWidget {
  const NeonSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        gradient: const LinearGradient(colors: [Color(0xFF0CCF89), Color(0xFF23F084)]),
        boxShadow: [BoxShadow(color: kGreen.withOpacity(.35), blurRadius: 38)],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 10,
            top: 9,
            child: Container(
              width: 52,
              height: 52,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: kPhone),
              child: const Icon(Icons.sensors_rounded, color: Colors.white, size: 28),
            ),
          ),
          const Center(
            child: Text(
              'אני על הקו',
              style: TextStyle(color: Color(0xFF03120B), fontSize: 24, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}

class LiveMapCanvas extends StatelessWidget {
  const LiveMapCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: CustomPaint(
        painter: LiveMapPainter(),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class LiveMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF04101B), Color(0xFF081B22), Color(0xFF020711)],
      ).createShader(Offset.zero & size);

    canvas.drawRect(Offset.zero & size, bg);

    final grid = Paint()
      ..color = Colors.white.withOpacity(.07)
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += 34) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }

    for (double y = 0; y < size.height; y += 34) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final route = Paint()
      ..color = kGreen.withOpacity(.58)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(size.width * .16, size.height * .72)
      ..quadraticBezierTo(size.width * .43, size.height * .58, size.width * .52, size.height * .42)
      ..quadraticBezierTo(size.width * .68, size.height * .14, size.width * .86, size.height * .24);

    canvas.drawPath(path, route);

    final center = Offset(size.width * .5, size.height * .5);
    final halo = Paint()
      ..shader = RadialGradient(
        colors: [kGreen.withOpacity(.36), Colors.transparent],
      ).createShader(Rect.fromCircle(center: center, radius: size.width * .38));

    canvas.drawCircle(center, size.width * .38, halo);

    _pin(canvas, Offset(size.width * .5, size.height * .5), 18);
    _pin(canvas, Offset(size.width * .22, size.height * .36), 11);
    _pin(canvas, Offset(size.width * .74, size.height * .36), 11);
    _pin(canvas, Offset(size.width * .31, size.height * .76), 11);

    _label(canvas, 'קריאה פתוחה', Offset(size.width * .56, size.height * .20));
    _label(canvas, 'אבי · 4 דק׳', Offset(size.width * .65, size.height * .48));
    _label(canvas, 'רפי · 7 דק׳', Offset(size.width * .18, size.height * .52));
  }

  void _pin(Canvas canvas, Offset offset, double r) {
    final glow = Paint()
      ..color = kGreen.withOpacity(.22)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);

    canvas.drawCircle(offset, r * 3, glow);

    final dot = Paint()..color = kGreenSoft;
    canvas.drawCircle(offset, r, dot);
  }

  void _label(Canvas canvas, String text, Offset offset) {
    final textPainter = TextPainter(
      textDirection: TextDirection.rtl,
      text: TextSpan(
        text: text,
        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w900),
      ),
    )..layout();

    final rect = Rect.fromLTWH(offset.dx - textPainter.width - 16, offset.dy - 15, textPainter.width + 32, 34);

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(18)),
      Paint()..color = Colors.black.withOpacity(.68),
    );

    textPainter.paint(canvas, Offset(rect.left + 16, rect.top + 8));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CallList extends StatelessWidget {
  const CallList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CallRow('קריאה קרובה', '2.1 ק״מ'),
        SizedBox(height: 9),
        CallRow('קריאה משתלמת', '5.8 ק״מ'),
        SizedBox(height: 9),
        CallRow('קריאה קרובה', '3.4 ק״מ'),
      ],
    );
  }
}

class CallRow extends StatelessWidget {
  final String title;
  final String meta;

  const CallRow(this.title, this.meta, {super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 54,
      radius: 20,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
            const Icon(Icons.local_taxi_rounded, color: kGreen, size: 22),
            const SizedBox(width: 9),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
            const Spacer(),
            Text(meta, style: const TextStyle(color: kGreenSoft, fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }
}

class AppInput extends StatelessWidget {
  final String label;

  const AppInput({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 76,
      radius: 22,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          children: [
            const Icon(Icons.location_on_rounded, color: kGreen),
            const SizedBox(width: 10),
            Text(label, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }
}

class SegmentRow extends StatelessWidget {
  const SegmentRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: SegmentButton('מאוחר יותר', active: false)),
        SizedBox(width: 10),
        Expanded(child: SegmentButton('עכשיו', active: true)),
      ],
    );
  }
}

class SegmentButton extends StatelessWidget {
  final String label;
  final bool active;

  const SegmentButton(this.label, {required this.active, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? kGreen.withOpacity(.18) : Colors.black.withOpacity(.28),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: active ? kGreenSoft : Colors.white.withOpacity(.1)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: active ? Colors.white : Colors.white60,
          fontSize: 18,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class MetricGrid extends StatelessWidget {
  const MetricGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: MiniMetric('קריאות', '248')),
        SizedBox(width: 10),
        Expanded(child: MiniMetric('נהגים', '1,458')),
      ],
    );
  }
}

class MiniMetric extends StatelessWidget {
  final String label;
  final String value;

  const MiniMetric(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 96,
      radius: 24,
      child: Center(
        child: Text(
          '$label\n$value',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: kGreenSoft),
        ),
      ),
    );
  }
}

class ControlRows extends StatelessWidget {
  const ControlRows({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CallRow('נהגים לאישור', '23'),
        SizedBox(height: 9),
        CallRow('דיווחים', '8'),
      ],
    );
  }
}

class TrustSeal extends StatelessWidget {
  const TrustSeal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 134,
      height: 134,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: kGold.withOpacity(.08),
        border: Border.all(color: kGold.withOpacity(.45)),
        boxShadow: [BoxShadow(color: kGold.withOpacity(.18), blurRadius: 60)],
      ),
      child: const Icon(Icons.verified_user_rounded, color: kGold, size: 64),
    );
  }
}

class TrustScore extends StatelessWidget {
  const TrustScore({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 110,
      radius: 28,
      child: const Center(
        child: Text(
          '98% אמון',
          style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: kGreenSoft),
        ),
      ),
    );
  }
}

class TrustMiniCard extends StatelessWidget {
  const TrustMiniCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const GlassPanel(
      height: 88,
      radius: 24,
      child: Center(
        child: Text(
          'אמון\n97%',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: kGold),
        ),
      ),
    );
  }
}

class IncomeMiniCard extends StatelessWidget {
  const IncomeMiniCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const GlassPanel(
      height: 88,
      radius: 24,
      child: Center(
        child: Text(
          'הכנסה\n₪1,280',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: kGreenSoft),
        ),
      ),
    );
  }
}

class GlassPanel extends StatelessWidget {
  final Widget child;
  final double? height;
  final double radius;

  const GlassPanel({
    required this.child,
    this.height,
    this.radius = 28,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: kPanel.withOpacity(.76),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.white.withOpacity(.11)),
        boxShadow: const [
          BoxShadow(color: Colors.black54, blurRadius: 30, offset: Offset(0, 16)),
        ],
      ),
      child: child,
    );
  }
}

class NeonButton extends StatelessWidget {
  final String label;
  final bool compact;

  const NeonButton({
    required this.label,
    this.compact = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: compact ? 48 : 64,
      padding: EdgeInsets.symmetric(horizontal: compact ? 22 : 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(colors: [Color(0xFF08C985), Color(0xFF22F08E)]),
        boxShadow: [BoxShadow(color: kGreen.withOpacity(.35), blurRadius: 34)],
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: const Color(0xFF03120B),
          fontSize: compact ? 18 : 24,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class GlassLabel extends StatelessWidget {
  final String label;

  const GlassLabel(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 42,
      radius: 22,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(color: kGreenSoft, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}

class MiniPromise extends StatelessWidget {
  final String label;

  const MiniPromise(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 48,
      radius: 24,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}

class BottomNav extends StatelessWidget {
  final List<AppTab> tabs;
  final int selected;
  final ValueChanged<int> onSelect;

  const BottomNav({
    required this.tabs,
    required this.selected,
    required this.onSelect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 72,
      radius: 32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(tabs.length, (index) {
          final active = index == selected;
          return Expanded(
            child: GestureDetector(
              onTap: () => onSelect(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                decoration: BoxDecoration(
                  color: active ? kGreen : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      tabs[index].icon,
                      color: active ? const Color(0xFF03120B) : Colors.white70,
                      size: 20,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      tabs[index].label,
                      style: TextStyle(
                        color: active ? const Color(0xFF03120B) : Colors.white70,
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
