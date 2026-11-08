import '../models/question.dart';
import '../models/quiz_category.dart';

const List<QuizCategory> quizCategories = [
  QuizCategory(
    id: 'umum',
    name: 'Pengetahuan Umum',
    description: 'Indonesia, dunia, dan hal sehari-hari.',
    plays: 1280,
  ),
  QuizCategory(
    id: 'teknologi',
    name: 'Teknologi & Flutter',
    description: 'Dasar pemrograman dan Flutter.',
    plays: 940,
  ),
  QuizCategory(
    id: 'sains',
    name: 'Sains',
    description: 'Fisika, kimia, dan tata surya.',
    plays: 760,
  ),
];

const List<Question> allQuestions = [
  // ---------- UMUM ----------
  Question(
    categoryId: 'umum', difficulty: 1,
    text: 'Apa ibu kota Indonesia?',
    options: ['Bandung', 'Jakarta', 'Surabaya', 'Medan'],
    correctIndex: 1,
  ),
  Question(
    categoryId: 'umum', difficulty: 1,
    text: 'Berapa hasil dari 8 x 7?',
    options: ['54', '56', '58', '64'],
    correctIndex: 1,
  ),
  Question(
    categoryId: 'umum', difficulty: 2,
    text: 'Siapa proklamator kemerdekaan Indonesia bersama Soekarno?',
    options: ['Mohammad Hatta', 'Sutan Sjahrir', 'Ki Hajar Dewantara', 'Tan Malaka'],
    correctIndex: 0,
  ),
  Question(
    categoryId: 'umum', difficulty: 2,
    text: 'Pulau terbesar di Indonesia adalah...',
    options: ['Jawa', 'Sumatra', 'Kalimantan', 'Sulawesi'],
    correctIndex: 2,
  ),
  Question(
    categoryId: 'umum', difficulty: 3,
    text: 'Samudra terluas di dunia adalah...',
    options: ['Atlantik', 'Hindia', 'Arktik', 'Pasifik'],
    correctIndex: 3,
  ),
  Question(
    categoryId: 'umum', difficulty: 3,
    text: 'Gunung tertinggi di dunia adalah...',
    options: ['K2', 'Everest', 'Kilimanjaro', 'Puncak Jaya'],
    correctIndex: 1,
  ),
  Question(
    categoryId: 'umum', difficulty: 4,
    text: 'Benua terluas di dunia adalah...',
    options: ['Afrika', 'Amerika Utara', 'Asia', 'Eropa'],
    correctIndex: 2,
  ),
  Question(
    categoryId: 'umum', difficulty: 4,
    text: 'Siapa penulis novel "Laskar Pelangi"?',
    options: ['Tere Liye', 'Andrea Hirata', 'Habiburrahman El Shirazy', 'Pramoedya Ananta Toer'],
    correctIndex: 1,
  ),
  Question(
    categoryId: 'umum', difficulty: 5,
    text: 'ASEAN didirikan pada tahun...',
    options: ['1957', '1962', '1967', '1977'],
    correctIndex: 2,
  ),
  Question(
    categoryId: 'umum', difficulty: 5,
    text: 'Apa ibu kota Australia?',
    options: ['Sydney', 'Melbourne', 'Canberra', 'Perth'],
    correctIndex: 2,
  ),

  // ---------- TEKNOLOGI ----------
  Question(
    categoryId: 'teknologi', difficulty: 1,
    text: 'Bahasa pemrograman yang digunakan Flutter adalah...',
    options: ['Java', 'Kotlin', 'Dart', 'Swift'],
    correctIndex: 2,
  ),
  Question(
    categoryId: 'teknologi', difficulty: 1,
    text: 'HTML adalah singkatan dari...',
    options: [
      'HyperText Markup Language',
      'High Text Machine Language',
      'HyperTool Multi Language',
      'Home Text Markup Level',
    ],
    correctIndex: 0,
  ),
  Question(
    categoryId: 'teknologi', difficulty: 2,
    text: 'Widget Flutter yang dapat berubah tampilannya saat state berubah adalah...',
    options: ['StatelessWidget', 'StatefulWidget', 'InheritedWidget', 'Container'],
    correctIndex: 1,
  ),
  Question(
    categoryId: 'teknologi', difficulty: 2,
    text: 'Perintah untuk membuat proyek Flutter baru adalah...',
    options: ['flutter new', 'flutter init', 'flutter start', 'flutter create'],
    correctIndex: 3,
  ),
  Question(
    categoryId: 'teknologi', difficulty: 3,
    text: 'File untuk mendaftarkan dependency dan aset di Flutter adalah...',
    options: ['main.dart', 'pubspec.yaml', 'build.gradle', 'package.json'],
    correctIndex: 1,
  ),
  Question(
    categoryId: 'teknologi', difficulty: 3,
    text: 'Method untuk memicu rebuild pada StatefulWidget adalah...',
    options: ['refresh()', 'rebuild()', 'setState()', 'update()'],
    correctIndex: 2,
  ),
  Question(
    categoryId: 'teknologi', difficulty: 4,
    text: 'Pada package Provider, class yang memberi tahu UI saat data berubah adalah...',
    options: ['ChangeNotifier', 'StateObject', 'ValueStore', 'WidgetNotifier'],
    correctIndex: 0,
  ),
  Question(
    categoryId: 'teknologi', difficulty: 4,
    text: 'Widget untuk daftar yang item-nya dibangun hanya saat dibutuhkan adalah...',
    options: ['Column', 'ListView.builder', 'Stack', 'Wrap'],
    correctIndex: 1,
  ),
  Question(
    categoryId: 'teknologi', difficulty: 5,
    text: 'Method lifecycle State yang dipanggil sekali saat State pertama dibuat adalah...',
    options: ['build()', 'dispose()', 'didUpdateWidget()', 'initState()'],
    correctIndex: 3,
  ),
  Question(
    categoryId: 'teknologi', difficulty: 5,
    text: 'Widget yang menyediakan data ke seluruh subtree tanpa oper parameter adalah...',
    options: ['InheritedWidget', 'SizedBox', 'Placeholder', 'Align'],
    correctIndex: 0,
  ),

  // ---------- SAINS ----------
  Question(
    categoryId: 'sains', difficulty: 1,
    text: 'Lambang kimia untuk air adalah...',
    options: ['CO2', 'O2', 'H2O', 'NaCl'],
    correctIndex: 2,
  ),
  Question(
    categoryId: 'sains', difficulty: 1,
    text: 'Planet terdekat dari Matahari adalah...',
    options: ['Venus', 'Bumi', 'Mars', 'Merkurius'],
    correctIndex: 3,
  ),
  Question(
    categoryId: 'sains', difficulty: 2,
    text: 'Gas yang kita hirup untuk bernapas adalah...',
    options: ['Nitrogen', 'Oksigen', 'Karbon dioksida', 'Hidrogen'],
    correctIndex: 1,
  ),
  Question(
    categoryId: 'sains', difficulty: 2,
    text: 'Planet terbesar di tata surya adalah...',
    options: ['Saturnus', 'Jupiter', 'Neptunus', 'Uranus'],
    correctIndex: 1,
  ),
  Question(
    categoryId: 'sains', difficulty: 3,
    text: 'Satuan gaya dalam sistem SI adalah...',
    options: ['Joule', 'Watt', 'Pascal', 'Newton'],
    correctIndex: 3,
  ),
  Question(
    categoryId: 'sains', difficulty: 3,
    text: 'Proses tumbuhan membuat makanan dengan bantuan cahaya matahari disebut...',
    options: ['Respirasi', 'Fotosintesis', 'Fermentasi', 'Transpirasi'],
    correctIndex: 1,
  ),
  Question(
    categoryId: 'sains', difficulty: 4,
    text: 'Partikel atom yang bermuatan negatif adalah...',
    options: ['Proton', 'Neutron', 'Elektron', 'Positron'],
    correctIndex: 2,
  ),
  Question(
    categoryId: 'sains', difficulty: 4,
    text: 'Unsur dengan lambang Fe adalah...',
    options: ['Fluorin', 'Besi', 'Fosfor', 'Perak'],
    correctIndex: 1,
  ),
  Question(
    categoryId: 'sains', difficulty: 5,
    text: 'Kecepatan cahaya di ruang hampa sekitar...',
    options: ['3.000 km/s', '30.000 km/s', '300.000 km/s', '3.000.000 km/s'],
    correctIndex: 2,
  ),
  Question(
    categoryId: 'sains', difficulty: 5,
    text: 'Nilai pH air murni pada suhu ruang adalah...',
    options: ['5', '6', '7', '8'],
    correctIndex: 2,
  ),
];

/// Ambil soal untuk kategori dan tingkat kesulitan tertentu.
/// Soal yang dipilih: level (difficulty - 1) sampai (difficulty + 1),
/// diurutkan dari yang termudah.
List<Question> questionsFor(String categoryId, int difficulty) {
  final list = allQuestions
      .where((q) =>
          q.categoryId == categoryId && (q.difficulty - difficulty).abs() <= 1)
      .toList();
  list.sort((a, b) => a.difficulty.compareTo(b.difficulty));
  return list;
}