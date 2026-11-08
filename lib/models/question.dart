class Question {
  final String categoryId;
  final int difficulty;
  final String text;
  final List<String> options;
  final int correctIndex;

  const Question({
    required this.categoryId,
    required this.difficulty,
    required this.text,
    required this.options,
    required this.correctIndex,
  });
}