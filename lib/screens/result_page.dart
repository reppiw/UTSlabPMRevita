import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../utils/app_colors.dart';
import '../utils/page_transition.dart';
import '../utils/responsive.dart';
import '../widgets/primary_button.dart';
import 'quiz_page.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  ({String image, String message}) _tier(int percent) {
    if (percent >= 80) {
      return (
        image: 'lib/assets/images/icon33.png',
        message: 'Luar biasa! Kamu hebat!',
      );
    }
    if (percent >= 50) {
      return (
        image: 'lib/assets/images/quiz_logo.png',
        message: 'Bagus! Sedikit lagi sempurna.',
      );
    }
    return (
      image: 'lib/assets/images/icon44.png',
      message: 'Jangan menyerah, ayo coba lagi!',
    );
  }

  void _playAgain(BuildContext context) {
    context.read<QuizProvider>().resetQuiz();
    Navigator.pushReplacement(
      context,
      FadeSlideRoute(page: const QuizPage()),
    );
  }

  void _backToHome(BuildContext context) {
    context.read<QuizProvider>().resetQuiz();
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final quiz = context.watch<QuizProvider>();
    final tier = _tier(quiz.scorePercent);
    final imageHeight = r.isLandscape ? r.h(40) : r.h(26);

    final image = TweenAnimationBuilder<double>(
      key: ValueKey(tier.image),
      tween: Tween<double>(begin: 0.6, end: 1),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutBack,
      builder: (context, scale, child) =>
          Transform.scale(scale: scale, child: child),
      child: Image.asset(
        tier.image,
        height: imageHeight,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => SizedBox(height: imageHeight),
      ),
    );

    final info = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Kuis Selesai!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: r.sp(6),
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: r.h(0.5)),
        Text(
          quiz.userName,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: r.sp(4.5),
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: r.h(1.5)),
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: quiz.score.toDouble()),
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeOut,
          builder: (context, value, _) => Text(
            '${value.round()}/${quiz.totalQuestions}',
            style: TextStyle(
              fontSize: r.sp(16),
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ),
        Text(
          'Skor: ${quiz.scorePercent}',
          style: TextStyle(fontSize: r.sp(4.5), color: AppColors.textDark),
        ),
        SizedBox(height: r.h(1)),
        Text(
          tier.message,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: r.sp(4), color: AppColors.textMuted),
        ),
        SizedBox(height: r.h(3)),
        SizedBox(
          width: double.infinity,
          child: PrimaryButton(
            label: 'Main Lagi',
            accentIndex: 3,
            onPressed: () => _playAgain(context),
          ),
        ),
        SizedBox(height: r.h(1.5)),
        SizedBox(
          width: double.infinity,
          child: PrimaryButton(
            label: 'Kembali ke Awal',
            accentIndex: 4,
            outlined: true,
            onPressed: () => _backToHome(context),
          ),
        ),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(r.w(6)),
            child: r.isLandscape
                ? Row(
                    children: [
                      Expanded(child: Center(child: image)),
                      SizedBox(width: r.w(4)),
                      Expanded(child: info),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      image,
                      SizedBox(height: r.h(2)),
                      info,
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}