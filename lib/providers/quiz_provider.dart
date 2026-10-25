import 'package:flutter/foundation.dart';
import '../data/data_dummy.dart';
import '../models/question.dart';

class QuizProvider extends ChangeNotifier {
  // ---------- STATE ----------
  String _userName = '';
  int _currentIndex = 0;

  // Jawaban pengguna per soal. null = belum dijawab.
  final List<int?> _answers =
      List<int?>.filled(dummyQuestions.length, null);

  // ---------- GETTER ----------
  String get userName => _userName;
  int get currentIndex => _currentIndex;
  int get totalQuestions => dummyQuestions.length;
  Question get currentQuestion => dummyQuestions[_currentIndex];

  /// Jawaban yang dipilih pada soal saat ini (null jika belum menjawab).
  int? get selectedAnswer => _answers[_currentIndex];

  bool get hasAnswered => selectedAnswer != null;
  bool get isLastQuestion => _currentIndex == totalQuestions - 1;

  /// Progres 0.0 sampai 1.0 untuk progress bar.
  double get progress => (_currentIndex + 1) / totalQuestions;

  /// Skor akhir = jumlah jawaban yang benar.
  int get score {
    int total = 0;
    for (int i = 0; i < dummyQuestions.length; i++) {
      if (_answers[i] == dummyQuestions[i].correctIndex) total++;
    }
    return total;
  }

  /// Skor dalam skala 0 - 100.
  int get scorePercent => ((score / totalQuestions) * 100).round();

  // ---------- ACTION ----------
  void setUserName(String name) {
    _userName = name.trim();
    notifyListeners();
  }

  /// Simpan jawaban untuk soal saat ini.
  void selectAnswer(int optionIndex) {
    _answers[_currentIndex] = optionIndex;
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentIndex < totalQuestions - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  /// Mulai ulang kuis. Nama dipertahankan agar bisa main lagi.
  void resetQuiz() {
    _currentIndex = 0;
    for (int i = 0; i < _answers.length; i++) {
      _answers[i] = null;
    }
    notifyListeners();
  }

  /// Reset total, termasuk nama (kembali ke halaman awal).
  void resetAll() {
    _userName = '';
    resetQuiz();
  }
}