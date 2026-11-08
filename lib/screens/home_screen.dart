import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/data_dummy.dart';
import '../models/quiz_category.dart';
import '../providers/quiz_provider.dart';
import '../utils/app_colors.dart';
import '../utils/page_transition.dart';
import '../utils/responsive.dart';
import '../widgets/category_card.dart';
import '../widgets/difficulty_dialog.dart';
import 'quiz_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _openCategory(
    BuildContext context,
    QuizCategory category,
  ) async {
    final quiz = context.read<QuizProvider>();

    final setup = await DifficultyDialog.show(
      context,
      categoryId: category.id,
      categoryName: category.name,
      initialValue: quiz.difficulty,
      initialMode: quiz.mode,
    );
    if (setup == null || !context.mounted) return;

    quiz.selectCategory(category);
    quiz.setDifficulty(setup.difficulty);
    quiz.setMode(setup.mode);
    quiz.resetQuiz(); // setelah semua pengaturan agar soal sesuai level

    Navigator.push(
      context,
      FadeSlideRoute(page: const QuizPage()),
    );
  }

  Widget _sectionTitle(Responsive r, String text) {
    return Padding(
      padding: EdgeInsets.only(top: r.h(3), bottom: r.h(1.5)),
      child: Text(
        text,
        style: TextStyle(
          fontSize: r.sp(5),
          fontWeight: FontWeight.w700,
          color: AppColors.textDark,
        ),
      ),
    );
  }

  /// Garis 5 warna pemanis di bawah sapaan.
  Widget _colorStrip(Responsive r) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(r.sp(2)),
      child: Row(
        children: [
          for (int i = 0; i < 5; i++)
            Expanded(
              child: Container(
                height: r.sp(1.6),
                color: AppColors.accent(i).main,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final userName = context.watch<QuizProvider>().userName;

    // Populer: urut dari jumlah pemain terbanyak.
    final popular = List<QuizCategory>.of(quizCategories)
      ..sort((a, b) => b.plays.compareTo(a.plays));

    // Warna kartu mengikuti urutan kategori.
    int colorOf(QuizCategory c) => quizCategories.indexOf(c);

    final gap = r.w(3);
    final padH = r.w(5);
    final boxPad = r.sp(4);

    return SafeArea(
      top: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Lebar yang benar-benar tersedia untuk isi halaman.
          final available = constraints.maxWidth - padH * 2;
          final columns = Breakpoints.columnsFor(constraints.maxWidth);

          final itemWidth =
              ((available - gap * (columns - 1)) / columns).floorToDouble();

          // Kuis populer: di layar lebar kartu sejajar, di HP bisa digeser.
          final inner = available - boxPad * 2;
          final popularWidth = columns == 1
              ? (inner * 0.82).floorToDouble()
              : ((inner - gap * (columns - 1)) / columns).floorToDouble();

          final popularBox = Container(
            width: double.infinity,
            padding: EdgeInsets.all(boxPad),
            decoration: BoxDecoration(
              color: AppColors.selectedFill,
              borderRadius: BorderRadius.circular(r.sp(5)),
              border: Border.all(color: AppColors.primary, width: r.sp(0.6)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      size: r.sp(18),
                      color: AppColors.accent(1).main,
                    ),
                    SizedBox(width: r.sp(3)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kuis Populer',
                            style: TextStyle(
                              fontSize: r.sp(5.5),
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryText,
                            ),
                          ),
                          SizedBox(height: r.sp(0.8)),
                          Text(
                            'Paling banyak dimainkan',
                            style: TextStyle(
                              fontSize: r.sp(3.4),
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: r.h(2)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < popular.length; i++)
                        Padding(
                          padding: EdgeInsets.only(
                            right: i == popular.length - 1 ? 0 : gap,
                          ),
                          child: SizedBox(
                            width: popularWidth,
                            child: CategoryCard(
                              category: popular[i],
                              rank: i + 1,
                              accentIndex: colorOf(popular[i]),
                              onTap: () => _openCategory(context, popular[i]),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: padH, vertical: r.h(2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo, $userName!',
                  style: TextStyle(
                    fontSize: r.sp(6),
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: r.h(0.5)),
                Text(
                  'Pilih kuis yang ingin kamu kerjakan.',
                  style: TextStyle(
                    fontSize: r.sp(3.8),
                    color: AppColors.textMuted,
                  ),
                ),
                SizedBox(height: r.h(1.5)),
                _colorStrip(r),
                SizedBox(height: r.h(2.5)),
                popularBox,
                _sectionTitle(r, 'Semua Kategori'),
                Wrap(
                  spacing: gap,
                  runSpacing: r.h(1.5),
                  children: [
                    for (final category in quizCategories)
                      SizedBox(
                        width: itemWidth,
                        child: CategoryCard(
                          category: category,
                          accentIndex: colorOf(category),
                          onTap: () => _openCategory(context, category),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: r.h(3)),
              ],
            ),
          );
        },
      ),
    );
  }
}