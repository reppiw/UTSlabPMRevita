import 'dart:math' as math;
import 'package:flutter/material.dart';

class BouncingText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final double jumpHeight;
  final Duration duration;

  const BouncingText({
    super.key,
    required this.text,
    required this.style,
    required this.jumpHeight,
    this.duration = const Duration(milliseconds: 1600),
  });

  @override
  State<BouncingText> createState() => _BouncingTextState();
}

class _BouncingTextState extends State<BouncingText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  // Bagian siklus yang dipakai satu huruf untuk satu lompatan.
  static const double _window = 0.22;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Tinggi lompatan huruf ke-[index], 0 saat tidak sedang melompat.
  double _offsetFor(int index, int count, double t) {
    final start = index * (1 - _window) / count;
    final local = (t - start) / _window;
    if (local < 0 || local > 1) return 0;
    return -math.sin(local * math.pi) * widget.jumpHeight;
  }

  @override
  Widget build(BuildContext context) {
    final letters = widget.text.split('');

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (int i = 0; i < letters.length; i++)
              Transform.translate(
                offset: Offset(
                  0,
                  _offsetFor(i, letters.length, _controller.value),
                ),
                child: Text(letters[i], style: widget.style),
              ),
          ],
        );
      },
    );
  }
}