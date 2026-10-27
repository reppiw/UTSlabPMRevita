// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:utslab/main.dart';
import 'package:utslab/providers/quiz_provider.dart';

void main() {
  testWidgets('shows the home screen on startup', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => QuizProvider(),
        child: const MyApp(),
      ),
    );

    expect(find.text('Kuis Pilihan Ganda'), findsOneWidget);
    expect(find.text('Masukkan namamu untuk memulai'), findsOneWidget);
    expect(find.text('Mulai Kuis'), findsOneWidget);
  });
}
