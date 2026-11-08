import 'package:flutter/material.dart';
import '../data/data_dummy.dart';
import '../models/quiz_mode.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';
import 'primary_button.dart';
import 'quiz_mode_picker.dart';

typedef QuizSetup = ({int difficulty, QuizMode mode});

class DifficultyDialog extends StatefulWidget {
  final String categoryId;
  final String categoryName;
  final int initialValue;
  final QuizMode initialMode;

  const DifficultyDialog({
    super.key,
    required this.categoryId,
    required this.categoryName,
    this.initialValue = 3,
    this.initialMode = QuizMode.casual,
  });

  /// Hasilnya kesulitan (1-5) dan mode, atau null jika dibatalkan.
  static Future<QuizSetup?> show(
    BuildContext context, {
    required String categoryId,
    required String categoryName,
    int initialValue = 3,
    QuizMode initialMode = QuizMode.casual,
  }) {
    return showDialog<QuizSetup>(
      context: context,
      builder: (_) => DifficultyDialog(
        categoryId: categoryId,
        categoryName: categoryName,
        initialValue: initialValue,
        initialMode: initialMode,
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
  late QuizMode _mode;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue.clamp(1, 5);
    _mode = widget.initialMode;
  }

  Widget _label(Responsive r, String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(bottom: r.h(1)),
        child: Text(
          text,
          style: TextStyle(
            fontSize: r.sp(4),
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
      ),
    );
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
                'Pengaturan Kuis',
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
              SizedBox(height: r.h(2.5)),

              // ---------- Tingkat kesulitan ----------
              _label(r, 'Tingkat kesulitan'),
              Text(
                '$_value',
                style: TextStyle(
                  fontSize: r.sp(14),
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              Text(
                _levelNames[_value - 1],
                style: TextStyle(
                  fontSize: r.sp(4.2),
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              SizedBox(height: r.h(1)),
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
              SizedBox(height: r.h(1.2)),
              Text(
                '$totalQuestions soal',
                style: TextStyle(
                  fontSize: r.sp(3.8),
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryText,
                ),
              ),

              // ---------- Mode ----------
              SizedBox(height: r.h(2.5)),
              _label(r, 'Mode'),
              QuizModePicker(
                selected: _mode,
                onChanged: (m) => setState(() => _mode = m),
              ),

              SizedBox(height: r.h(3)),
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
                      onPressed: () => Navigator.pop(
                        context,
                        (difficulty: _value, mode: _mode),
                      ),
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