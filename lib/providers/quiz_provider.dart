import 'package:flutter/foundation.dart';
import '../data/data_dummy.dart';
import '../models/history_entry.dart';
import '../models/question.dart';
import '../models/quiz_category.dart';
import '../models/quiz_mode.dart';

class QuizProvider extends ChangeNotifier {
  QuizProvider() {
    resetQuiz(); // siapkan soal untuk kategori default
  }

  String _userName = '';
  QuizCategory _category = quizCategories.first;
  int _difficulty = 3;
  QuizMode _mode = QuizMode.casual;

  List<Question> _questions = [];
  List<int?> _answers = [];
  int _currentIndex = 0;
  bool _saved = false;

  final List<HistoryEntry> _history = [];

  // ---------- GETTER: pengaturan ----------
  String get userName => _userName;
  QuizCategory get category => _category;
  int get difficulty => _difficulty;
  QuizMode get mode => _mode;

  // ---------- GETTER: progres ----------
  int get currentIndex => _currentIndex;
  int get totalQuestions => _questions.length;
  Question get currentQuestion => _questions[_currentIndex];
  int? get selectedAnswer => _answers[_currentIndex];
  bool get hasAnswered => selectedAnswer != null;
  bool get isLastQuestion => _currentIndex == totalQuestions - 1;
  double get progress =>
      totalQuestions == 0 ? 0 : (_currentIndex + 1) / totalQuestions;

  int get score {
    int total = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_answers[i] == _questions[i].correctIndex) total++;
    }
    return total;
  }

  int get scorePercent =>
      totalQuestions == 0 ? 0 : ((score / totalQuestions) * 100).round();

  // ---------- GETTER: riwayat ----------
  /// Riwayat terbaru di paling atas.
  List<HistoryEntry> get history => List.unmodifiable(_history.reversed);

  // ---------- ACTION: pengaturan ----------
  void setUserName(String name) {
    _userName = name.trim();
    notifyListeners();
  }

  void selectCategory(QuizCategory category) {
    _category = category;
    notifyListeners();
  }

  void setDifficulty(int value) {
    _difficulty = value.clamp(1, 5);
    notifyListeners();
  }

  void setMode(QuizMode mode) {
    _mode = mode;
    notifyListeners();
  }

  // ---------- ACTION: kuis ----------
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

  /// Susun ulang soal sesuai pengaturan saat ini dan mulai dari awal.
  void resetQuiz() {
    _questions = questionsFor(_category.id, _difficulty);
    _answers = List<int?>.filled(_questions.length, null);
    _currentIndex = 0;
    _saved = false;
    notifyListeners();
  }

  /// Reset total, termasuk nama dan pengaturan
  void resetAll() {
    _userName = '';
    _category = quizCategories.first;
    _difficulty = 3;
    _mode = QuizMode.casual;
    resetQuiz();
  }

  /// Catat hasil ke riwayat. Aman dipanggil berulang, hanya tersimpan sekali
  void saveToHistory() {
    if (_saved) return;
    _saved = true;
    _history.add(
      HistoryEntry(
        userName: _userName,
        categoryName: _category.name,
        difficulty: _difficulty,
        mode: _mode,
        score: score,
        total: totalQuestions,
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}