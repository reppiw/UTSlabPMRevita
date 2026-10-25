import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../utils/responsive.dart';
import '../widgets/primary_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: context.read<QuizProvider>().userName,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _startQuiz() {
    if (!_formKey.currentState!.validate()) return;

    final quiz = context.read<QuizProvider>();
    quiz.setUserName(_nameController.text);
    quiz.resetQuiz();

    // belum pindah halaman.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Nama tersimpan: ${quiz.userName}')),
    );

    // TODO Tahap 6: aktifkan navigasi di bawah ini
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (_) => const QuizPage()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final primary = Theme.of(context).colorScheme.primary;

    final imageHeight = r.isLandscape ? r.h(28) : r.h(24);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: r.w(7)),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/quiz_logo.png',
                    height: imageHeight,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: r.h(3)),
                  Text(
                    'Kuis Pilihan Ganda',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: r.sp(7),
                      fontWeight: FontWeight.bold,
                      color: primary,
                    ),
                  ),
                  SizedBox(height: r.h(1)),
                  Text(
                    'Masukkan namamu untuk memulai',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: r.sp(4),
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: r.h(3)),
                  TextFormField(
                    controller: _nameController,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _startQuiz(),
                    style: TextStyle(fontSize: r.sp(4.2)),
                    decoration: InputDecoration(
                      labelText: 'Nama',
                      hintText: 'Contoh: Budi',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(r.sp(3)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: r.sp(4),
                        vertical: r.sp(4),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: r.h(3)),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      label: 'Mulai Kuis',
                      onPressed: _startQuiz,
                    ),
                  ),
                  SizedBox(height: r.h(3)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}