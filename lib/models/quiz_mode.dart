const int secondsPerQuestion = 20;

enum QuizMode { casual, timed }

extension QuizModeLabel on QuizMode {
  String get label => this == QuizMode.casual ? 'Casual' : 'Berwaktu';

  String get description => this == QuizMode.casual
      ? 'Tanpa batas waktu, bisa kembali ke soal sebelumnya.'
      : '$secondsPerQuestion detik per soal, tidak bisa kembali.';
}