import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../utils/responsive.dart';
import '../widgets/primary_button.dart';
import 'quiz_page.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  String _message(int percent) {
    if (percent >= 80) return 'Luar biasa!';
    if (percent >= 60) return 'Bagus, terus berlatih!';
    if (percent >= 40) return 'Lumayan, coba lagi ya!';
    return 'Jangan menyerah, ayo coba lagi!';
  }

  void _playAgain(BuildContext context) {
    context.read<QuizProvider>().resetQuiz();
    // Ganti halaman hasil dengan halaman kuis baru.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const QuizPage()),
    );
  }

  void _backToHome(BuildContext context) {
    context.read<QuizProvider>().resetAll();
    // Kembali ke halaman paling awal (HomePage).
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final quiz = context.watch<QuizProvider>();
    final primary = Theme.of(context).colorScheme.primary;

    final image = Image.asset(
      'lib/assets/images/quiz_logo.png',
      height: r.isLandscape ? r.h(30) : r.h(20),
      fit: BoxFit.contain,
    );

    final info = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Kuis Selesai!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: r.sp(6),
            fontWeight: FontWeight.bold,
            color: primary,
          ),
        ),
        SizedBox(height: r.h(1)),
        Text(
          quiz.userName,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: r.sp(4.5), fontWeight: FontWeight.w500),
        ),
        SizedBox(height: r.h(2)),
        Text(
          '${quiz.score}/${quiz.totalQuestions}',
          style: TextStyle(
            fontSize: r.sp(16),
            fontWeight: FontWeight.bold,
            color: primary,
          ),
        ),
        Text(
          'Skor: ${quiz.scorePercent}',
          style: TextStyle(fontSize: r.sp(4.5)),
        ),
        SizedBox(height: r.h(1)),
        Text(
          _message(quiz.scorePercent),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: r.sp(4), color: Colors.grey.shade700),
        ),
        SizedBox(height: r.h(3)),
        SizedBox(
          width: double.infinity,
          child: PrimaryButton(
            label: 'Main Lagi',
            onPressed: () => _playAgain(context),
          ),
        ),
        SizedBox(height: r.h(1.5)),
        SizedBox(
          width: double.infinity,
          child: PrimaryButton(
            label: 'Kembali ke Awal',
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
                      SizedBox(height: r.h(3)),
                      info,
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}