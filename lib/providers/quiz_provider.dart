import 'dart:async';
import 'package:flutter/foundation.dart';
import '../data/data_dummy.dart';
import '../models/history_entry.dart';
import '../models/question.dart';
import '../models/quiz_category.dart';
import '../models/quiz_mode.dart';

class QuizProvider extends ChangeNotifier {
  QuizProvider() {
    resetQuiz();
  }

  // ---------- PENGGUNA & PENGATURAN ----------
  String _userName = '';
  String _userEmail = '';
  QuizCategory _category = quizCategories.first;
  int _difficulty = 3;
  QuizMode _mode = QuizMode.casual;

  // ---------- PROGRES KUIS ----------
  List<Question> _questions = [];
  List<int?> _answers = [];
  int _currentIndex = 0;
  bool _saved = false;

  // ---------- TIMER (mode berwaktu) ----------
  Timer? _timer;
  int _secondsLeft = secondsPerQuestion;
  bool _timeExpired = false; // true jika waktu habis di soal terakhir

  // ---------- RIWAYAT (di memori) ----------
  final List<HistoryEntry> _history = [];

  // ---------- GETTER ----------
  String get userName => _userName;
  String get userEmail => _userEmail;
  QuizCategory get category => _category;
  int get difficulty => _difficulty;
  QuizMode get mode => _mode;

  bool get isTimed => _mode == QuizMode.timed;
  int get secondsLeft => _secondsLeft;
  bool get timeExpired => _timeExpired;

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

  /// Riwayat milik akun yang sedang masuk, terbaru di paling atas.
  List<HistoryEntry> get history => List.unmodifiable(
        _history.where((e) => e.ownerEmail == _userEmail).toList().reversed,
      );

  // ---------- ACTION: pengguna & pengaturan ----------
  void setUser(String name, String email) {
    _userName = name.trim();
    _userEmail = email;
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

  // ---------- ACTION: timer ----------
  void startTimer() {
    _timer?.cancel();
    _timer = null;
    _timeExpired = false;
    if (!isTimed) return;

    _secondsLeft = secondsPerQuestion;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
    notifyListeners();
  }

  /// Hentikan timer tanpa memberi tahu UI (aman dipanggil dari dispose).
  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _tick() {
    _secondsLeft--;
    if (_secondsLeft <= 0) {
      if (isLastQuestion) {
        stopTimer();
        _secondsLeft = 0;
        _timeExpired = true;
      } else {
        _currentIndex++;
        _secondsLeft = secondsPerQuestion;
      }
    }
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
      if (isTimed) _secondsLeft = secondsPerQuestion;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (isTimed) return; // mode berwaktu tidak boleh mundur
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  void resetQuiz() {
    stopTimer();
    _questions = questionsFor(_category.id, _difficulty);
    _answers = List<int?>.filled(_questions.length, null);
    _currentIndex = 0;
    _secondsLeft = secondsPerQuestion;
    _timeExpired = false;
    _saved = false;
    notifyListeners();
  }

  /// Dipanggil saat keluar akun.
  void resetAll() {
    _userName = '';
    _userEmail = '';
    _category = quizCategories.first;
    _difficulty = 3;
    _mode = QuizMode.casual;
    resetQuiz();
  }

  void saveToHistory() {
    if (_saved) return;
    _saved = true;
    _history.add(
      HistoryEntry(
        ownerEmail: _userEmail,
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

  /// Hapus riwayat milik akun yang sedang masuk saja.
  void clearHistory() {
    _history.removeWhere((e) => e.ownerEmail == _userEmail);
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}