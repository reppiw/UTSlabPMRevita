import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';
import '../widgets/bouncing_text.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slide;
  bool _showCurtain = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )
      ..addStatusListener((status) {
        // Setelah tirai naik penuh, lepas dari layar.
        if (status == AnimationStatus.completed && mounted) {
          setState(() => _showCurtain = false);
        }
      })
      ..forward();

    // Turun dari atas -> diam (loading) -> ditarik ke atas.
    _slide = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 22,
      ),
      TweenSequenceItem(
        tween: ConstantTween<Offset>(Offset.zero),
        weight: 56,
      ),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(0, -1),
        ).chain(CurveTween(curve: Curves.easeInCubic)),
        weight: 22,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Halaman login sudah siap di bawah tirai.
        const LoginScreen(),
        if (_showCurtain)
          SlideTransition(
            position: _slide,
            child: _Curtain(animation: _controller),
          ),
      ],
    );
  }
}

class _Curtain extends StatelessWidget {
  final Animation<double> animation;

  const _Curtain({required this.animation});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final barWidth = r.w(55);
    final barHeight = r.sp(2.8);
    final imageHeight = r.isLandscape ? r.h(28) : r.h(20);

    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.primary,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: r.h(2)),
                  BouncingText(
                    text: 'HexenQ',
                    jumpHeight: r.sp(3),
                    style: TextStyle(
                      fontSize: r.sp(14),
                      fontWeight: FontWeight.w700,
                      color: AppColors.onPrimary,
                    ),
                  ),
                  SizedBox(height: r.h(4)),
                  // Bar loading
                  AnimatedBuilder(
                    animation: animation,
                    builder: (context, _) {
                      final progress =
                          ((animation.value - 0.22) / 0.56).clamp(0.0, 1.0);
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(barHeight),
                        child: SizedBox(
                          width: barWidth,
                          height: barHeight,
                          child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor: AppColors.primaryShadow,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.onPrimary,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: r.h(1.5)),
                  Text(
                    'Loading...',
                    style: TextStyle(
                      fontSize: r.sp(3.8),
                      color: AppColors.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}