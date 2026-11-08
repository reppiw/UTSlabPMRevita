import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class Responsive {
  final BuildContext context;

  Responsive(this.context){
    context.watch<ThemeProvider>();
  }

  Size get _size => MediaQuery.of(context).size;

  double get screenWidth => _size.width;
  double get screenHeight => _size.height;

  bool get isLandscape =>
    MediaQuery.of(context).orientation == Orientation.landscape;

  double w(double percent) => screenWidth * percent / 100;

  double h(double percent) => screenHeight * percent / 100;

  double sp(double percent) {
    final shortest = screenWidth < screenHeight ? screenWidth : screenHeight;
    return shortest * percent / 100;
  }
}