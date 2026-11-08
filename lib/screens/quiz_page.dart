import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../utils/responsive.dart';
import '../utils/page_transition.dart';
import '../widgets/option_tile.dart';
import '../widgets/primary_button.dart';
import '../widgets/progress_header.dart';
import 'result_page.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  void _finish(BuildContext context) {
    Navigator.pushReplacement(
      context,
      FadeSlideRoute(page: const ResultPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final quiz = context.watch<QuizProvider>();
    final question = quiz.currentQuestion;

    final header = ProgressHeader(
      userName: quiz.userName,
      current: quiz.currentIndex + 1,
      total: quiz.totalQuestions,
      progress: quiz.progress,
    );

    final questionText = AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: SizedBox(
        key: ValueKey(quiz.currentIndex),
        width: double.infinity,
        child: Text(
          question.text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: r.sp(5.2),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final options = Column(
      children: [
        for (int i = 0; i < question.options.length; i++)
          OptionTile(
            label: String.fromCharCode(65 + i),
            text: question.options[i],
            isSelected: quiz.selectedAnswer == i,
            onTap: () => context.read<QuizProvider>().selectAnswer(i),
          ),
      ],
    );

    final buttons = Row(
      children: [
        Expanded(
          child: PrimaryButton(
            label: 'Kembali',
            outlined: true,
            onPressed: quiz.currentIndex == 0
                ? null
                : () => context.read<QuizProvider>().previousQuestion(),
          ),
        ),
        SizedBox(width: r.w(3)),
        Expanded(
          child: PrimaryButton(
            label: quiz.isLastQuestion ? 'Selesai' : 'Lanjut',
            onPressed: quiz.hasAnswered
                ? () {
                    if (quiz.isLastQuestion) {
                      _finish(context);
                    } else {
                      context.read<QuizProvider>().nextQuestion();
                    }
                  }
                : null,
          ),
        ),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            r.w(5),
            r.w(5),
            r.w(5),
            r.isLandscape ? r.h(4) : r.h(16), // jarak bawah tombol
          ),
          child: r.isLandscape
              // Landscape: soal di kiri, pilihan di kanan.
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          header,
                          Expanded(
                            child: Center(
                              child: SingleChildScrollView(
                                child: questionText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: r.w(4)),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(child: options),
                          ),
                          SizedBox(height: r.h(2)),
                          buttons,
                        ],
                      ),
                    ),
                  ],
                )
              // Portrait: tersusun vertikal.
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    header,
                    SizedBox(height: r.h(3)),
                    questionText,
                    SizedBox(height: r.h(2.5)),
                    Expanded(child: SingleChildScrollView(child: options)),
                    SizedBox(height: r.h(3)),
                    buttons,
                  ],
                ),
        ),
      ),
    );
  }
}