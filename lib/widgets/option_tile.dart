import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class OptionTile extends StatelessWidget {
  final String label; // huruf opsi: A, B, C, D
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionTile({
    super.key,
    required this.label,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final primary = Theme.of(context).colorScheme.primary;

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(r.sp(3)),
    );
    final padding = EdgeInsets.symmetric(
      horizontal: r.sp(4),
      vertical: r.sp(3.5),
    );
    final textWidget = Text(
      '$label.  $text',
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: r.sp(4),
        fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
      ),
    );

    return Padding(
      padding: EdgeInsets.only(bottom: r.sp(2.5)),
      child: SizedBox(
        width: double.infinity,
        child: isSelected
            ? ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  foregroundColor: Colors.white,
                  alignment: Alignment.centerLeft,
                  shape: shape,
                  padding: padding,
                ),
                child: textWidget,
              )
            : OutlinedButton(
                onPressed: onTap,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black87,
                  backgroundColor: Colors.white,
                  alignment: Alignment.centerLeft,
                  side: BorderSide(
                    color: Colors.grey.shade400,
                    width: r.sp(0.4),
                  ),
                  shape: shape,
                  padding: padding,
                ),
                child: textWidget,
              ),
      ),
    );
  }
}