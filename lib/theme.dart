import 'package:flutter/material.dart';

// Palet Dark Mode
const Color ink = Color(0xFF090D12);
const Color panel = Color(0xFF111820);
const Color panel2 = Color(0xFF17212B);
const Color gold = Color(0xFFFFCC35);
const Color muted = Color(0xFFABB5C1);

// Palet Soft Light Mode (nyaman di mata, tidak terlalu terang/silau)
const Color whiteBg = Color(0xFFF7F6F2);
const Color lightPanel = Color(0xFFEFEDE6);
const Color lightPanel2 = Color(0xFFFCFBF8);
const Color darkInk = Color(0xFF18202A);
const Color lightMuted = Color(0xFF5B6573);
const Color goldDarkText = Color(0xFF8F6200);

// Controller global untuk mengganti mode tema
final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier<ThemeMode>(
  ThemeMode.dark,
);

void toggleThemeMode() {
  themeModeNotifier.value =
      themeModeNotifier.value == ThemeMode.dark
          ? ThemeMode.light
          : ThemeMode.dark;
}

class AppColors {
  final bool isDark;

  const AppColors(this.isDark);

  factory AppColors.of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return AppColors(brightness == Brightness.dark);
  }

  Color get bg => isDark ? ink : whiteBg;
  Color get surface => isDark ? panel : lightPanel;
  Color get cardBg => isDark ? panel2 : lightPanel2;
  Color get textPrimary => isDark ? Colors.white : darkInk;
  Color get textSecondary => isDark ? muted : lightMuted;
  Color get accent => isDark ? gold : goldDarkText;
  Color get borderColor =>
      isDark ? gold.withValues(alpha: 0.16) : const Color(0xFFE1DDD2);
  Color get shadowColor =>
      isDark
          ? Colors.black.withValues(alpha: 0.3)
          : const Color(0xFF18202A).withValues(alpha: 0.06);
}

ThemeData buildAppTheme(Brightness brightness) {
  final isDark = brightness == Brightness.dark;
  final palette = AppColors(isDark);

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    scaffoldBackgroundColor: palette.bg,
    colorScheme: ColorScheme(
      brightness: brightness,
      primary: gold,
      onPrimary: ink,
      secondary: palette.accent,
      onSecondary: Colors.white,
      error: Colors.redAccent,
      onError: Colors.white,
      surface: palette.cardBg,
      onSurface: palette.textPrimary,
    ),
  );
}

// Helper section publik yang mengikuti mode aktif
Widget section({
  BuildContext? context,
  Color? background,
  required Widget child,
}) {
  final isDark = context != null
      ? Theme.of(context).brightness == Brightness.dark
      : themeModeNotifier.value == ThemeMode.dark;
  final palette = AppColors(isDark);

  Color resolvedBg = palette.bg;
  if (background != null) {
    if (!isDark && (background == panel || background == ink)) {
      resolvedBg = background == panel ? lightPanel : whiteBg;
    } else {
      resolvedBg = background;
    }
  }

  return AnimatedContainer(
    duration: const Duration(milliseconds: 220),
    color: resolvedBg,
    width: double.infinity,
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1180),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: child,
        ),
      ),
    ),
  );
}

// Helper card publik yang mengikuti mode aktif
Widget card(Widget child, {BuildContext? context}) {
  final isDark = context != null
      ? Theme.of(context).brightness == Brightness.dark
      : themeModeNotifier.value == ThemeMode.dark;
  final palette = AppColors(isDark);

  return AnimatedContainer(
    duration: const Duration(milliseconds: 220),
    padding: const EdgeInsets.all(22),
    decoration: BoxDecoration(
      color: palette.cardBg,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: palette.borderColor),
      boxShadow: [
        BoxShadow(
          color: palette.shadowColor,
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: child,
  );
}

class SectionTitle extends StatelessWidget {
  final IconData? icon;
  final String title;

  const SectionTitle({super.key, this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);

    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
        color: palette.textPrimary,
      ),
    );
  }
}

class MiniTag extends StatelessWidget {
  final String text;

  const MiniTag({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final palette = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: gold.withValues(alpha: palette.isDark ? 0.08 : 0.14),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: gold.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: palette.accent,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, mode, _) {
        final isDark = mode == ThemeMode.dark;
        final palette = AppColors(isDark);

        return IconButton(
          onPressed: toggleThemeMode,
          tooltip: isDark ? 'Mode Terang' : 'Mode Gelap',
          style: IconButton.styleFrom(
            backgroundColor: palette.cardBg,
            foregroundColor: palette.accent,
            side: BorderSide(color: palette.borderColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(10),
          ),
          icon: Icon(
            isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            size: 18,
            color: palette.accent,
          ),
        );
      },
    );
  }
}