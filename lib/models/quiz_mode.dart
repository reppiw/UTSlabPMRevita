enum QuizMode { casual, timed }

extension QuizModeLabel on QuizMode {
  String get label => this == QuizMode.casual ? 'Casual' : 'Hard';

  String get description => this == QuizMode.casual
      ? 'Tanpa batas waktu, santai.'
      : 'Gercep! Ada batas waktu tiap soal.';
}