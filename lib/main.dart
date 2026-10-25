import 'package:flutter/material.dart';
import 'data/data_dummy.dart';
import 'utils/responsive.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: const TestPage(),
    );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Soal pilihan ganda')),
      body: ListView.builder(
        padding: EdgeInsets.all(r.w(4)),
        itemCount: dummyQuestions.length,
        itemBuilder: (context, i) {
          final q = dummyQuestions[i];
          return Padding(
            padding: EdgeInsets.only(bottom: r.h(2)),
            child: Text(
              '${i + 1}. ${q.text}\n'
              '   Jawaban: ${q.options[q.correctIndex]}',
              style: TextStyle(fontSize: r.sp(4)),
            ),
          );
        },
      ),
    );
  }
}