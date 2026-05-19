import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kBg = Color(0xFF02070F);
const kPanel = Color(0xFF071523);
const kPhone = Color(0xFF07111F);
const kGreen = Color(0xFF23C984);
const kGreenSoft = Color(0xFF73E6B4);
const kGold = Color(0xFFE7B85B);

enum VisualMode { night, day }


const kavNightCityAsset = 'assets/brand/kav-night-city.webp';
const kavDayCityAsset = 'assets/brand/kav-day-city.webp';
const kavMapDarkAsset = 'assets/brand/kav-map-dark.webp';
const kavMapLightAsset = 'assets/brand/kav-map-light.webp';
const kavGlowAsset = 'assets/brand/kav-premium-glow.webp';
const kavHeroNightAsset = 'assets/brand/kav-hero-poster-night.webp';

const kavAllPremiumAssets = [
  kavNightCityAsset,
  kavDayCityAsset,
  kavMapDarkAsset,
  kavMapLightAsset,
  kavGlowAsset,
  kavHeroNightAsset,
];

Image premiumAssetImage(
  String asset, {
  BoxFit fit = BoxFit.cover,
  Alignment alignment = Alignment.center,
  double? opacity,
  int? cacheWidth,
  int? cacheHeight,
}) {
  return Image.asset(
    asset,
    fit: fit,
    alignment: alignment,
    filterQuality: FilterQuality.medium,
    gaplessPlayback: true,
    cacheWidth: cacheWidth,
    cacheHeight: cacheHeight,
    opacity: opacity == null ? null : AlwaysStoppedAnimation(opacity),
    errorBuilder: (_, __, ___) => const SizedBox.shrink(),
  );
}


// OVERLAY_TUNING_PASS_01: premium image assets are the visual base; UI must stay thin and readable.
// VISUAL_COMPOSITION_PASS_02: assets lead, old painters are reduced, trust poster has priority.
// TRUST_DAY_NIGHT_FIX_01: trust uses poster at night and day-city in day mode until a dedicated day poster exists.
// ASSET_PERFORMANCE_PASS_01: preload image assets and use gapless playback to prevent tearing on fast taps.
// USE_CASE_PASS_01_CUSTOMER: customer tab is a clear ride request workflow.
// USE_CASE_PASS_02_DRIVER: driver tab is a clear live work console.
// USE_CASE_PASS_03_ZONE: zone tab is a clear live operations surface.
// USE_CASE_PASS_04_ADMIN: admin tab is a clear operations control surface.
// USE_CASE_PASS_05_TRUST: trust tab is a clear assurance and verification surface.
// TRUST_HEADER_CLEANUP_01: trust header does not repeat day/night state.
// DEMO_ACTIVATION_PASS_01: default day mode and premium feedback for demo actions.
// DEMO_ACTIVATION_PASS_02: customer demo has a live ride-request story state.



class VisualModeScope extends InheritedWidget {
  final VisualMode mode;

  const VisualModeScope({
    required this.mode,
    required super.child,
    super.key,
  });

  static VisualMode maybeOf(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<VisualModeScope>();
    return scope?.mode ?? VisualMode.night;
  }

  @override
  bool updateShouldNotify(VisualModeScope oldWidget) => oldWidget.mode != mode;
}

class PremiumAssetBackground extends StatelessWidget {
  final VisualMode mode;
  final int scene;
  final Widget fallback;

  const PremiumAssetBackground({
    required this.mode,
    required this.fallback,
    this.scene = 3,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDay = mode == VisualMode.day;

    final asset = scene == 4 && !isDay
        ? kavHeroNightAsset
        : isDay
            ? kavDayCityAsset
            : kavNightCityAsset;

    return Stack(
      children: [
        Positioned.fill(child: fallback),

        // Real premium image asset.
        Positioned.fill(
          child: Transform.scale(
            scale: isDay ? 1.04 : 1.07,
            child: premiumAssetImage(
              asset,
              fit: BoxFit.cover,
              alignment: isDay ? Alignment.center : const Alignment(0, -0.07),
              cacheWidth: 1440,
            ),
          ),
        ),

        // Premium glow: now controlled, not flooding the whole UI.
        Positioned.fill(
          child: premiumAssetImage(
            kavGlowAsset,
            fit: BoxFit.cover,
            alignment: Alignment.center,
            opacity: isDay ? .055 : .16,
            cacheWidth: 1440,
          ),
        ),

        // Readability veil, intentionally light.
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDay
                    ? [
                        Colors.white.withOpacity(.045),
                        Colors.transparent,
                        const Color(0xFF020711).withOpacity(.30),
                      ]
                    : [
                        const Color(0xFF020611).withOpacity(.10),
                        Colors.transparent,
                        Colors.black.withOpacity(.38),
                      ],
              ),
            ),
          ),
        ),

        // Bottom vignette for nav readability.
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0, .85),
                radius: .95,
                colors: [
                  Colors.black.withOpacity(isDay ? .16 : .34),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}



class PremiumMapSurface extends StatelessWidget {
  final Widget child;

  const PremiumMapSurface({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mode = VisualModeScope.maybeOf(context);
    final isDay = mode == VisualMode.day;
    final asset = isDay
        ? kavMapLightAsset
        : kavMapDarkAsset;

    return Stack(
      children: [
        Positioned.fill(
          child: premiumAssetImage(
            asset,
            fit: BoxFit.cover,
            alignment: Alignment.center,
            cacheWidth: 1200,
          ),
        ),

        // Very light contrast layer only. The image is the map now.
        Positioned.fill(
          child: Container(
            color: isDay
                ? Colors.white.withOpacity(.018)
                : const Color(0xFF020711).withOpacity(.10),
          ),
        ),

        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(.26, -.20),
                radius: .95,
                colors: [
                  kGreen.withOpacity(isDay ? .035 : .070),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // Old code-drawn map layer is now only signal/UI hints, not the map itself.
        Opacity(
          opacity: .035,
          child: child,
        ),
      ],
    );
  }
}


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
        scaffoldBackgroundColor: kBg,
        textTheme: GoogleFonts.heeboTextTheme(
          ThemeData(brightness: Brightness.dark, useMaterial3: true).textTheme,
        ).apply(
          bodyColor: const Color(0xFFEAF1F4),
          displayColor: const Color(0xFFEAF1F4),
        ),
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
  VisualMode visualMode = VisualMode.day;
  DemoRideStep rideStep = DemoRideStep.idle;
  bool _didPrecacheAssets = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_didPrecacheAssets) return;
    _didPrecacheAssets = true;

    for (final asset in kavAllPremiumAssets) {
      precacheImage(AssetImage(asset), context);
    }
  }

  final tabs = const [
    AppTab('ניהול', Icons.dashboard_rounded),
    AppTab('נהג', Icons.local_taxi_rounded),
    AppTab('מרחב', Icons.hub_rounded),
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
            PremiumAssetBackground(mode: visualMode, scene: selected, fallback: CityBackdrop(mode: visualMode)),
            VisualModeScope(
              mode: visualMode,
              child: SafeArea(
                child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
                child: Column(
                  children: [
                    TopBar(
                      mode: visualMode,
                      onCall: () => setState(() => selected = 3),
                      onModeToggle: () => setState(
                        () => visualMode = visualMode == VisualMode.night ? VisualMode.day : VisualMode.night,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 280),
                        child: DemoRideScope(
                          step: rideStep,
                          onStepChanged: (value) => setState(() => rideStep = value),
                          child: AppStage(
                            key: ValueKey('$selected-${visualMode.name}-$rideStep'),
                            selected: selected,
                          ),
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


enum DemoRideStep { idle, searching, offers, selected, enRoute }

extension DemoRideStepText on DemoRideStep {
  int get order => switch (this) {
        DemoRideStep.idle => 0,
        DemoRideStep.searching => 1,
        DemoRideStep.offers => 2,
        DemoRideStep.selected => 3,
        DemoRideStep.enRoute => 4,
      };

  String get title => switch (this) {
        DemoRideStep.idle => 'מוכן לפתיחה',
        DemoRideStep.searching => 'מחפש נהגים',
        DemoRideStep.offers => 'נמצאו 3 הצעות',
        DemoRideStep.selected => 'נהג נבחר',
        DemoRideStep.enRoute => 'הנהג בדרך',
      };

  String get cta => switch (this) {
        DemoRideStep.idle => 'פתח קריאה',
        DemoRideStep.searching => 'הצג הצעות',
        DemoRideStep.offers => 'בחר נהג',
        DemoRideStep.selected => 'התחל נסיעה',
        DemoRideStep.enRoute => 'איפוס דמו',
      };

  DemoRideStep get next => switch (this) {
        DemoRideStep.idle => DemoRideStep.searching,
        DemoRideStep.searching => DemoRideStep.offers,
        DemoRideStep.offers => DemoRideStep.selected,
        DemoRideStep.selected => DemoRideStep.enRoute,
        DemoRideStep.enRoute => DemoRideStep.idle,
      };
}

class DemoRideScope extends InheritedWidget {
  final DemoRideStep step;
  final ValueChanged<DemoRideStep> onStepChanged;

  const DemoRideScope({
    required this.step,
    required this.onStepChanged,
    required super.child,
    super.key,
  });

  static DemoRideScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<DemoRideScope>();
    assert(scope != null, 'DemoRideScope not found');
    return scope!;
  }

  @override
  bool updateShouldNotify(DemoRideScope oldWidget) => oldWidget.step != step;
}

class DemoStepData {
  final String label;
  final IconData icon;

  const DemoStepData(this.label, this.icon);
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

    if (selected == 0) {
      return const AdminCommandScene();
    }

    if (selected == 1) {
      return const DriverLiveScene();
    }

    final title = switch (selected) {
      0 => 'לוח בקרה',
      1 => 'אני על הקו',
      2 => 'קו פתוח',
      3 => 'לאן נוסעים?',
      _ => 'שכבת אמון',
    };

    if (selected == 2) {
      return const DriverZoneScene();
    }

    final subtitle = switch (selected) {
      0 => 'קריאות. נהגים. אמון.',
      1 => 'קריאות חיות באזור.',
      2 => 'מרחב נהגים חי.',
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
                  const SizedBox(height: 16),
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








class AdminCommandScene extends StatelessWidget {
  const AdminCommandScene({super.key});

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
            padding: EdgeInsets.only(top: compact ? 6 : 24, bottom: 10),
            child: Column(
              children: const [
                AdminActionHeader(),
                SizedBox(height: 12),
                AdminControlPanel(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AdminActionHeader extends StatelessWidget {
  const AdminActionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      radius: 20,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: kGreen.withOpacity(.10),
                border: Border.all(color: kGreenSoft.withOpacity(.30)),
              ),
              child: const Icon(Icons.dashboard_rounded, color: kGreenSoft, size: 22),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'לוח שליטה',
                    style: TextStyle(fontSize: 22, height: 1.05, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'קריאות, נהגים, חריגות ואישורים בזמן אמת.',
                    style: TextStyle(
                      color: Color(0xFFAEB8C3),
                      fontSize: 12,
                      height: 1.35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            AdminHealthPill(),
          ],
        ),
      ),
    );
  }
}

class AdminHealthPill extends StatelessWidget {
  const AdminHealthPill({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 11),
      decoration: BoxDecoration(
        color: kGreen.withOpacity(.12),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: kGreenSoft.withOpacity(.35)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_rounded, color: kGreenSoft, size: 14),
          SizedBox(width: 5),
          Text(
            'תקין',
            style: TextStyle(color: kGreenSoft, fontSize: 12, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class AdminControlPanel extends StatelessWidget {
  const AdminControlPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      radius: 22,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: const [
            AdminOpsMetrics(),
            SizedBox(height: 12),
            AdminOpsChart(),
            SizedBox(height: 12),
            AdminAlertCard(),
            SizedBox(height: 10),
            AdminOpsRow(
              icon: Icons.person_add_alt_1_rounded,
              title: 'נהג לאישור',
              meta: 'רפי כהן · מסמכים ממתינים',
              value: 'אשר',
              accent: kGreenSoft,
            ),
            SizedBox(height: 8),
            AdminOpsRow(
              icon: Icons.report_rounded,
              title: 'דיווח חריג',
              meta: 'נסיעה חורגת ממדד אמון',
              value: 'בדוק',
              accent: kGold,
            ),
          ],
        ),
      ),
    );
  }
}

class AdminOpsMetrics extends StatelessWidget {
  const AdminOpsMetrics({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: AdminOpsMetric(icon: Icons.radio_button_checked_rounded, label: 'קריאות', value: '248', accent: kGreenSoft)),
        SizedBox(width: 8),
        Expanded(child: AdminOpsMetric(icon: Icons.local_taxi_rounded, label: 'נהגים', value: '1,458', accent: kGreenSoft)),
        SizedBox(width: 8),
        Expanded(child: AdminOpsMetric(icon: Icons.verified_user_rounded, label: 'אמון', value: '98%', accent: kGold)),
      ],
    );
  }
}

class AdminOpsMetric extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color accent;

  const AdminOpsMetric({
    required this.icon,
    required this.label,
    required this.value,
    required this.accent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 62,
      radius: 14,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: accent, size: 17),
          const SizedBox(height: 3),
          Text(value, style: TextStyle(color: accent, fontSize: 14, fontWeight: FontWeight.w900, height: 1)),
          const SizedBox(height: 3),
          Text(label, style: const TextStyle(color: Color(0xFF8793A0), fontSize: 10, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class AdminOpsChart extends StatelessWidget {
  const AdminOpsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      radius: 18,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          height: 164,
          child: CustomPaint(
            painter: AdminOpsChartPainter(),
            child: const SizedBox.expand(),
          ),
        ),
      ),
    );
  }
}

class AdminOpsChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = Colors.white.withOpacity(.025)
      ..strokeWidth = 1;

    for (double y = 22; y < size.height; y += 34) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final bars = [.42, .60, .48, .78, .64, .86, .68, .92];
    final w = size.width / 15;

    for (var i = 0; i < bars.length; i++) {
      final h = size.height * bars[i] * .62;
      final x = size.width * .08 + i * w * 1.55;
      final y = size.height - h - 10;

      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, w, h),
        const Radius.circular(8),
      );

      canvas.drawRRect(
        rect,
        Paint()
          ..shader = const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kGreenSoft, kGreen],
          ).createShader(rect.outerRect),
      );
    }

    _label(canvas, 'פעילות היום', Offset(size.width - 12, 10), kGreenSoft, right: true);
    _label(canvas, 'Live Ops', const Offset(10, 10), kGold);
  }

  void _label(Canvas canvas, String value, Offset offset, Color color, {bool right = false}) {
    final tp = TextPainter(
      textDirection: TextDirection.rtl,
      text: TextSpan(
        text: value,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w900),
      ),
    )..layout();

    tp.paint(canvas, Offset(right ? offset.dx - tp.width : offset.dx, offset.dy));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class AdminAlertCard extends StatelessWidget {
  const AdminAlertCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      radius: 16,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 11, 12, 11),
        child: Row(
          children: [
            const Icon(Icons.priority_high_rounded, color: kGold, size: 18),
            const SizedBox(width: 9),
            const Expanded(
              child: Text(
                '3 חריגות דורשות בדיקה לפני אישור אוטומטי',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800),
              ),
            ),
            Container(
              height: 28,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kGold.withOpacity(.11),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kGold.withOpacity(.30)),
              ),
              child: const Text(
                'פתח',
                style: TextStyle(color: kGold, fontSize: 11, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminOpsRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String meta;
  final String value;
  final Color accent;

  const AdminOpsRow({
    required this.icon,
    required this.title,
    required this.meta,
    required this.value,
    required this.accent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 52,
      radius: 15,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Icon(icon, color: accent, size: 17),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 2),
                  Text(meta, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Color(0xFF8793A0), fontSize: 10.5, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            Container(
              height: 28,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent.withOpacity(.11),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: accent.withOpacity(.28)),
              ),
              child: Text(
                value,
                style: TextStyle(color: accent, fontSize: 11, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class AdminMetricsGrid extends StatelessWidget {
  const AdminMetricsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Row(
          children: [
            Expanded(child: AdminMetricTile(label: 'קריאות', value: '248', icon: Icons.radio_button_checked_rounded, accent: kGreenSoft)),
            SizedBox(width: 10),
            Expanded(child: AdminMetricTile(label: 'נהגים', value: '1,458', icon: Icons.local_taxi_rounded, accent: kGreenSoft)),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: AdminMetricTile(label: 'דיווחים', value: '23', icon: Icons.report_rounded, accent: kGold)),
            SizedBox(width: 10),
            Expanded(child: AdminMetricTile(label: 'אמון', value: '98%', icon: Icons.verified_user_rounded, accent: kGreenSoft)),
          ],
        ),
      ],
    );
  }
}

class AdminMetricTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color accent;

  const AdminMetricTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.accent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 72,
      radius: 16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: accent, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: accent,
              fontSize: 28,
              fontWeight: FontWeight.w900,
              height: 1.08,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              color: const Color(0xFF8793A0),
              fontSize: 13,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class AdminActivityChart extends StatelessWidget {
  const AdminActivityChart({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: CustomPaint(
        painter: AdminChartPainter(),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class AdminChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF04101B), Color(0xFF071D24), Color(0xFF020711)],
      ).createShader(Offset.zero & size);

    canvas.drawRect(Offset.zero & size, bg);

    final grid = Paint()
      ..color = Colors.white.withOpacity(.010)
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += 42) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }

    for (double y = 0; y < size.height; y += 42) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final bars = [.32, .55, .40, .78, .62, .86, .58, .92, .70];
    final barWidth = size.width / (bars.length * 1.8);
    final gap = barWidth * .8;

    for (var i = 0; i < bars.length; i++) {
      final h = size.height * bars[i] * .72;
      final x = 26 + i * (barWidth + gap);
      final y = size.height - h - 28;

      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, barWidth, h),
        const Radius.circular(12),
      );

      canvas.drawRRect(
        rect,
        Paint()
          ..shader = const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kGreenSoft, kGreen],
          ).createShader(rect.outerRect),
      );

      canvas.drawRRect(
        rect,
        Paint()
          ..color = kGreen.withOpacity(.11)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18),
      );
    }

    _label(canvas, 'פעילות היום', Offset(size.width - 24, 28), kGreenSoft, alignRight: true);
    _label(canvas, 'Live', Offset(28, 28), kGold);
  }

  void _label(Canvas canvas, String text, Offset offset, Color color, {bool alignRight = false}) {
    final painter = TextPainter(
      textDirection: TextDirection.rtl,
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 14,
          fontWeight: FontWeight.w900,
        ),
      ),
    )..layout();

    painter.paint(
      canvas,
      Offset(
        alignRight ? offset.dx - painter.width : offset.dx,
        offset.dy,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class AdminActivityPanel extends StatelessWidget {
  const AdminActivityPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        AdminRow(icon: Icons.radio_button_checked_rounded, title: 'קריאה פעילה', value: 'בני ברק → פתח תקווה', accent: kGreenSoft),
        SizedBox(height: 10),
        AdminRow(icon: Icons.local_fire_department_rounded, title: 'אזור חם', value: 'גוש דן', accent: kGold),
      ],
    );
  }
}

class AdminApprovalsPanel extends StatelessWidget {
  const AdminApprovalsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        AdminRow(icon: Icons.person_add_alt_1_rounded, title: 'נהג לאישור', value: 'רפי כהן', accent: kGreenSoft),
        SizedBox(height: 10),
        AdminRow(icon: Icons.report_rounded, title: 'דיווח לבדיקה', value: 'נסיעה חריגה', accent: kGold),
      ],
    );
  }
}

class AdminRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color accent;

  const AdminRow({
    required this.icon,
    required this.title,
    required this.value,
    required this.accent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 46,
      radius: 16,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(icon, color: accent, size: 28),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
              ),
            ),
            const Spacer(),
            Text(
              value,
              style: TextStyle(
                color: accent,
                fontSize: 14,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class DriverZoneScene extends StatelessWidget {
  const DriverZoneScene({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final compact = width < 620;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Padding(
            padding: EdgeInsets.only(top: compact ? 6 : 24, bottom: 10),
            child: Column(
              children: const [
                ZoneActionHeader(),
                SizedBox(height: 12),
                ZoneOperationsPanel(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ZoneActionHeader extends StatelessWidget {
  const ZoneActionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      radius: 20,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: kGold.withOpacity(.10),
                border: Border.all(color: kGold.withOpacity(.34)),
              ),
              child: const Icon(Icons.hub_rounded, color: kGold, size: 22),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'מרחב חי',
                    style: TextStyle(fontSize: 22, height: 1.05, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'נהגים, קריאות ואזורים חמים בזמן אמת.',
                    style: TextStyle(
                      color: Color(0xFFAEB8C3),
                      fontSize: 12,
                      height: 1.35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            ZoneHotPill(),
          ],
        ),
      ),
    );
  }
}

class ZoneHotPill extends StatelessWidget {
  const ZoneHotPill({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 11),
      decoration: BoxDecoration(
        color: kGold.withOpacity(.11),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: kGold.withOpacity(.34)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.local_fire_department_rounded, color: kGold, size: 14),
          SizedBox(width: 5),
          Text(
            'חם',
            style: TextStyle(color: kGold, fontSize: 12, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class ZoneOperationsPanel extends StatelessWidget {
  const ZoneOperationsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      radius: 22,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: const [
            SizedBox(height: 244, child: ZoneMapCanvas()),
            SizedBox(height: 12),
            ZoneStatsStrip(),
            SizedBox(height: 12),
            ZoneNetworkStatus(),
            SizedBox(height: 10),
            ZoneEventRow(
              icon: Icons.radio_button_checked_rounded,
              title: 'קריאה חדשה',
              value: 'בני ברק · 4 דק׳',
              accent: kGreenSoft,
            ),
            SizedBox(height: 8),
            ZoneEventRow(
              icon: Icons.local_taxi_rounded,
              title: 'נהגים זמינים',
              value: '86 פעילים',
              accent: kGold,
            ),
          ],
        ),
      ),
    );
  }
}

class ZoneMapCanvas extends StatelessWidget {
  const ZoneMapCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: PremiumMapSurface(
        child: CustomPaint(
          painter: ZonePulsePainter(),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class ZonePulsePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final zone = Path()
      ..moveTo(size.width * .20, size.height * .26)
      ..quadraticBezierTo(size.width * .55, size.height * .08, size.width * .82, size.height * .34)
      ..quadraticBezierTo(size.width * .76, size.height * .78, size.width * .30, size.height * .82)
      ..quadraticBezierTo(size.width * .08, size.height * .56, size.width * .20, size.height * .26);

    canvas.drawPath(
      zone,
      Paint()
        ..color = kGreen.withOpacity(.08)
        ..style = PaintingStyle.fill,
    );

    canvas.drawPath(
      zone,
      Paint()
        ..color = kGreenSoft.withOpacity(.38)
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke,
    );

    _dot(canvas, size, const Offset(.28, .36), 'אבי', kGreenSoft);
    _dot(canvas, size, const Offset(.64, .30), 'רפי', kGreenSoft);
    _dot(canvas, size, const Offset(.74, .60), 'משה', kGreenSoft);
    _dot(canvas, size, const Offset(.42, .74), 'יוסי', kGreenSoft);
    _call(canvas, size, const Offset(.52, .52));
  }

  void _dot(Canvas canvas, Size size, Offset unit, String label, Color color) {
    final p = Offset(size.width * unit.dx, size.height * unit.dy);
    canvas.drawCircle(p, 14, Paint()..color = color.withOpacity(.10));
    canvas.drawCircle(p, 5, Paint()..color = color);

    final tp = TextPainter(
      textDirection: TextDirection.rtl,
      text: TextSpan(
        text: label,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w900),
      ),
    )..layout();

    tp.paint(canvas, p.translate(9, -18));
  }

  void _call(Canvas canvas, Size size, Offset unit) {
    final p = Offset(size.width * unit.dx, size.height * unit.dy);
    canvas.drawCircle(
      p,
      30,
      Paint()
        ..color = kGold.withOpacity(.11)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18),
    );
    canvas.drawCircle(p, 10, Paint()..color = kGold);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ZoneStatsStrip extends StatelessWidget {
  const ZoneStatsStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: ZoneStat(label: 'נהגים', value: '86', icon: Icons.local_taxi_rounded, accent: kGreenSoft)),
        SizedBox(width: 8),
        Expanded(child: ZoneStat(label: 'קריאות', value: '24', icon: Icons.radio_button_checked_rounded, accent: kGreenSoft)),
        SizedBox(width: 8),
        Expanded(child: ZoneStat(label: 'עומס', value: 'גבוה', icon: Icons.local_fire_department_rounded, accent: kGold)),
      ],
    );
  }
}

class ZoneStat extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color accent;

  const ZoneStat({
    required this.label,
    required this.value,
    required this.icon,
    required this.accent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 62,
      radius: 14,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: accent, size: 17),
          const SizedBox(height: 3),
          Text(value, style: TextStyle(color: accent, fontSize: 14, fontWeight: FontWeight.w900, height: 1)),
          const SizedBox(height: 3),
          Text(label, style: const TextStyle(color: Color(0xFF8793A0), fontSize: 10, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class ZoneNetworkStatus extends StatelessWidget {
  const ZoneNetworkStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      radius: 16,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 11, 12, 11),
        child: Row(
          children: [
            const Icon(Icons.sync_alt_rounded, color: kGreenSoft, size: 18),
            const SizedBox(width: 9),
            const Expanded(
              child: Text(
                'איזון אזור: חסרים 6 נהגים סביב בני ברק',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800),
              ),
            ),
            Container(
              height: 28,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kGreen.withOpacity(.12),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kGreenSoft.withOpacity(.30)),
              ),
              child: const Text(
                'נתב',
                style: TextStyle(color: kGreenSoft, fontSize: 11, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ZoneEventRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color accent;

  const ZoneEventRow({
    required this.icon,
    required this.title,
    required this.value,
    required this.accent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 50,
      radius: 15,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Icon(icon, color: accent, size: 16),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900),
              ),
            ),
            Text(
              value,
              style: TextStyle(color: accent, fontSize: 13, fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}



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
          constraints: const BoxConstraints(maxWidth: 820),
          child: Padding(
            padding: EdgeInsets.only(top: compact ? 6 : 24, bottom: 10),
            child: Column(
              children: const [
                TrustActionHeader(),
                SizedBox(height: 12),
                TrustAssurancePanel(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TrustActionHeader extends StatelessWidget {
  const TrustActionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      radius: 20,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: kGold.withOpacity(.10),
                border: Border.all(color: kGold.withOpacity(.36)),
              ),
              child: const Icon(Icons.verified_user_rounded, color: kGold, size: 22),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'שכבת אמון',
                    style: TextStyle(fontSize: 22, height: 1.05, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'אימות נהגים, מסמכים, דירוגים ושירות אנושי.',
                    style: TextStyle(
                      color: Color(0xFFAEB8C3),
                      fontSize: 12,
                      height: 1.35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrustAssurancePanel extends StatelessWidget {
  const TrustAssurancePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      radius: 22,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: const [
            TrustScoreHero(),
            SizedBox(height: 12),
            TrustProofGrid(),
            SizedBox(height: 12),
            TrustRiskRow(
              icon: Icons.badge_rounded,
              title: 'נהג מאומת',
              meta: 'זהות, רישיון, ביטוח ותוקף',
              value: 'מאושר',
              accent: kGreenSoft,
            ),
            SizedBox(height: 8),
            TrustRiskRow(
              icon: Icons.support_agent_rounded,
              title: 'שירות אנושי',
              meta: 'טיפול בקריאות חריגות ודיווחים',
              value: 'פעיל',
              accent: kGold,
            ),
            SizedBox(height: 8),
            TrustRiskRow(
              icon: Icons.lock_rounded,
              title: 'פרטיות',
              meta: 'מידע רגיש נשמר רק לצורך השירות',
              value: 'מוגן',
              accent: kGreenSoft,
            ),
            SizedBox(height: 12),
            TrustPromiseBar(),
          ],
        ),
      ),
    );
  }
}

class TrustScoreHero extends StatelessWidget {
  const TrustScoreHero({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      radius: 18,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
        child: Column(
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kGold.withOpacity(.09),
                border: Border.all(color: kGold.withOpacity(.42), width: 1),
                boxShadow: [
                  BoxShadow(color: kGold.withOpacity(.14), blurRadius: 32),
                ],
              ),
              child: const Icon(Icons.verified_user_rounded, color: kGold, size: 36),
            ),
            const SizedBox(height: 10),
            const Text(
              '98%',
              style: TextStyle(
                color: kGold,
                fontSize: 34,
                height: 1,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'מדד אמון מערכת',
              style: TextStyle(
                color: Color(0xFFAEB8C3),
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrustProofGrid extends StatelessWidget {
  const TrustProofGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: TrustProofMetric(
            icon: Icons.description_rounded,
            label: 'מסמכים',
            value: 'נבדקו',
            accent: kGreenSoft,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: TrustProofMetric(
            icon: Icons.star_rounded,
            label: 'דירוג',
            value: '4.9',
            accent: kGold,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: TrustProofMetric(
            icon: Icons.local_taxi_rounded,
            label: 'נסיעות',
            value: '+247',
            accent: kGreenSoft,
          ),
        ),
      ],
    );
  }
}

class TrustProofMetric extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color accent;

  const TrustProofMetric({
    required this.icon,
    required this.label,
    required this.value,
    required this.accent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 62,
      radius: 14,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: accent, size: 17),
          const SizedBox(height: 3),
          Text(value, style: TextStyle(color: accent, fontSize: 14, fontWeight: FontWeight.w900, height: 1)),
          const SizedBox(height: 3),
          Text(label, style: const TextStyle(color: Color(0xFF8793A0), fontSize: 10, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class TrustRiskRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String meta;
  final String value;
  final Color accent;

  const TrustRiskRow({
    required this.icon,
    required this.title,
    required this.meta,
    required this.value,
    required this.accent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 52,
      radius: 15,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Icon(icon, color: accent, size: 17),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 2),
                  Text(meta, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Color(0xFF8793A0), fontSize: 10.5, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            Container(
              height: 28,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent.withOpacity(.11),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: accent.withOpacity(.28)),
              ),
              child: Text(
                value,
                style: TextStyle(color: accent, fontSize: 11, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrustPromiseBar extends StatelessWidget {
  const TrustPromiseBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 46,
      radius: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.shield_rounded, color: kGold, size: 17),
          SizedBox(width: 7),
          Text(
            'אמון לפני נסיעה. שקיפות לפני תשלום.',
            style: TextStyle(
              color: Color(0xFFAEB8C3),
              fontSize: 12,
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
                const SizedBox(height: 12),
                Text(
                  '3 נהגים הגיבו',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: compact ? 32 : 42,
                    height: 1.08,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -.6,
                  ),
                ),
                const SizedBox(height: 14),
                GlassPanel(
                  radius: 22,
                  child: Padding(
                    padding: EdgeInsets.all(compact ? 14 : 18),
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
                            color: const Color(0xFF7E8995),
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
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kGreen.withOpacity(.10),
            border: Border.all(color: kGreenSoft.withOpacity(.45)),
            boxShadow: [
              BoxShadow(color: kGreen.withOpacity(.09), blurRadius: 48),
            ],
          ),
          child: const Icon(Icons.favorite_rounded, color: kGreenSoft, size: 38),
        ),
        const SizedBox(height: 10),
        const Text(
          'בחר נהג לפי אמון, זמן והצעה',
          style: TextStyle(
            color: const Color(0xFFAEB8C3),
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
      height: 72,
      radius: 18,
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
                      fontSize: 14,
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
                height: 1.08,
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
          height: 46,
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
          constraints: const BoxConstraints(maxWidth: 880),
          child: Padding(
            padding: EdgeInsets.only(top: compact ? 6 : 24, bottom: 10),
            child: Column(
              children: const [
                DriverActionHeader(),
                SizedBox(height: 12),
                DriverWorkPanel(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DriverActionHeader extends StatelessWidget {
  const DriverActionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      radius: 20,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: kGreen.withOpacity(.10),
                border: Border.all(color: kGreenSoft.withOpacity(.30)),
              ),
              child: const Icon(Icons.local_taxi_rounded, color: kGreenSoft, size: 22),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'עבודת נהג',
                    style: TextStyle(fontSize: 22, height: 1.05, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'זמינות, קריאות קרובות, הכנסה ואמון במקום אחד.',
                    style: TextStyle(
                      color: Color(0xFFAEB8C3),
                      fontSize: 12,
                      height: 1.35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            DriverOnlinePill(),
          ],
        ),
      ),
    );
  }
}

class DriverOnlinePill extends StatelessWidget {
  const DriverOnlinePill({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 11),
      decoration: BoxDecoration(
        color: kGreen.withOpacity(.12),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: kGreenSoft.withOpacity(.35)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.sensors_rounded, color: kGreenSoft, size: 14),
          SizedBox(width: 5),
          Text(
            'על הקו',
            style: TextStyle(color: kGreenSoft, fontSize: 12, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

class DriverWorkPanel extends StatelessWidget {
  const DriverWorkPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      radius: 22,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: const [
            DriverLiveStatusCard(),
            SizedBox(height: 12),
            SizedBox(height: 218, child: LiveMapCanvas()),
            SizedBox(height: 12),
            DriverWorkStats(),
            SizedBox(height: 12),
            DriverPrimaryCall(),
            SizedBox(height: 10),
            DriverQueueRow(
              title: 'קריאה משתלמת',
              meta: 'רמת גן → ירושלים · 9 דק׳',
              value: '₪240',
              accent: kGold,
            ),
            SizedBox(height: 8),
            DriverQueueRow(
              title: 'קריאה קרובה',
              meta: 'בני ברק → פתח תקווה · 4 דק׳',
              value: '₪68',
              accent: kGreenSoft,
            ),
          ],
        ),
      ),
    );
  }
}

class DriverLiveStatusCard extends StatelessWidget {
  const DriverLiveStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(colors: [Color(0xFF17C985), Color(0xFF73E6B4)]),
        boxShadow: [
          BoxShadow(color: kGreen.withOpacity(.16), blurRadius: 20, offset: Offset(0, 7)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFF03120B).withOpacity(.90),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(Icons.sensors_rounded, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'זמין לקבלת קריאות',
              style: TextStyle(color: Color(0xFF03120B), fontSize: 15, fontWeight: FontWeight.w900),
            ),
          ),
          const Text(
            'LIVE',
            style: TextStyle(
              color: Color(0xFF03120B),
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: .8,
            ),
          ),
        ],
      ),
    );
  }
}

class DriverWorkStats extends StatelessWidget {
  const DriverWorkStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: DriverWorkMetric(icon: Icons.payments_rounded, label: 'היום', value: '₪740', accent: kGreenSoft)),
        SizedBox(width: 8),
        Expanded(child: DriverWorkMetric(icon: Icons.verified_user_rounded, label: 'אמון', value: '98%', accent: kGold)),
        SizedBox(width: 8),
        Expanded(child: DriverWorkMetric(icon: Icons.local_taxi_rounded, label: 'קריאות', value: '12', accent: kGreenSoft)),
      ],
    );
  }
}

class DriverWorkMetric extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color accent;

  const DriverWorkMetric({
    required this.icon,
    required this.label,
    required this.value,
    required this.accent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 62,
      radius: 14,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: accent, size: 17),
          const SizedBox(height: 3),
          Text(value, style: TextStyle(color: accent, fontSize: 14, fontWeight: FontWeight.w900, height: 1)),
          const SizedBox(height: 3),
          Text(label, style: const TextStyle(color: Color(0xFF8793A0), fontSize: 10, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class DriverPrimaryCall extends StatelessWidget {
  const DriverPrimaryCall({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      radius: 18,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kGold.withOpacity(.10),
                border: Border.all(color: kGold.withOpacity(.42)),
              ),
              child: const Icon(Icons.local_fire_department_rounded, color: kGold, size: 21),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('קריאה מומלצת', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900)),
                  SizedBox(height: 3),
                  Text(
                    'רמת גן → ירושלים · 9 דק׳ ממך',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Color(0xFFAEB8C3), fontSize: 11, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const Text('₪240', style: TextStyle(color: kGold, fontSize: 18, fontWeight: FontWeight.w900)),
            const SizedBox(width: 10),
            SizedBox(width: 74, child: NeonButton(label: 'קבל', compact: true)),
          ],
        ),
      ),
    );
  }
}

class DriverQueueRow extends StatelessWidget {
  final String title;
  final String meta;
  final String value;
  final Color accent;

  const DriverQueueRow({
    required this.title,
    required this.meta,
    required this.value,
    required this.accent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 50,
      radius: 15,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Icon(Icons.radio_button_checked_rounded, color: accent, size: 16),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 2),
                  Text(meta, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Color(0xFF8793A0), fontSize: 10.5, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            Text(value, style: TextStyle(color: accent, fontSize: 13, fontWeight: FontWeight.w900)),
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
              top: compact ? 6 : 24,
              bottom: 10,
            ),
            child: Column(
              children: const [
                CustomerActionHeader(),
                SizedBox(height: 12),
                CustomerRequestPanel(),
                SizedBox(height: 12),
                TrustStrip(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomerActionHeader extends StatelessWidget {
  const CustomerActionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      radius: 20,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: kGreen.withOpacity(.10),
                border: Border.all(color: kGreenSoft.withOpacity(.30)),
              ),
              child: const Icon(Icons.near_me_rounded, color: kGreenSoft, size: 22),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'פתיחת קריאה',
                    style: TextStyle(
                      fontSize: 22,
                      height: 1.05,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -.2,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'בחר איסוף, יעד וזמן — המערכת תמצא נהג מתאים.',
                    style: TextStyle(
                      color: Color(0xFFAEB8C3),
                      fontSize: 12,
                      height: 1.35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            CustomerStatusPill(label: 'זמין'),
          ],
        ),
      ),
    );
  }
}

class CustomerStatusPill extends StatelessWidget {
  final String label;

  const CustomerStatusPill({
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 11),
      decoration: BoxDecoration(
        color: kGreen.withOpacity(.12),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: kGreenSoft.withOpacity(.35)),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          color: kGreenSoft,
          fontSize: 12,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class CustomerRequestPanel extends StatelessWidget {
  const CustomerRequestPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      radius: 22,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: const [
            AppInput(label: 'נקודת איסוף'),
            SizedBox(height: 10),
            AppInput(label: 'יעד הנסיעה'),
            SizedBox(height: 10),
            SegmentRow(),
            SizedBox(height: 12),
            CustomerRideSummary(),
            SizedBox(height: 10),
            DemoRideProgressStrip(),
            SizedBox(height: 12),
            SizedBox(
              height: 214,
              child: LiveMapCanvas(),
            ),
            SizedBox(height: 12),
            DemoRidePrimaryButton(),
          ],
        ),
      ),
    );
  }
}


class DemoRideProgressStrip extends StatelessWidget {
  const DemoRideProgressStrip({super.key});

  static const items = [
    DemoStepData('פתיחה', Icons.near_me_rounded),
    DemoStepData('חיפוש', Icons.radar_rounded),
    DemoStepData('הצעות', Icons.groups_rounded),
    DemoStepData('נהג', Icons.verified_rounded),
    DemoStepData('בדרך', Icons.local_taxi_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final scope = DemoRideScope.of(context);
    final active = scope.step.order;

    return GlassPanel(
      height: 62,
      radius: 16,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            for (var i = 0; i < items.length; i++)
              Expanded(
                child: DemoRideStepChip(
                  data: items[i],
                  active: i <= active,
                  current: i == active,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class DemoRideStepChip extends StatelessWidget {
  final DemoStepData data;
  final bool active;
  final bool current;

  const DemoRideStepChip({
    required this.data,
    required this.active,
    required this.current,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = current ? kGold : active ? kGreenSoft : const Color(0xFF65717D);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: current ? 28 : 23,
          height: current ? 28 : 23,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(current ? .18 : .08),
            border: Border.all(color: color.withOpacity(current ? .55 : .24)),
            boxShadow: current
                ? [
                    BoxShadow(color: color.withOpacity(.16), blurRadius: 18),
                  ]
                : null,
          ),
          child: Icon(data.icon, color: color, size: current ? 15 : 13),
        ),
        const SizedBox(height: 4),
        Text(
          data.label,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: color,
            fontSize: 9.5,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class DemoRidePrimaryButton extends StatelessWidget {
  const DemoRidePrimaryButton({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = DemoRideScope.of(context);
    final step = scope.step;

    return NeonButton(
      label: step.cta,
      onTap: () {
        final next = step.next;
        scope.onStepChanged(next);

        switch (next) {
          case DemoRideStep.searching:
            DemoFeedback.show(
              context,
              title: 'הקריאה נפתחה',
              message: 'המערכת סורקת נהגים זמינים באזור ומחשבת אמון, זמן ומרחק.',
              icon: Icons.radar_rounded,
              accent: kGreenSoft,
            );
            break;
          case DemoRideStep.offers:
            DemoFeedback.show(
              context,
              title: 'נמצאו 3 הצעות',
              message: 'הנהגים דורגו לפי זמן הגעה, מדד אמון ודירוג לקוחות.',
              icon: Icons.groups_rounded,
              accent: kGold,
            );
            break;
          case DemoRideStep.selected:
            DemoFeedback.show(
              context,
              title: 'נהג נבחר',
              message: 'רפי כהן נבחר כנהג מומלץ. פרטי הנסיעה ננעלו בדמו.',
              icon: Icons.verified_rounded,
              accent: kGold,
            );
            break;
          case DemoRideStep.enRoute:
            DemoFeedback.show(
              context,
              title: 'הנהג בדרך',
              message: 'הלקוח מקבל עדכון חי, והנהג רואה מסלול קריאה ברור.',
              icon: Icons.local_taxi_rounded,
              accent: kGreenSoft,
            );
            break;
          case DemoRideStep.idle:
            DemoFeedback.show(
              context,
              title: 'הדמו אופס',
              message: 'אפשר להציג שוב את זרימת הקריאה מההתחלה.',
              icon: Icons.restart_alt_rounded,
              accent: kGreenSoft,
            );
            break;
        }
      },
    );
  }
}


class CustomerRideSummary extends StatelessWidget {
  const CustomerRideSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: CustomerMiniMetric(
            icon: Icons.schedule_rounded,
            label: 'הגעה',
            value: '4 דק׳',
            accent: kGreenSoft,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: CustomerMiniMetric(
            icon: Icons.route_rounded,
            label: 'מסלול',
            value: '8.6 ק״מ',
            accent: kGreenSoft,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: CustomerMiniMetric(
            icon: Icons.verified_user_rounded,
            label: 'אמון',
            value: '98%',
            accent: kGold,
          ),
        ),
      ],
    );
  }
}

class CustomerMiniMetric extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color accent;

  const CustomerMiniMetric({
    required this.icon,
    required this.label,
    required this.value,
    required this.accent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 62,
      radius: 14,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: accent, size: 17),
          const SizedBox(height: 3),
          Text(
            value,
            style: TextStyle(
              color: accent,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF8793A0),
              fontSize: 10,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}


class TrustStrip extends StatelessWidget {
  const TrustStrip({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 46,
      radius: 18,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.verified_user_rounded, color: kGold, size: 24),
          SizedBox(width: 10),
          Text(
            'נהגים נבחרים',
            style: TextStyle(fontWeight: FontWeight.w900, color: const Color(0xFFAEB8C3)),
          ),
          SizedBox(width: 12),
          Text('·', style: TextStyle(color: kGold, fontWeight: FontWeight.w900)),
          SizedBox(width: 12),
          Text(
            'ביטוח מלא',
            style: TextStyle(fontWeight: FontWeight.w900, color: const Color(0xFFAEB8C3)),
          ),
          SizedBox(width: 12),
          Text('·', style: TextStyle(color: kGold, fontWeight: FontWeight.w900)),
          SizedBox(width: 12),
          Text(
            'דירוגים אמיתיים',
            style: TextStyle(fontWeight: FontWeight.w900, color: const Color(0xFFAEB8C3)),
          ),
        ],
      ),
    );
  }
}


class CityBackdrop extends StatelessWidget {
  final VisualMode mode;

  const CityBackdrop({required this.mode, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CityBackdropPainter(mode),
      child: const SizedBox.expand(),
    );
  }
}

class CityBackdropPainter extends CustomPainter {
  final VisualMode mode;

  const CityBackdropPainter(this.mode);

  bool get isDay => mode == VisualMode.day;

  @override
  void paint(Canvas canvas, Size size) {
    final bgColors = isDay
        ? const [
            Color(0xFFE6FFF7),
            Color(0xFF8EEBCF),
            Color(0xFF14505B),
            Color(0xFF03131C),
          ]
        : const [
            Color(0xFF031D1A),
            Color(0xFF061522),
            Color(0xFF02070F),
            Color(0xFF000000),
          ];

    final bg = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: bgColors,
      ).createShader(Offset.zero & size);

    canvas.drawRect(Offset.zero & size, bg);

    _drawSkyGlow(canvas, size);
    _drawCityNetwork(canvas, size);
    _drawPerspectiveGrid(canvas, size);
    _drawSkyline(canvas, size);
    _drawBottomFade(canvas, size);
  }

  void _drawSkyGlow(Canvas canvas, Size size) {
    final topGlow = Paint()
      ..shader = RadialGradient(
        colors: [
          kGreen.withOpacity(isDay ? .44 : .52),
          kGreen.withOpacity(isDay ? .10 : .16),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(size.width * .52, size.height * .08),
          radius: size.width * .86,
        ),
      );

    canvas.drawCircle(
      Offset(size.width * .52, size.height * .08),
      size.width * .86,
      topGlow,
    );

    final blueGlow = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF38BDF8).withOpacity(isDay ? .16 : .20),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(size.width * .16, size.height * .30),
          radius: size.width * .58,
        ),
      );

    canvas.drawCircle(
      Offset(size.width * .16, size.height * .30),
      size.width * .58,
      blueGlow,
    );
  }

  void _drawPerspectiveGrid(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = Colors.white.withOpacity(isDay ? .075 : .055)
      ..strokeWidth = 1;

    for (double x = -size.width; x < size.width * 2; x += 56) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + size.width * .36, size.height),
        grid,
      );
    }

    for (double y = 0; y < size.height; y += 56) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
  }

  void _drawCityNetwork(Canvas canvas, Size size) {
    final road = Paint()
      ..color = const Color(0xFF5EEAD4).withOpacity(isDay ? .20 : .14)
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    final glowRoad = Paint()
      ..color = kGreen.withOpacity(isDay ? .16 : .20)
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 9);

    final roads = [
      [Offset(.05, .72), Offset(.30, .58), Offset(.55, .52), Offset(.92, .38)],
      [Offset(.15, .38), Offset(.38, .48), Offset(.62, .68), Offset(.92, .78)],
      [Offset(.08, .55), Offset(.42, .34), Offset(.82, .18)],
      [Offset(.28, .88), Offset(.44, .63), Offset(.72, .44)],
      [Offset(.02, .30), Offset(.25, .42), Offset(.48, .36), Offset(.76, .50)],
    ];

    for (final roadPoints in roads) {
      final path = Path()
        ..moveTo(size.width * roadPoints.first.dx, size.height * roadPoints.first.dy);

      for (var i = 1; i < roadPoints.length; i++) {
        final p = roadPoints[i];
        path.lineTo(size.width * p.dx, size.height * p.dy);
      }

      canvas.drawPath(path, glowRoad);
      canvas.drawPath(path, road);
    }

    final nodePaint = Paint()..color = kGreenSoft.withOpacity(isDay ? .72 : .62);
    final nodeGlow = Paint()
      ..color = kGreen.withOpacity(.32)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16);

    final nodes = [
      Offset(.22, .39),
      Offset(.36, .50),
      Offset(.51, .53),
      Offset(.67, .45),
      Offset(.82, .36),
      Offset(.44, .68),
      Offset(.75, .72),
    ];

    for (final n in nodes) {
      final pos = Offset(size.width * n.dx, size.height * n.dy);
      canvas.drawCircle(pos, 13, nodeGlow);
      canvas.drawCircle(pos, 3.6, nodePaint);
    }
  }

  void _drawSkyline(Canvas canvas, Size size) {
    final skylinePaint = Paint()
      ..color = (isDay ? const Color(0xFF063140) : const Color(0xFF030A13)).withOpacity(.82);

    final windowPaint = Paint()
      ..color = (isDay ? Colors.white : kGold).withOpacity(isDay ? .22 : .42);

    final heights = [46, 92, 58, 142, 74, 176, 104, 48, 132, 92, 52, 160, 82, 118, 62, 146];
    final w = size.width / heights.length;

    for (var i = 0; i < heights.length; i++) {
      final h = heights[i].toDouble();
      final rect = Rect.fromLTWH(i * w + 2, size.height - h, w - 5, h);
      canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(4)), skylinePaint);

      for (double y = rect.top + 18; y < rect.bottom - 10; y += 22) {
        if ((y / 22 + i).floor().isEven) {
          canvas.drawCircle(Offset(rect.center.dx, y), 1.6, windowPaint);
        }
      }
    }
  }

  void _drawBottomFade(Canvas canvas, Size size) {
    final fade = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          Colors.black.withOpacity(isDay ? .58 : .88),
        ],
      ).createShader(Rect.fromLTWH(0, size.height * .58, size.width, size.height * .42));

    canvas.drawRect(Rect.fromLTWH(0, size.height * .58, size.width, size.height * .42), fade);
  }

  @override
  bool shouldRepaint(covariant CityBackdropPainter oldDelegate) => oldDelegate.mode != mode;
}



class TopBar extends StatelessWidget {
  final VisualMode mode;
  final VoidCallback onCall;
  final VoidCallback onModeToggle;

  const TopBar({
    required this.mode,
    required this.onCall,
    required this.onModeToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      height: 46,
      radius: 24,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
            const BrandSmall(),
            const Spacer(),
            GestureDetector(
              onTap: onModeToggle,
              child: ModeToggleChip(mode: mode),
            ),
            const SizedBox(width: 10),
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

class ModeToggleChip extends StatelessWidget {
  final VisualMode mode;

  const ModeToggleChip({required this.mode, super.key});

  @override
  Widget build(BuildContext context) {
    final isDay = mode == VisualMode.day;

    return Container(
      height: 38,
      width: 42,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.black.withOpacity(.24),
        border: Border.all(
          color: (isDay ? kGold : kGreenSoft).withOpacity(.55),
        ),
        boxShadow: [
          BoxShadow(
            color: (isDay ? kGold : kGreen).withOpacity(.22),
            blurRadius: 26,
          ),
        ],
      ),
      child: Icon(
        isDay ? Icons.wb_sunny_rounded : Icons.nights_stay_rounded,
        color: isDay ? kGold : kGreenSoft,
        size: 22,
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
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
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
        const SizedBox(height: 12),
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
            height: 1.08,
            fontWeight: FontWeight.w900,
            letterSpacing: -3,
          ),
        ),
        const SizedBox(height: 12),
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
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 48, 20, 20),
                child: Column(
                  children: [
                    const PhoneHeader(),
                    const SizedBox(height: 12),
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
        Icon(Icons.notifications_none_rounded, color: const Color(0xFFAEB8C3)),
        Spacer(),
        BrandSmall(),
        Spacer(),
        Icon(Icons.menu_rounded, color: const Color(0xFFAEB8C3)),
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
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
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
              style: TextStyle(color: Color(0xFF03120B), fontSize: 14, fontWeight: FontWeight.w900),
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
      child: PremiumMapSurface(
        child: CustomPaint(
          painter: LiveMapPainter(),
          child: const SizedBox.expand(),
        ),
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
        colors: [Color(0xFF020711), Color(0xFF061B22), Color(0xFF01040B)],
      ).createShader(Offset.zero & size);

    canvas.drawRect(Offset.zero & size, bg);

    _drawMapTexture(canvas, size);
    _drawCoast(canvas, size);
    _drawRoute(canvas, size);
    _drawPins(canvas, size);
    _drawLabels(canvas, size);
  }

  void _drawMapTexture(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = Colors.white.withOpacity(.010)
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += 34) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }

    for (double y = 0; y < size.height; y += 34) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final road = Paint()
      ..color = const Color(0xFF5EEAD4).withOpacity(.14)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < 7; i++) {
      final y = size.height * (.18 + i * .11);
      final path = Path()
        ..moveTo(size.width * .06, y)
        ..quadraticBezierTo(
          size.width * (.28 + math.sin(i) * .04),
          y + 24,
          size.width * .52,
          y - 8,
        )
        ..quadraticBezierTo(
          size.width * .72,
          y - 28,
          size.width * .95,
          y + 12,
        );
      canvas.drawPath(path, road);
    }
  }

  void _drawCoast(Canvas canvas, Size size) {
    final coast = Path()
      ..moveTo(0, size.height * .22)
      ..cubicTo(size.width * .18, size.height * .28, size.width * .08, size.height * .52, size.width * .22, size.height * .66)
      ..cubicTo(size.width * .30, size.height * .76, size.width * .18, size.height * .92, 0, size.height);

    canvas.drawPath(
      coast,
      Paint()
        ..color = const Color(0xFF38BDF8).withOpacity(.08)
        ..style = PaintingStyle.fill,
    );

    canvas.drawPath(
      coast,
      Paint()
        ..color = const Color(0xFF38BDF8).withOpacity(.24)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7),
    );
  }

  void _drawRoute(Canvas canvas, Size size) {
    final route = Path()
      ..moveTo(size.width * .16, size.height * .72)
      ..cubicTo(
        size.width * .32,
        size.height * .62,
        size.width * .45,
        size.height * .48,
        size.width * .52,
        size.height * .42,
      )
      ..cubicTo(
        size.width * .64,
        size.height * .30,
        size.width * .74,
        size.height * .20,
        size.width * .88,
        size.height * .25,
      );

    canvas.drawPath(
      route,
      Paint()
        ..color = kGreen.withOpacity(.11)
        ..strokeWidth = 16
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18),
    );

    canvas.drawPath(
      route,
      Paint()
        ..shader = const LinearGradient(
          colors: [kGreen, kGreenSoft],
        ).createShader(Offset.zero & size)
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke,
    );
  }

  void _drawPins(Canvas canvas, Size size) {
    _pin(canvas, Offset(size.width * .50, size.height * .50), 18, kGreenSoft);
    _pin(canvas, Offset(size.width * .22, size.height * .36), 11, kGreenSoft);
    _pin(canvas, Offset(size.width * .74, size.height * .36), 11, kGreenSoft);
    _pin(canvas, Offset(size.width * .31, size.height * .76), 11, kGreenSoft);
    _pin(canvas, Offset(size.width * .84, size.height * .24), 13, kGold);
  }

  void _drawLabels(Canvas canvas, Size size) {
    _label(canvas, 'קריאה פתוחה', Offset(size.width * .56, size.height * .20), Colors.white);
    _label(canvas, 'אבי · 4 דק׳', Offset(size.width * .65, size.height * .48), kGreenSoft);
    _label(canvas, 'רפי · 7 דק׳', Offset(size.width * .18, size.height * .52), Colors.white);
  }

  void _pin(Canvas canvas, Offset offset, double r, Color color) {
    final glow = Paint()
      ..color = color.withOpacity(.26)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 22);

    canvas.drawCircle(offset, r * 3.2, glow);
    canvas.drawCircle(offset, r, Paint()..color = color.withOpacity(.92));
    canvas.drawCircle(offset, r * .42, Paint()..color = Colors.white.withOpacity(.72));
  }

  void _label(Canvas canvas, String text, Offset offset, Color color) {
    final textPainter = TextPainter(
      textDirection: TextDirection.rtl,
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w900),
      ),
    )..layout();

    final rect = Rect.fromLTWH(offset.dx - textPainter.width - 18, offset.dy - 16, textPainter.width + 36, 36);

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(18)),
      Paint()..color = Colors.black.withOpacity(.72),
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(18)),
      Paint()
        ..color = kGreen.withOpacity(.10)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    textPainter.paint(canvas, Offset(rect.left + 18, rect.top + 9));
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
            Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900)),
            const Spacer(),
            Text(meta, style: const TextStyle(color: kGreenSoft, fontWeight: FontWeight.w900)),
          ],
        ),
      ),
    );
  }
}


class DemoFeedback {
  static void show(
    BuildContext context, {
    required String title,
    required String message,
    IconData icon = Icons.check_circle_rounded,
    Color accent = kGreenSoft,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(.38),
      builder: (sheetContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 18),
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    const Color(0xFF07111D).withOpacity(.96),
                    const Color(0xFF020711).withOpacity(.94),
                  ],
                ),
                border: Border.all(color: accent.withOpacity(.32)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(.48), blurRadius: 28, offset: const Offset(0, 14)),
                  BoxShadow(color: accent.withOpacity(.10), blurRadius: 34),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: accent.withOpacity(.11),
                      border: Border.all(color: accent.withOpacity(.30)),
                    ),
                    child: Icon(icon, color: accent, size: 23),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            height: 1.15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          message,
                          style: const TextStyle(
                            color: Color(0xFFAEB8C3),
                            fontSize: 12,
                            height: 1.35,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => Navigator.of(sheetContext).pop(),
                    child: Container(
                      height: 34,
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: accent.withOpacity(.12),
                        border: Border.all(color: accent.withOpacity(.28)),
                      ),
                      child: Text(
                        'סגור',
                        style: TextStyle(
                          color: accent,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void byLabel(BuildContext context, String label) {
    switch (label) {
      case 'פתח קריאה':
        show(
          context,
          title: 'הקריאה נפתחה',
          message: 'המערכת מחפשת נהגים זמינים באזור ומדרגת אותם לפי אמון, זמן ומרחק.',
          icon: Icons.near_me_rounded,
          accent: kGreenSoft,
        );
        return;
      case 'קבל':
        show(
          context,
          title: 'הקריאה התקבלה',
          message: 'הנהג קיבל את הקריאה, המסלול נשמר והלקוח יקבל עדכון מיידי.',
          icon: Icons.local_taxi_rounded,
          accent: kGold,
        );
        return;
      case 'בחר הצעה':
        show(
          context,
          title: 'הצעה נבחרה',
          message: 'המערכת נעלה נהג מומלץ לפי מדד אמון, זמן הגעה ודירוג.',
          icon: Icons.verified_rounded,
          accent: kGold,
        );
        return;
      default:
        show(
          context,
          title: label,
          message: 'פעולה זמינה בדמו. בשלב המוצר הבא היא תחובר לשרת ולנתונים חיים.',
          icon: Icons.touch_app_rounded,
          accent: kGreenSoft,
        );
    }
  }
}



class AppInput extends StatelessWidget {
  final String label;

  const AppInput({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => DemoFeedback.show(
        context,
        title: label,
        message: 'בדמו זה שדה פעיל. בשלב הבא נחבר בחירת כתובת, מיקום נוכחי והשלמה אוטומטית.',
        icon: Icons.location_on_rounded,
        accent: kGreenSoft,
      ),
      child: GlassPanel(
        height: 46,
        radius: 22,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              const Icon(Icons.location_on_rounded, color: kGreen),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                ),
              ),
              const Icon(Icons.chevron_left_rounded, color: Color(0xFF8793A0), size: 18),
            ],
          ),
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
    return GestureDetector(
      onTap: () => DemoFeedback.show(
        context,
        title: 'בחירת זמן',
        message: 'נבחר: $label. בדמו הבא הבחירה תשנה את מסלול הקריאה ואת זמינות הנהגים.',
        icon: active ? Icons.schedule_rounded : Icons.calendar_month_rounded,
        accent: active ? kGreenSoft : kGold,
      ),
      child: Container(
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? kGreen.withOpacity(.10) : Colors.black.withOpacity(.28),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: active ? kGreenSoft : Colors.white.withOpacity(.1)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : const Color(0xFF8793A0),
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
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
      height: 80,
      radius: 16,
      child: Center(
        child: Text(
          '$label\n$value',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: kGreenSoft),
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
      height: 72,
      radius: 18,
      child: const Center(
        child: Text(
          '98% אמון',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: kGreenSoft),
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
      height: 72,
      radius: 16,
      child: Center(
        child: Text(
          'אמון\n97%',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: kGold),
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
      height: 72,
      radius: 16,
      child: Center(
        child: Text(
          'הכנסה\n₪1,280',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: kGreenSoft),
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
    this.radius = 18,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            const Color(0xFF07111D).withOpacity(.88),
            const Color(0xFF020711).withOpacity(.82),
          ],
        ),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.white.withOpacity(.105), width: 1),
        boxShadow: [
          const BoxShadow(color: Colors.black45, blurRadius: 16, offset: Offset(0, 9)),
          BoxShadow(color: kGreen.withOpacity(.028), blurRadius: 22),
        ],
      ),
      child: child,
    );
  }
}


class NeonButton extends StatelessWidget {
  final String label;
  final bool compact;
  final VoidCallback? onTap;

  const NeonButton({
    required this.label,
    this.compact = false,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => DemoFeedback.byLabel(context, label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        height: compact ? 38 : 50,
        padding: EdgeInsets.symmetric(horizontal: compact ? 16 : 22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(colors: [Color(0xFF13C783), Color(0xFF5EEAB0)]),
          boxShadow: [
            BoxShadow(color: kGreen.withOpacity(.13), blurRadius: 22, offset: const Offset(0, 8)),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: const Color(0xFF03120B),
            fontSize: compact ? 14 : 17,
            fontWeight: FontWeight.w900,
          ),
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
        padding: const EdgeInsets.symmetric(horizontal: 14),
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
      radius: 16,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
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
      height: 46,
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
                margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 7),
                decoration: BoxDecoration(
                  color: active ? const Color(0xFF5EEAB0) : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      tabs[index].icon,
                      color: active ? const Color(0xFF03120B) : const Color(0xFFAEB8C3),
                      size: 18,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      tabs[index].label,
                      style: TextStyle(
                        color: active ? const Color(0xFF03120B) : const Color(0xFFAEB8C3),
                        fontWeight: FontWeight.w900,
                        fontSize: 11,
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



// ============================================================
// STUDIO SHELL V2 — premium product surface
// This shell intentionally overrides the old prototype screens.
// Old scenes remain in file as archive/reference.
// ============================================================

class StudioHome extends StatefulWidget {
  const StudioHome({super.key});

  @override
  State<StudioHome> createState() => _StudioHomeState();
}

class _StudioHomeState extends State<StudioHome> {
  int selected = 3;
  VisualMode mode = VisualMode.night;

  final tabs = const [
    AppTab('ניהול', Icons.grid_view_rounded),
    AppTab('נהג', Icons.local_taxi_rounded),
    AppTab('מרחב', Icons.hub_rounded),
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
            PremiumAssetBackground(mode: mode, fallback: StudioBackdrop(mode: mode)),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
                child: Column(
                  children: [
                    StudioTopBar(
                      mode: mode,
                      onCall: () => setState(() => selected = 3),
                      onMode: () => setState(() {
                        mode = mode == VisualMode.night ? VisualMode.day : VisualMode.night;
                      }),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 220),
                        switchInCurve: Curves.easeOutCubic,
                        switchOutCurve: Curves.easeInCubic,
                        child: StudioScene(
                          key: ValueKey('$selected-$mode'),
                          selected: selected,
                          mode: mode,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    StudioBottomNav(
                      tabs: tabs,
                      selected: selected,
                      onSelect: (v) => setState(() => selected = v),
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

class StudioBackdrop extends StatelessWidget {
  final VisualMode mode;

  const StudioBackdrop({required this.mode, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: StudioBackdropPainter(mode),
      child: const SizedBox.expand(),
    );
  }
}

class StudioBackdropPainter extends CustomPainter {
  final VisualMode mode;

  const StudioBackdropPainter(this.mode);

  bool get isDay => mode == VisualMode.day;

  @override
  void paint(Canvas canvas, Size size) {
    final base = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: isDay
            ? const [
                Color(0xFFEFFAF7),
                Color(0xFFDDEDEA),
                Color(0xFFBFD6D8),
                Color(0xFF0B1724),
              ]
            : const [
                Color(0xFF020611),
                Color(0xFF07111D),
                Color(0xFF08131C),
                Color(0xFF000000),
              ],
      ).createShader(Offset.zero & size);

    canvas.drawRect(Offset.zero & size, base);

    _radial(canvas, size, Offset(.50, .10), isDay ? kGreen.withOpacity(.10) : kGreen.withOpacity(.09), size.width * .82);
    _radial(canvas, size, Offset(.10, .58), const Color(0xFF38BDF8).withOpacity(isDay ? .08 : .13), size.width * .68);
    _radial(canvas, size, Offset(.86, .40), kGold.withOpacity(isDay ? .08 : .10), size.width * .48);

    _drawPrecisionGrid(canvas, size);
    _drawSignalLines(canvas, size);
    _drawSkyline(canvas, size);
    _drawVignette(canvas, size);
  }

  void _radial(Canvas canvas, Size size, Offset unit, Color color, double radius) {
    final center = Offset(size.width * unit.dx, size.height * unit.dy);
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [color, Colors.transparent],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, paint);
  }

  void _drawPrecisionGrid(Canvas canvas, Size size) {
    final grid = Paint()
      ..color = Colors.white.withOpacity(isDay ? .045 : .038)
      ..strokeWidth = .8;

    for (double x = 0; x < size.width; x += 42) {
      canvas.drawLine(Offset(x, 0), Offset(x + size.width * .08, size.height), grid);
    }

    for (double y = 0; y < size.height; y += 42) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
  }

  void _drawSignalLines(Canvas canvas, Size size) {
    final soft = Paint()
      ..color = kGreenSoft.withOpacity(isDay ? .10 : .14)
      ..strokeWidth = 1.1
      ..strokeCap = StrokeCap.round;

    final glow = Paint()
      ..color = kGreen.withOpacity(isDay ? .05 : .08)
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);

    final paths = [
      [Offset(.04, .70), Offset(.28, .58), Offset(.55, .62), Offset(.94, .48)],
      [Offset(.15, .30), Offset(.40, .42), Offset(.73, .32), Offset(.96, .36)],
      [Offset(.08, .52), Offset(.31, .48), Offset(.58, .38), Offset(.88, .24)],
    ];

    for (final pts in paths) {
      final path = Path()..moveTo(size.width * pts.first.dx, size.height * pts.first.dy);
      for (var i = 1; i < pts.length; i++) {
        path.lineTo(size.width * pts[i].dx, size.height * pts[i].dy);
      }
      canvas.drawPath(path, glow);
      canvas.drawPath(path, soft);
    }

    final nodes = [Offset(.26, .58), Offset(.55, .62), Offset(.72, .32), Offset(.88, .24)];
    for (final n in nodes) {
      final o = Offset(size.width * n.dx, size.height * n.dy);
      canvas.drawCircle(o, 11, Paint()..color = kGreen.withOpacity(.10));
      canvas.drawCircle(o, 2.4, Paint()..color = kGreenSoft.withOpacity(.78));
    }
  }

  void _drawSkyline(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = (isDay ? const Color(0xFF102736) : const Color(0xFF020712)).withOpacity(isDay ? .42 : .78);

    final light = Paint()
      ..color = (isDay ? Colors.white : kGold).withOpacity(isDay ? .16 : .28);

    final heights = [42, 82, 54, 132, 66, 156, 92, 48, 118, 78, 56, 144, 72, 104];
    final w = size.width / heights.length;

    for (var i = 0; i < heights.length; i++) {
      final h = heights[i].toDouble();
      final rect = Rect.fromLTWH(i * w + 2, size.height - h, w - 5, h);
      canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(3)), paint);

      if (i.isEven) {
        canvas.drawCircle(Offset(rect.center.dx, rect.top + 18), 1.4, light);
      }
    }
  }

  void _drawVignette(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, -0.12),
        radius: 1.10,
        colors: [
          Colors.transparent,
          Colors.black.withOpacity(isDay ? .18 : .42),
          Colors.black.withOpacity(isDay ? .42 : .78),
        ],
        stops: const [.0, .62, 1],
      ).createShader(Offset.zero & size);

    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant StudioBackdropPainter oldDelegate) => oldDelegate.mode != mode;
}

class StudioTopBar extends StatelessWidget {
  final VisualMode mode;
  final VoidCallback onCall;
  final VoidCallback onMode;

  const StudioTopBar({
    required this.mode,
    required this.onCall,
    required this.onMode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StudioPanel(
      radius: 18,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          const StudioBrand(),
          const Spacer(),
          StudioIconButton(
            icon: mode == VisualMode.night ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
            onTap: onMode,
            gold: mode == VisualMode.day,
          ),
          const SizedBox(width: 8),
          StudioActionButton(label: 'פתח קריאה', onTap: onCall),
        ],
      ),
    );
  }
}

class StudioBrand extends StatelessWidget {
  const StudioBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text.rich(
      TextSpan(
        children: [
          TextSpan(text: 'קו ', style: TextStyle(color: Color(0xFFEAF2F5))),
          TextSpan(text: 'פתוח', style: TextStyle(color: kGreenSoft)),
        ],
      ),
      style: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.w900,
        letterSpacing: -.2,
      ),
    );
  }
}

class StudioIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool gold;

  const StudioIconButton({
    required this.icon,
    required this.onTap,
    this.gold = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final c = gold ? kGold : kGreenSoft;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.018),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: c.withOpacity(.28)),
          boxShadow: [
            BoxShadow(color: c.withOpacity(.08), blurRadius: 18),
          ],
        ),
        child: Icon(icon, color: c, size: 18),
      ),
    );
  }
}

class StudioScene extends StatelessWidget {
  final int selected;
  final VisualMode mode;

  const StudioScene({
    required this.selected,
    required this.mode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final spec = switch (selected) {
      0 => const StudioSpec(
          eyebrow: 'Command Center',
          title: 'לוח בקרה',
          subtitle: 'קריאות, נהגים, דיווחים ואמון בזמן אמת.',
          icon: Icons.grid_view_rounded,
        ),
      1 => const StudioSpec(
          eyebrow: 'נהג פעיל',
          title: 'אני על הקו',
          subtitle: 'קריאות באזור, הכנסה, אמון וזמינות.',
          icon: Icons.local_taxi_rounded,
        ),
      2 => const StudioSpec(
          eyebrow: 'מרחב נהגים',
          title: 'אזור חי',
          subtitle: 'אזורי פעילות, נהגים זמינים וקריאות חדשות.',
          icon: Icons.hub_rounded,
        ),
      3 => const StudioSpec(
          eyebrow: 'לקוח',
          title: 'לאן נוסעים?',
          subtitle: 'פתיחת קריאה מהירה, ברורה ומאומתת.',
          icon: Icons.person_rounded,
        ),
      _ => const StudioSpec(
          eyebrow: 'בטוח ומאומת',
          title: 'שכבת אמון',
          subtitle: 'אימות נהגים, דירוגים, מסמכים ושירות אנושי.',
          icon: Icons.verified_user_rounded,
        ),
    };

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                StudioHero(spec: spec),
                const SizedBox(height: 10),
                StudioPanel(
                  radius: 22,
                  padding: const EdgeInsets.all(14),
                  child: _contentFor(selected),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _contentFor(int selected) {
    return switch (selected) {
      0 => const StudioAdminContent(),
      1 => const StudioDriverContent(),
      2 => const StudioZoneContent(),
      3 => const StudioCustomerContent(),
      _ => const StudioTrustContent(),
    };
  }
}

class StudioSpec {
  final String eyebrow;
  final String title;
  final String subtitle;
  final IconData icon;

  const StudioSpec({
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

class StudioHero extends StatelessWidget {
  final StudioSpec spec;

  const StudioHero({required this.spec, super.key});

  @override
  Widget build(BuildContext context) {
    return StudioPanel(
      radius: 20,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: kGreen.withOpacity(.10),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: kGreenSoft.withOpacity(.22)),
            ),
            child: Icon(spec.icon, color: kGreenSoft, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  spec.eyebrow,
                  style: const TextStyle(
                    color: kGreenSoft,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  spec.title,
                  style: const TextStyle(
                    color: Color(0xFFF2F6F8),
                    fontSize: 24,
                    height: 1.05,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -.3,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  spec.subtitle,
                  style: const TextStyle(
                    color: Color(0xFFAEB8C3),
                    fontSize: 13,
                    height: 1.35,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StudioCustomerContent extends StatelessWidget {
  const StudioCustomerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        StudioField(icon: Icons.my_location_rounded, label: 'מאיפה אוספים אותך?'),
        SizedBox(height: 8),
        StudioField(icon: Icons.location_on_rounded, label: 'יעד הנסיעה'),
        SizedBox(height: 10),
        StudioSegment(),
        SizedBox(height: 12),
        SizedBox(height: 178, child: StudioRouteMap()),
        SizedBox(height: 12),
        StudioActionButton(label: 'פתח קריאה', full: true),
        SizedBox(height: 10),
        StudioTrustLine(),
      ],
    );
  }
}

class StudioDriverContent extends StatelessWidget {
  const StudioDriverContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        StudioLiveSwitch(),
        SizedBox(height: 12),
        SizedBox(height: 190, child: StudioRouteMap(driverMode: true)),
        SizedBox(height: 12),
        StudioStatsRow(items: [
          StudioMetric('₪740', 'היום', Icons.payments_rounded, kGreenSoft),
          StudioMetric('98%', 'אמון', Icons.verified_user_rounded, kGold),
          StudioMetric('12', 'קריאות', Icons.radio_button_checked_rounded, kGreenSoft),
        ]),
        SizedBox(height: 10),
        StudioCallRow(title: 'קריאה קרובה', meta: 'בני ברק · 4 דק׳', value: '₪68'),
        SizedBox(height: 8),
        StudioCallRow(title: 'קריאה משתלמת', meta: 'רמת גן · 9 דק׳', value: '₪240'),
      ],
    );
  }
}

class StudioZoneContent extends StatelessWidget {
  const StudioZoneContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 236, child: StudioZoneMap()),
        SizedBox(height: 12),
        StudioStatsRow(items: [
          StudioMetric('86', 'נהגים', Icons.local_taxi_rounded, kGreenSoft),
          StudioMetric('24', 'קריאות', Icons.radio_button_checked_rounded, kGreenSoft),
          StudioMetric('חם', 'אזור', Icons.local_fire_department_rounded, kGold),
        ]),
        SizedBox(height: 10),
        StudioCallRow(title: 'קריאה חדשה', meta: 'בני ברק · 4 דק׳', value: 'פתוחה'),
      ],
    );
  }
}

class StudioAdminContent extends StatelessWidget {
  const StudioAdminContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        StudioStatsRow(items: [
          StudioMetric('248', 'קריאות', Icons.radio_button_checked_rounded, kGreenSoft),
          StudioMetric('1,458', 'נהגים', Icons.local_taxi_rounded, kGreenSoft),
          StudioMetric('98%', 'אמון', Icons.verified_user_rounded, kGold),
        ]),
        SizedBox(height: 12),
        SizedBox(height: 168, child: StudioAdminChart()),
        SizedBox(height: 10),
        StudioCallRow(title: 'נהג לאישור', meta: 'רפי כהן', value: 'בדיקה'),
        SizedBox(height: 8),
        StudioCallRow(title: 'דיווח לבדיקה', meta: 'נסיעה חריגה', value: 'פתוח'),
      ],
    );
  }
}

class StudioTrustContent extends StatelessWidget {
  const StudioTrustContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        StudioTrustSeal(),
        SizedBox(height: 12),
        StudioStatsRow(items: [
          StudioMetric('98%', 'מדד אמון', Icons.verified_user_rounded, kGold),
          StudioMetric('+247', 'נסיעות', Icons.local_taxi_rounded, kGreenSoft),
          StudioMetric('4.9', 'דירוג', Icons.star_rounded, kGold),
        ]),
        SizedBox(height: 10),
        StudioCallRow(title: 'מסמכים נבדקו', meta: 'רישיון · ביטוח · תוקף', value: 'מאומת'),
        SizedBox(height: 8),
        StudioCallRow(title: 'שירות אנושי', meta: 'זמין לקריאות חריגות', value: 'פעיל'),
      ],
    );
  }
}

class StudioPanel extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;

  const StudioPanel({
    required this.child,
    this.padding = EdgeInsets.zero,
    this.radius = 18,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            const Color(0xFF0A1520).withOpacity(.86),
            const Color(0xFF030911).withOpacity(.78),
          ],
        ),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.white.withOpacity(.105), width: 1),
        boxShadow: [
          const BoxShadow(
            color: Color(0x99000000),
            blurRadius: 26,
            offset: Offset(0, 14),
          ),
          BoxShadow(
            color: kGreen.withOpacity(.025),
            blurRadius: 22,
          ),
        ],
      ),
      child: child,
    );
  }
}

class StudioActionButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool full;

  const StudioActionButton({
    required this.label,
    this.onTap,
    this.full = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final button = GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF13C783),
              Color(0xFF5EEAB0),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: kGreen.withOpacity(.14), blurRadius: 16, offset: const Offset(0, 6)),
          ],
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF03120B),
            fontSize: 14,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );

    return full ? SizedBox(width: double.infinity, child: button) : button;
  }
}

class StudioField extends StatelessWidget {
  final IconData icon;
  final String label;

  const StudioField({
    required this.icon,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StudioPanel(
      radius: 14,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: kGreenSoft, size: 18),
          const SizedBox(width: 9),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFFEAF2F5),
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class StudioSegment extends StatelessWidget {
  const StudioSegment({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: StudioSegmentItem(label: 'עכשיו', active: true)),
        SizedBox(width: 8),
        Expanded(child: StudioSegmentItem(label: 'מאוחר יותר', active: false)),
      ],
    );
  }
}

class StudioSegmentItem extends StatelessWidget {
  final String label;
  final bool active;

  const StudioSegmentItem({
    required this.label,
    required this.active,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? kGreen.withOpacity(.13) : Colors.black.withOpacity(.16),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: active ? kGreenSoft.withOpacity(.55) : Colors.white.withOpacity(.08)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: active ? Colors.white : const Color(0xFF9CA8B3),
          fontSize: 14,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class StudioLiveSwitch extends StatelessWidget {
  const StudioLiveSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF19D98B), Color(0xFF6EF2BD)],
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: kGreen.withOpacity(.11), blurRadius: 24, offset: const Offset(0, 8)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFF03120B).withOpacity(.90),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.sensors_rounded, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 10),
          const Text(
            'אני על הקו',
            style: TextStyle(
              color: Color(0xFF03120B),
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class StudioStatsRow extends StatelessWidget {
  final List<StudioMetric> items;

  const StudioStatsRow({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          Expanded(child: StudioMetricTile(item: items[i])),
          if (i < items.length - 1) const SizedBox(width: 8),
        ],
      ],
    );
  }
}

class StudioMetric {
  final String value;
  final String label;
  final IconData icon;
  final Color accent;

  const StudioMetric(this.value, this.label, this.icon, this.accent);
}

class StudioMetricTile extends StatelessWidget {
  final StudioMetric item;

  const StudioMetricTile({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return StudioPanel(
      radius: 14,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Icon(item.icon, color: item.accent, size: 17),
          const SizedBox(height: 5),
          Text(
            item.value,
            style: TextStyle(
              color: item.accent,
              fontSize: 18,
              height: 1,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.label,
            style: const TextStyle(
              color: Color(0xFF9CA8B3),
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class StudioCallRow extends StatelessWidget {
  final String title;
  final String meta;
  final String value;

  const StudioCallRow({
    required this.title,
    required this.meta,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StudioPanel(
      radius: 14,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          const Icon(Icons.radio_button_checked_rounded, color: kGreenSoft, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900)),
                const SizedBox(height: 2),
                Text(meta, style: const TextStyle(fontSize: 11, color: Color(0xFF93A0AD), fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: kGold,
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class StudioTrustLine extends StatelessWidget {
  const StudioTrustLine({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.verified_user_rounded, color: kGold, size: 16),
        SizedBox(width: 6),
        Text(
          'נהגים נבחרים · ביטוח מלא · דירוגים אמיתיים',
          style: TextStyle(
            color: Color(0xFFAEB8C3),
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class StudioTrustSeal extends StatelessWidget {
  const StudioTrustSeal({super.key});

  @override
  Widget build(BuildContext context) {
    return StudioPanel(
      radius: 18,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kGold.withOpacity(.075),
              border: Border.all(color: kGold.withOpacity(.38)),
              boxShadow: [
                BoxShadow(color: kGold.withOpacity(.12), blurRadius: 34),
              ],
            ),
            child: const Icon(Icons.verified_user_rounded, color: kGold, size: 38),
          ),
          const SizedBox(height: 10),
          const Text('מדד אמון 98%', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          const Text(
            'אימות, מסמכים, דירוג ושירות אנושי.',
            style: TextStyle(color: Color(0xFFAEB8C3), fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class StudioRouteMap extends StatelessWidget {
  final bool driverMode;

  const StudioRouteMap({this.driverMode = false, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: PremiumMapSurface(
        child: CustomPaint(
          painter: StudioMapPainter(driverMode: driverMode),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class StudioMapPainter extends CustomPainter {
  final bool driverMode;

  const StudioMapPainter({required this.driverMode});

  @override
  void paint(Canvas canvas, Size size) {
    _base(canvas, size);
    _roads(canvas, size);
    _route(canvas, size);
    _pin(canvas, size, Offset(.18, .62), kGreenSoft);
    _pin(canvas, size, Offset(.78, .30), kGreenSoft);
    _pin(canvas, size, Offset(.52, .52), driverMode ? kGold : kGreenSoft);
    _label(canvas, 'קריאה פתוחה', Offset(size.width * .56, size.height * .20), kGreenSoft);
    _label(canvas, '4 דק׳', Offset(size.width * .47, size.height * .56), Colors.white);
  }

  void _base(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFF03101A), Color(0xFF071B1F), Color(0xFF030811)],
        ).createShader(Offset.zero & size),
    );

    final glow = Paint()
      ..shader = RadialGradient(
        colors: [kGreen.withOpacity(.10), Colors.transparent],
      ).createShader(Rect.fromCircle(center: Offset(size.width * .54, size.height * .52), radius: size.width * .45));

    canvas.drawCircle(Offset(size.width * .54, size.height * .52), size.width * .45, glow);
  }

  void _roads(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(.010)
      ..strokeWidth = .8;

    for (double x = 0; x < size.width; x += 34) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 34) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    final road = Paint()
      ..color = kGreenSoft.withOpacity(.10)
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < 5; i++) {
      final y = size.height * (.20 + i * .15);
      final path = Path()
        ..moveTo(size.width * .08, y)
        ..quadraticBezierTo(size.width * .44, y + 26, size.width * .92, y - 10);
      canvas.drawPath(path, road);
    }
  }

  void _route(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width * .16, size.height * .70)
      ..cubicTo(size.width * .36, size.height * .57, size.width * .56, size.height * .38, size.width * .82, size.height * .28);

    canvas.drawPath(
      path,
      Paint()
        ..color = kGreen.withOpacity(.09)
        ..strokeWidth = 14
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16),
    );

    canvas.drawPath(
      path,
      Paint()
        ..color = kGreenSoft.withOpacity(.74)
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  void _pin(Canvas canvas, Size size, Offset unit, Color color) {
    final p = Offset(size.width * unit.dx, size.height * unit.dy);
    canvas.drawCircle(
      p,
      18,
      Paint()
        ..color = color.withOpacity(.16)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16),
    );
    canvas.drawCircle(p, 6, Paint()..color = color);
  }

  void _label(Canvas canvas, String text, Offset pos, Color color) {
    final tp = TextPainter(
      textDirection: TextDirection.rtl,
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w900),
      ),
    )..layout();

    final r = Rect.fromLTWH(pos.dx - tp.width - 14, pos.dy - 13, tp.width + 28, 26);
    canvas.drawRRect(RRect.fromRectAndRadius(r, const Radius.circular(10)), Paint()..color = Colors.black.withOpacity(.70));
    tp.paint(canvas, Offset(r.left + 14, r.top + 7));
  }

  @override
  bool shouldRepaint(covariant StudioMapPainter oldDelegate) => oldDelegate.driverMode != driverMode;
}

class StudioZoneMap extends StatelessWidget {
  const StudioZoneMap({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: PremiumMapSurface(
        child: CustomPaint(
          painter: StudioZonePainter(),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class StudioZonePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = const Color(0xFF03101A));

    final grid = Paint()
      ..color = Colors.white.withOpacity(.05)
      ..strokeWidth = .8;

    for (double x = 0; x < size.width; x += 34) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += 34) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final zone = Path()
      ..moveTo(size.width * .20, size.height * .25)
      ..quadraticBezierTo(size.width * .58, size.height * .05, size.width * .82, size.height * .36)
      ..quadraticBezierTo(size.width * .74, size.height * .78, size.width * .28, size.height * .82)
      ..quadraticBezierTo(size.width * .08, size.height * .56, size.width * .20, size.height * .25);

    canvas.drawPath(zone, Paint()..color = kGreen.withOpacity(.08));
    canvas.drawPath(
      zone,
      Paint()
        ..color = kGreenSoft.withOpacity(.46)
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke,
    );

    _dot(canvas, size, Offset(.28, .36), 'אבי', kGreenSoft);
    _dot(canvas, size, Offset(.64, .30), 'רפי', kGreenSoft);
    _dot(canvas, size, Offset(.73, .62), 'משה', kGreenSoft);
    _dot(canvas, size, Offset(.42, .74), 'יוסי', kGreenSoft);
    _dot(canvas, size, Offset(.50, .50), 'קריאה', kGold);
  }

  void _dot(Canvas canvas, Size size, Offset unit, String label, Color color) {
    final p = Offset(size.width * unit.dx, size.height * unit.dy);
    canvas.drawCircle(p, 16, Paint()..color = color.withOpacity(.12));
    canvas.drawCircle(p, 6, Paint()..color = color);

    final tp = TextPainter(
      textDirection: TextDirection.rtl,
      text: TextSpan(text: label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w900)),
    )..layout();

    tp.paint(canvas, p.translate(10, -18));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class StudioAdminChart extends StatelessWidget {
  const StudioAdminChart({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: CustomPaint(
        painter: StudioAdminChartPainter(),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class StudioAdminChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = const Color(0xFF03101A));

    final bars = [.40, .56, .46, .72, .62, .82, .66, .90];
    final bw = size.width / 18;

    for (var i = 0; i < bars.length; i++) {
      final h = size.height * bars[i] * .64;
      final x = size.width * .12 + i * bw * 1.75;
      final y = size.height - h - 22;
      final rect = RRect.fromRectAndRadius(Rect.fromLTWH(x, y, bw, h), const Radius.circular(8));
      canvas.drawRRect(rect, Paint()..color = kGreenSoft.withOpacity(.70));
    }

    final tp = TextPainter(
      textDirection: TextDirection.rtl,
      text: const TextSpan(
        text: 'פעילות היום',
        style: TextStyle(color: kGreenSoft, fontSize: 12, fontWeight: FontWeight.w900),
      ),
    )..layout();

    tp.paint(canvas, Offset(size.width - tp.width - 14, 12));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class StudioBottomNav extends StatelessWidget {
  final List<AppTab> tabs;
  final int selected;
  final ValueChanged<int> onSelect;

  const StudioBottomNav({
    required this.tabs,
    required this.selected,
    required this.onSelect,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StudioPanel(
      radius: 18,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      child: Row(
        children: List.generate(tabs.length, (i) {
          final active = i == selected;
          return Expanded(
            child: GestureDetector(
              onTap: () => onSelect(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: 46,
                decoration: BoxDecoration(
                  color: active ? const Color(0xFF5EEAB0) : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      tabs[i].icon,
                      color: active ? const Color(0xFF03120B) : const Color(0xFFAEB8C3),
                      size: 18,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      tabs[i].label,
                      style: TextStyle(
                        color: active ? const Color(0xFF03120B) : const Color(0xFFAEB8C3),
                        fontSize: 10.5,
                        fontWeight: FontWeight.w900,
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
