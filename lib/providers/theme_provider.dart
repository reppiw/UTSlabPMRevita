import 'package:flutter/foundation.dart';
import '../utils/app_colors.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    _apply();
  }

  int _themeIndex = 0; // 0 = Original
  bool _isDark = false;

  int get themeIndex => _themeIndex;
  bool get isDark => _isDark;
  AppPalette get palette => AppPalette.all[_themeIndex];

  void _apply() {
    AppColors.active = AppPalette.all[_themeIndex];
    AppColors.isDark = _isDark;
  }

  void setTheme(int index) {
    if (index == _themeIndex) return;
    _themeIndex = index;
    _apply();
    notifyListeners();
  }

  void setDark(bool value) {
    if (value == _isDark) return;
    _isDark = value;
    _apply();
    notifyListeners();
  }
}