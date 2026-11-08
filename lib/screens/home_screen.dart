import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/data_dummy.dart';
import '../models/quiz_category.dart';
import '../providers/quiz_provider.dart';
import '../utils/app_colors.dart';
import '../utils/page_transition.dart';
import '../utils/responsive.dart';
import '../widgets/category_card.dart';
import '../widgets/name_dialog.dart';
import '../widgets/difficulty_dialog.dart';
import 'quiz_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _openCategory(
    BuildContext context,
    QuizCategory category,
  ) async {
    final quiz = context.read<QuizProvider>();

    final name = await NameDialog.show(
      context,
      categoryName: category.name,
      initialName: quiz.userName,
    );

    if (name == null || !context.mounted) return;

    final difficulty = await DifficultyDialog.show(
      context,
      categoryId: category.id,
      categoryName: category.name,
      initialValue: quiz.difficulty,
    );

    if (difficulty == null || !context.mounted) return;

    quiz.selectCategory(category);
    quiz.setUserName(name);
    quiz.setDifficulty(difficulty);
    quiz.resetQuiz();

    Navigator.push(
      context,
      FadeSlideRoute(page: const QuizPage()),
    );
  }

  Widget _sectionTitle(Responsive r, String text) {
    return Padding(
      padding: EdgeInsets.only(top: r.h(2.5), bottom: r.h(1.5)),
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

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    // Populer: urut dari jumlah pemain terbanyak.
    final popular = List<QuizCategory>.of(quizCategories)
      ..sort((a, b) => b.plays.compareTo(a.plays));

    final contentWidth = r.w(90);
    final gap = r.w(3);
    final popularWidth = r.isLandscape ? r.w(40) : r.w(72);
    final gridWidth =
        r.isLandscape ? (contentWidth - gap) / 2 : contentWidth;

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: r.w(5), vertical: r.h(2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat datang!',
              style: TextStyle(
                fontSize: r.sp(6.5),
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

            _sectionTitle(r, 'Kuis Populer'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < popular.length; i++)
                    Padding(
                      padding: EdgeInsets.only(right: gap),
                      child: SizedBox(
                        width: popularWidth,
                        child: CategoryCard(
                          category: popular[i],
                          rank: i + 1,
                          onTap: () => _openCategory(context, popular[i]),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            _sectionTitle(r, 'Semua Kategori'),
            Wrap(
              spacing: gap,
              runSpacing: r.h(1.5),
              children: [
                for (final category in quizCategories)
                  SizedBox(
                    width: gridWidth,
                    child: CategoryCard(
                      category: category,
                      onTap: () => _openCategory(context, category),
                    ),
                  ),
              ],
            ),
            SizedBox(height: r.h(3)),
          ],
        ),
      ),
    );
  }
}