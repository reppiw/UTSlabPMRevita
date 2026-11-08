import 'package:flutter/material.dart';
import '../data/data_dummy.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';
import 'primary_button.dart';

class DifficultyDialog extends StatefulWidget {
  final String categoryId;
  final String categoryName;
  final int initialValue;

  const DifficultyDialog({
    super.key,
    required this.categoryId,
    required this.categoryName,
    this.initialValue = 3,
  });

  /// Hasilnya angka 1-5, atau null jika dibatalkan.
  static Future<int?> show(
    BuildContext context, {
    required String categoryId,
    required String categoryName,
    int initialValue = 3,
  }) {
    return showDialog<int>(
      context: context,
      builder: (_) => DifficultyDialog(
        categoryId: categoryId,
        categoryName: categoryName,
        initialValue: initialValue,
      ),
    );
  }

  @override
  State<DifficultyDialog> createState() => _DifficultyDialogState();
}

class _DifficultyDialogState extends State<DifficultyDialog> {
  static const _levelNames = [
    'Sangat mudah',
    'Mudah',
    'Sedang',
    'Sulit',
    'Sangat sulit',
  ];

  late int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue.clamp(1, 5);
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final dialogWidth = r.isLandscape ? r.w(60) : r.w(88);
    final totalQuestions = questionsFor(widget.categoryId, _value).length;

    return Dialog(
      backgroundColor: AppColors.surface,
      insetPadding: EdgeInsets.symmetric(
        horizontal: r.w(6),
        vertical: r.h(3),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(r.sp(5)),
      ),
      child: SizedBox(
        width: dialogWidth,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(r.sp(5)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Tingkat Kesulitan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: r.sp(5.5),
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: r.h(0.8)),
              Text(
                widget.categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: r.sp(3.6),
                  color: AppColors.textMuted,
                ),
              ),
              SizedBox(height: r.h(3)),

              // Angka level besar
              Text(
                '$_value',
                style: TextStyle(
                  fontSize: r.sp(16),
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              Text(
                _levelNames[_value - 1],
                style: TextStyle(
                  fontSize: r.sp(4.5),
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              SizedBox(height: r.h(2)),

              // Slider 1 - 5
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: r.sp(2.5),
                  activeTrackColor: AppColors.primary,
                  inactiveTrackColor: AppColors.border,
                  thumbColor: AppColors.primary,
                  overlayColor: AppColors.selectedFill,
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: r.sp(3.5),
                  ),
                  overlayShape: RoundSliderOverlayShape(
                    overlayRadius: r.sp(6),
                  ),
                  trackShape: const RoundedRectSliderTrackShape(),
                  tickMarkShape: SliderTickMarkShape.noTickMark,
                ),
                child: Slider(
                  value: _value.toDouble(),
                  min: 1,
                  max: 5,
                  divisions: 4,
                  onChanged: (v) => setState(() => _value = v.round()),
                ),
              ),

              // Angka 1 - 5 di bawah slider
              Padding(
                padding: EdgeInsets.symmetric(horizontal: r.sp(3)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 1; i <= 5; i++)
                      Text(
                        '$i',
                        style: TextStyle(
                          fontSize: r.sp(3.6),
                          fontWeight: FontWeight.w700,
                          color: i == _value
                              ? AppColors.primary
                              : AppColors.textMuted,
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: r.h(2)),

              Text(
                '$totalQuestions soal',
                style: TextStyle(
                  fontSize: r.sp(3.8),
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryShadow,
                ),
              ),
              SizedBox(height: r.h(2.5)),

              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      label: 'Batal',
                      outlined: true,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(width: r.w(3)),
                  Expanded(
                    child: PrimaryButton(
                      label: 'Mulai',
                      onPressed: () => Navigator.pop(context, _value),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}