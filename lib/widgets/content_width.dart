import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class ContentWidth extends StatelessWidget {
  final Widget child;

  const ContentWidth({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: r.formWidth),
        child: child,
      ),
    );
  }
}