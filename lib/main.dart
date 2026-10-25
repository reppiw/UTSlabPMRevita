import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/quiz_provider.dart';
import 'utils/responsive.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const TestPage(),
    );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final quiz = context.watch<QuizProvider>();
    final q = quiz.currentQuestion;

    return Scaffold(
      appBar: AppBar(title: const Text('Tes QuizProvider')),
      body: Padding(
        padding: EdgeInsets.all(r.w(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Soal ${quiz.currentIndex + 1} dari ${quiz.totalQuestions}',
              style: TextStyle(fontSize: r.sp(3.5)),
            ),
            SizedBox(height: r.h(1)),
            Text(
              q.text,
              style: TextStyle(
                fontSize: r.sp(5),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: r.h(2)),
            for (int i = 0; i < q.options.length; i++)
              RadioListTile<int>(
                title: Text(q.options[i]),
                value: i,
                groupValue: quiz.selectedAnswer,
                onChanged: (v) =>
                    context.read<QuizProvider>().selectAnswer(v!),
              ),
            const Spacer(),
            Text(
              'Skor sementara: ${quiz.score}',
              style: TextStyle(fontSize: r.sp(4)),
            ),
            SizedBox(height: r.h(1)),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () =>
                      context.read<QuizProvider>().previousQuestion(),
                  child: const Text('Sebelumnya'),
                ),
                SizedBox(width: r.w(3)),
                ElevatedButton(
                  onPressed: () =>
                      context.read<QuizProvider>().nextQuestion(),
                  child: const Text('Berikutnya'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}