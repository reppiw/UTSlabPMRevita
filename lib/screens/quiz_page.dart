import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quiz_mode.dart';
import '../providers/quiz_provider.dart';
import '../utils/app_colors.dart';
import '../utils/page_transition.dart';
import '../utils/responsive.dart';
import '../widgets/option_tile.dart';
import '../widgets/primary_button.dart';
import '../widgets/progress_header.dart';
import '../widgets/timer_bar.dart';
import 'result_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late final QuizProvider _quiz;
  bool _finishing = false;

  @override
  void initState() {
    super.initState();
    _quiz = context.read<QuizProvider>();
    _quiz.addListener(_onQuizChanged);

    // Mulai timer setelah halaman tampil (tidak aktif di mode casual).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _quiz.startTimer();
    });
  }

  @override
  void dispose() {
    _quiz.removeListener(_onQuizChanged);
    _quiz.stopTimer();
    super.dispose();
  }

  // Waktu habis di soal terakhir: selesai.
  void _onQuizChanged() {
    if (_quiz.timeExpired) Future.microtask(_finish);
  }

  void _finish() {
    if (_finishing || !mounted) return;
    _finishing = true;
    _quiz.stopTimer();
    _quiz.saveToHistory();
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

    final header = Column(
      children: [
        ProgressHeader(
          userName: quiz.userName,
          current: quiz.currentIndex + 1,
          total: quiz.totalQuestions,
          progress: quiz.progress,
        ),
        if (quiz.mode == QuizMode.timed) ...[
          SizedBox(height: r.sp(3)),
          TimerBar(
            key: ValueKey(quiz.currentIndex), // timer penuh lagi tiap soal baru
            secondsLeft: quiz.secondsLeft,
            total: secondsPerQuestion,
          ),
        ],
      ],
    );

    final questionText = AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: SizedBox(
        key: ValueKey(quiz.currentIndex),
        width: double.infinity,
        child: Text(
          question.text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: r.sp(5.2),
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
      ),
    );

    final options = AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Column(
        key: ValueKey(quiz.currentIndex),
        children: [
          for (int i = 0; i < question.options.length; i++)
            OptionTile(
              label: String.fromCharCode(65 + i), // A, B, C
              text: question.options[i],
              isSelected: quiz.selectedAnswer == i,
              accentIndex: i,
              onTap: () => context.read<QuizProvider>().selectAnswer(i),
            ),
        ],
      ),
    );

    final buttons = Row(
      children: [
        Expanded(
          child: PrimaryButton(
            label: 'Kembali',
            outlined: true,
            accentIndex: quiz.currentIndex + 1,
            // Mode berwaktu tidak boleh mundur.
            onPressed: (quiz.isTimed || quiz.currentIndex == 0)
                ? null
                : () => context.read<QuizProvider>().previousQuestion(),
          ),
        ),
        SizedBox(width: r.w(3)),
        Expanded(
          child: PrimaryButton(
            label: quiz.isLastQuestion ? 'Selesai' : 'Lanjut',
            accentIndex: quiz.currentIndex,
            onPressed: quiz.hasAnswered
                ? () {
                    if (quiz.isLastQuestion) {
                      _finish();
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
            r.isLandscape ? r.h(4) : r.h(8),
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