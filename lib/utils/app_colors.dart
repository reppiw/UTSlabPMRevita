import 'package:flutter/material.dart';

class AccentColor {
  final Color main;
  final Color shadow;
  final Color lightSoft;

  const AccentColor({
    required this.main,
    required this.shadow,
    required this.lightSoft,
  });

  factory AccentColor.fromMain(Color main) {
    final hsl = HSLColor.fromColor(main);
    final shadowLightness = (hsl.lightness - 0.14).clamp(0.0, 1.0);
    return AccentColor(
      main: main,
      shadow: hsl.withLightness(shadowLightness).toColor(),
      lightSoft: hsl.withLightness(0.92).toColor(),
    );
  }

  Color get soft => AppColors.isDark
      ? Color.lerp(AppColors.surface, main, 0.22)!
      : lightSoft;

  Color get text => AppColors.isDark ? main : shadow;
}

class AppPalette {
  final String name;
  final Color primary;
  final AccentColor primaryAccent;
  final List<AccentColor> accents; // 5 warna pendamping

  AppPalette({
    required this.name,
    required this.primary,
    required List<Color> colors,
  })  : primaryAccent = AccentColor.fromMain(primary),
        accents = colors.map(AccentColor.fromMain).toList();

  // ---------- TEMA ----------
  static final original = AppPalette(
    name: 'Original',
    primary: const Color(0xFF7C5CFF), // ungu cerah
    colors: const [
      Color(0xFFFF5C7A), // 0 pink
      Color(0xFFFF9F1C), // 1 oranye
      Color(0xFFFFC800), // 2 kuning
      Color(0xFF2ECC71), // 3 hijau
      Color(0xFF3B9DFF), // 4 biru
    ],
  );

  static final ocean = AppPalette(
    name: 'Laut',
    primary: const Color(0xFF1CB0F6),
    colors: const [
      Color(0xFF0077B6),
      Color(0xFF00B4D8),
      Color(0xFF1CB0F6),
      Color(0xFF48CAE4),
      Color(0xFF2EC4B6),
    ],
  );

  static final forest = AppPalette(
    name: 'Hutan',
    primary: const Color(0xFF58CC02),
    colors: const [
      Color(0xFF2D6A4F),
      Color(0xFF40916C),
      Color(0xFF58CC02),
      Color(0xFF8AC926),
      Color(0xFF1B998B),
    ],
  );

  static final sunset = AppPalette(
    name: 'Senja',
    primary: const Color(0xFFF77F00),
    colors: const [
      Color(0xFFE63946),
      Color(0xFFF77F00),
      Color(0xFFE9A800),
      Color(0xFFFF5D8F),
      Color(0xFFB5179E),
    ],
  );

  static final candy = AppPalette(
    name: 'Permen',
    primary: const Color(0xFFFF4D8D),
    colors: const [
      Color(0xFFFF4D8D),
      Color(0xFFFF8FA3),
      Color(0xFFC77DFF),
      Color(0xFF5AB8E8),
      Color(0xFF4CC9A7),
    ],
  );

  static final List<AppPalette> all = [original, ocean, forest, sunset, candy];
}

class AppColors {
  static AppPalette active = AppPalette.original;
  static bool isDark = false;

  // ---------- Mengikuti TEMA ----------
  static Color get primary => active.primary;
  static Color get primaryShadow => active.primaryAccent.shadow;
  static Color get primaryText => active.primaryAccent.text;
  static Color get onPrimary => Colors.white;
  static Color get selectedFill => active.primaryAccent.soft;

  // ---------- Mengikuti MODE terang/gelap ----------
  static Color get background =>
      isDark ? const Color(0xFF120B1F) : Colors.white;
  static Color get surface =>
      isDark ? const Color(0xFF1E1530) : Colors.white;
  static Color get border =>
      isDark ? const Color(0xFF33264D) : const Color(0xFFE5E5E5);
  static Color get textDark =>
      isDark ? const Color(0xFFEDE7F7) : const Color(0xFF4B4B4B);
  static Color get textMuted =>
      isDark ? const Color(0xFF9C90B8) : const Color(0xFFAFAFAF);
  static Color get disabled =>
      isDark ? const Color(0xFF2A2040) : const Color(0xFFE5E5E5);
  static Color get disabledText =>
      isDark ? const Color(0xFF6B5F85) : const Color(0xFFAFAFAF);

  /// Warna aksen ke-[i]. Nomor di atas 4 kembali ke awal.
  static AccentColor accent(int i) => active.accents[i % active.accents.length];
}