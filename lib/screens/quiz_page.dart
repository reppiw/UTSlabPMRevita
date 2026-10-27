import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../utils/responsive.dart';
import '../widgets/primary_button.dart';
import 'result_page.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  static const _labels = ['A', 'B', 'C', 'D', 'E', 'F'];

  void _finish(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ResultPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final quiz = context.watch<QuizProvider>();
    final question = quiz.currentQuestion;
    final primary = Theme.of(context).colorScheme.primary;

    // Header sederhana (nanti diganti ProgressHeader).
    final header = Row(
      children: [
        Expanded(
          child: Text(
            quiz.userName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: r.sp(4.2),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          'Soal ${quiz.currentIndex + 1}/${quiz.totalQuestions}',
          style: TextStyle(fontSize: r.sp(3.6)),
        ),
      ],
    );

    final questionText = SizedBox(
      width: double.infinity,
      child: Text(
        question.text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: r.sp(5.2),
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    // Pilihan jawaban sederhana (nanti diganti OptionTile).
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(r.sp(3)),
    );
    final optionPadding = EdgeInsets.symmetric(
      horizontal: r.sp(4),
      vertical: r.sp(3.5),
    );

    final options = Column(
      children: [
        for (int i = 0; i < question.options.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: r.sp(2.5)),
            child: SizedBox(
              width: double.infinity,
              child: quiz.selectedAnswer == i
                  ? ElevatedButton(
                      onPressed: () =>
                          context.read<QuizProvider>().selectAnswer(i),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        alignment: Alignment.centerLeft,
                        shape: shape,
                        padding: optionPadding,
                      ),
                      child: Text(
                        '${_labels[i]}.  ${question.options[i]}',
                        style: TextStyle(fontSize: r.sp(4)),
                      ),
                    )
                  : OutlinedButton(
                      onPressed: () =>
                          context.read<QuizProvider>().selectAnswer(i),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black87,
                        backgroundColor: Colors.white,
                        alignment: Alignment.centerLeft,
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: shape,
                        padding: optionPadding,
                      ),
                      child: Text(
                        '${_labels[i]}.  ${question.options[i]}',
                        style: TextStyle(fontSize: r.sp(4)),
                      ),
                    ),
            ),
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
          padding: EdgeInsets.fromLTRB(r.w(6), r.h(3), r.w(6), r.h(38)),
          child: r.isLandscape
              // Landscape: soal di kiri, pilihan di kanan.
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            header,
                            SizedBox(height: r.h(4)),
                            questionText,
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: r.w(4)),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(child: options),
                          ),
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
                    SizedBox(height: r.h(1.5)),
                    buttons,
                  ],
                ),
        ),
      ),
    );
  }
}