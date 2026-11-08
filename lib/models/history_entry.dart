import 'quiz_mode.dart';

class HistoryEntry {
  final String userName;
  final String categoryName;
  final int difficulty;
  final QuizMode mode;
  final int score;
  final int total;
  final DateTime date;

  const HistoryEntry({
    required this.userName,
    required this.categoryName,
    required this.difficulty,
    required this.mode,
    required this.score,
    required this.total,
    required this.date,
  });

  int get percent => total == 0 ? 0 : ((score / total) * 100).round();
}