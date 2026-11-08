import 'package:flutter/material.dart';

class ChunkyContainer extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap; // null = nonaktif
  final Color color;
  final Color shadowColor;
  final Color? borderColor;
  final double borderWidth;
  final double depth;  // tebal sisi bawah
  final double radius;
  final EdgeInsetsGeometry padding;
  final AlignmentGeometry alignment;

  const ChunkyContainer({
    super.key,
    required this.child,
    required this.onTap,
    required this.color,
    required this.shadowColor,
    required this.depth,
    required this.radius,
    required this.padding,
    this.borderColor,
    this.borderWidth = 0,
    this.alignment = Alignment.center,
  });

  @override
  State<ChunkyContainer> createState() => _ChunkyContainerState();
}

class _ChunkyContainerState extends State<ChunkyContainer> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onTap != null;
    // Saat ditekan, kotak turun sebesar depth. Tinggi total tetap sama.
    final dy = (_pressed && enabled) ? widget.depth : 0.0;
    final radius = BorderRadius.circular(widget.radius);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: enabled ? (_) => _setPressed(true) : null,
      onTapUp: enabled
          ? (_) {
              _setPressed(false);
              widget.onTap!();
            }
          : null,
      onTapCancel: enabled ? () => _setPressed(false) : null,
      child: Padding(
        padding: EdgeInsets.only(top: dy),
        child: Container(
          decoration: BoxDecoration(
            color: widget.shadowColor,
            borderRadius: radius,
          ),
          padding: EdgeInsets.only(bottom: widget.depth - dy),
          child: Container(
            alignment: widget.alignment,
            padding: widget.padding,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: radius,
              border: widget.borderColor == null
                  ? null
                  : Border.all(
                      color: widget.borderColor!,
                      width: widget.borderWidth,
                    ),
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}