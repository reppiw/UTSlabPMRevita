import 'package:flutter/material.dart';

/// Satu set warna lengkap. Buat palet baru dengan menyalin salah satu.
class AppPalette {
  final Color primary;       // warna utama (tombol, progress)
  final Color primaryShadow; // versi lebih gelap (sisi bawah tombol)
  final Color onPrimary;     // teks di atas warna utama
  final Color selectedFill;  // latar pilihan yang dipilih
  final Color background;    // latar halaman
  final Color surface;       // latar kartu/pilihan
  final Color border;        // garis tepi & sisi bawah kartu
  final Color textDark;
  final Color textMuted;
  final Color disabled;
  final Color disabledText;

  const AppPalette({
    required this.primary,
    required this.primaryShadow,
    required this.onPrimary,
    required this.selectedFill,
    required this.background,
    required this.surface,
    required this.border,
    required this.textDark,
    required this.textMuted,
    required this.disabled,
    required this.disabledText,
  });

  // ---------- PALET SIAP PAKAI ----------
  static const green = AppPalette(
    primary: Color(0xFF58CC02),
    primaryShadow: Color(0xFF58A700),
    onPrimary: Colors.white,
    selectedFill: Color(0xFFE5F6D3),
    background: Colors.white,
    surface: Colors.white,
    border: Color(0xFFE5E5E5),
    textDark: Color(0xFF4B4B4B),
    textMuted: Color(0xFFAFAFAF),
    disabled: Color(0xFFE5E5E5),
    disabledText: Color(0xFFAFAFAF),
  );

  static const blue = AppPalette(
    primary: Color(0xFF1CB0F6),
    primaryShadow: Color(0xFF1899D6),
    onPrimary: Colors.white,
    selectedFill: Color(0xFFDDF4FF),
    background: Colors.white,
    surface: Colors.white,
    border: Color(0xFFE5E5E5),
    textDark: Color(0xFF4B4B4B),
    textMuted: Color(0xFFAFAFAF),
    disabled: Color(0xFFE5E5E5),
    disabledText: Color(0xFFAFAFAF),
  );

  static const purple = AppPalette(
    primary: Color(0xFFCE82FF),
    primaryShadow: Color(0xFFA568CC),
    onPrimary: Colors.white,
    selectedFill: Color(0xFFF3E3FF),
    background: Colors.white,
    surface: Colors.white,
    border: Color(0xFFE5E5E5),
    textDark: Color(0xFF4B4B4B),
    textMuted: Color(0xFFAFAFAF),
    disabled: Color(0xFFE5E5E5),
    disabledText: Color(0xFFAFAFAF),
  );

  static const orange = AppPalette(
    primary: Color(0xFFFF9600),
    primaryShadow: Color(0xFFCC7800),
    onPrimary: Colors.white,
    selectedFill: Color(0xFFFFEFD6),
    background: Colors.white,
    surface: Colors.white,
    border: Color(0xFFE5E5E5),
    textDark: Color(0xFF4B4B4B),
    textMuted: Color(0xFFAFAFAF),
    disabled: Color(0xFFE5E5E5),
    disabledText: Color(0xFFAFAFAF),
  );

  static const pastel = AppPalette(
    primary: Color(0xFFB8A9F5),
    primaryShadow: Color(0xFF8F7FD1),
    onPrimary: Color(0xFF3B2F7A),
    selectedFill: Color(0xFFE4DEFF),
    background: Color(0xFFF8F5FF),
    surface: Colors.white,
    border: Color(0xFFD9D2F5),
    textDark: Color(0xFF3B2F7A),
    textMuted: Color(0xFF9A93C0),
    disabled: Color(0xFFE9E6F2),
    disabledText: Color(0xFFB5B0CC),
  );
}

class AppColors {
  // >>> GANTI PALET DI SINI: green, blue, purple, orange, pastel <<<
  static const AppPalette active = AppPalette.green;

  static Color get primary => active.primary;
  static Color get primaryShadow => active.primaryShadow;
  static Color get onPrimary => active.onPrimary;
  static Color get selectedFill => active.selectedFill;
  static Color get background => active.background;
  static Color get surface => active.surface;
  static Color get border => active.border;
  static Color get textDark => active.textDark;
  static Color get textMuted => active.textMuted;
  static Color get disabled => active.disabled;
  static Color get disabledText => active.disabledText;
}