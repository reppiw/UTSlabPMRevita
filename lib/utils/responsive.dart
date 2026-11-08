import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

/// Ini batas pengambilan keputusan layout, bukan ukuran elemen UI.
class Breakpoints {
  static const double compact = 600; // di bawah ini: HP
  static const double expanded = 900; // di atas ini: tablet landscape / web

  // Lebar maksimum konten di layar besar
  static const double maxPortraitContent = 640;
  static const double maxLandscapeContent = 1100;

  // Batas basis skala ukuran, agar font tidak raksasa di layar besar
  static const double scaleCap = 560;

  // Batas lebar untuk menentukan jumlah kolom daftar
  static const double twoColumns = 520;
  static const double threeColumns = 900;

  static int columnsFor(double width) {
    if (width >= threeColumns) return 3;
    if (width >= twoColumns) return 2;
    return 1;
  }
}

enum ScreenType { compact, medium, expanded }

class Responsive {
  final BuildContext context;

  Responsive(this.context) {
    context.watch<ThemeProvider>();
  }

  Size get _size => MediaQuery.of(context).size;

  double get screenWidth => _size.width;
  double get screenHeight => _size.height;

  /// Dihitung dari ukuran (bukan sensor orientasi), supaya sama
  /// dengan ukuran yang dibatasi oleh AdaptiveFrame di web dan tablet.
  bool get isLandscape => screenWidth > screenHeight;

  ScreenType get type {
    if (screenWidth < Breakpoints.compact) return ScreenType.compact;
    if (screenWidth < Breakpoints.expanded) return ScreenType.medium;
    return ScreenType.expanded;
  }

  bool get isCompact => type == ScreenType.compact;

  bool get useSideNav => isLandscape && screenWidth >= Breakpoints.compact;

  /// Lebar maksimum untuk form dan halaman bergaya daftar.
  double get formWidth => math.min(screenWidth, sp(110));

  double w(double percent) => screenWidth * percent / 100;

  double h(double percent) => screenHeight * percent / 100;

  double sp(double percent) {
    final shortest = math.min(
      math.min(screenWidth, screenHeight),
      Breakpoints.scaleCap,
    );
    return shortest * percent / 100;
  }
}