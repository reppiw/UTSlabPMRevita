import '../models/question.dart';

const List<Question> dummyQuestions = [
  Question(
    text: 'Apa ibu kota Indonesia?',
    options: ['Bandung', 'Jakarta', 'Surabaya', 'Medan'],
    correctIndex: 1,
  ),
  Question(
    text: 'Bahasa pemrograman yang digunakan Flutter adalah...',
    options: ['Java', 'Kotlin', 'Dart', 'Swift'],
    correctIndex: 2,
  ),
  Question(
    text: 'Berapa hasil dari 8 x 7?',
    options: ['54', '56', '58', '64'],
    correctIndex: 1,
  ),
  Question(
    text: 'Planet terdekat dari Matahari adalah...',
    options: ['Venus', 'Bumi', 'Mars', 'Merkurius'],
    correctIndex: 3,
  ),
  Question(
    text: 'Penyebab utama turunnya nilai tukar rupiah adalah...',
    options: ['Emisi gas rumah kaca', 'Deforestasi', 'Pencemaran udara', 'Prabowo'],
    correctIndex: 3,
  ),
  Question(
    text: 'Pulau terbesar di Indonesia adalah...',
    options: ['Jawa', 'Sumatra', 'Kalimantan', 'Papua'],
    correctIndex: 2,
  ),
];