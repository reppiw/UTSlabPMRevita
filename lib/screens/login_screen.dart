import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/quiz_provider.dart';
import '../utils/app_colors.dart';
import '../utils/page_transition.dart';
import '../utils/responsive.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/primary_button.dart';
import 'main_shell.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isRegister = false;
  bool _obscure = true;
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleMode() {
    setState(() {
      _isRegister = !_isRegister;
      _error = null;
    });
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthProvider>();
    final error = _isRegister
        ? auth.register(
            name: _nameController.text,
            email: _emailController.text,
            password: _passwordController.text,
          )
        : auth.login(
            email: _emailController.text,
            password: _passwordController.text,
          );

    if (error != null) {
      setState(() => _error = error);
      return;
    }

    // Data akun langsung dipakai oleh kuis dan profil.
    final user = auth.currentUser!;
    context.read<QuizProvider>().setUser(user.name, user.email);

    Navigator.pushReplacement(
      context,
      FadeSlideRoute(page: const MainShell()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final imageHeight = r.isLandscape ? r.h(26) : r.h(18);

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
                    'lib/assets/images/icon55.png',
                    height: imageHeight,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) =>
                        SizedBox(height: imageHeight),
                  ),
                  SizedBox(height: r.h(1.5)),
                  Text(
                    _isRegister ? 'Buat Akun' : 'Masuk',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: r.sp(7),
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: r.h(0.8)),
                  Text(
                    _isRegister
                        ? 'Daftar dulu untuk mulai bermain'
                        : 'Masuk untuk melanjutkan kuis',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: r.sp(3.8),
                      color: AppColors.textMuted,
                    ),
                  ),
                  SizedBox(height: r.h(3)),

                  // Kolom nama hanya muncul saat mendaftar.
                  AnimatedSize(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                    child: _isRegister
                        ? Padding(
                            padding: EdgeInsets.only(bottom: r.h(2)),
                            child: AuthTextField(
                              controller: _nameController,
                              label: 'Nama',
                              hint: 'Contoh: Budi',
                              textCapitalization: TextCapitalization.words,
                              validator: (v) {
                                if (!_isRegister) return null;
                                if (v == null || v.trim().isEmpty) {
                                  return 'Nama tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                          )
                        : const SizedBox(width: double.infinity),
                  ),

                  AuthTextField(
                    controller: _emailController,
                    label: 'Email',
                    hint: 'contoh@email.com',
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) {
                      final value = v?.trim() ?? '';
                      if (value.isEmpty) return 'Email tidak boleh kosong';
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'Format email tidak valid';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: r.h(2)),
                  AuthTextField(
                    controller: _passwordController,
                    label: 'Kata sandi',
                    hint: 'Minimal 6 karakter',
                    obscureText: _obscure,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _submit(),
                    suffix: GestureDetector(
                      onTap: () => setState(() => _obscure = !_obscure),
                      child: Text(
                        _obscure ? 'Lihat' : 'Tutup',
                        style: TextStyle(
                          fontSize: r.sp(3.4),
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Kata sandi tidak boleh kosong';
                      }
                      if (_isRegister && v.length < 6) {
                        return 'Minimal 6 karakter';
                      }
                      return null;
                    },
                  ),

                  if (_error != null) ...[
                    SizedBox(height: r.h(1.5)),
                    Text(
                      _error!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: r.sp(3.5),
                        color: Colors.red.shade400,
                      ),
                    ),
                  ],

                  SizedBox(height: r.h(3)),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      label: _isRegister ? 'Daftar' : 'Masuk',
                      onPressed: _submit,
                    ),
                  ),
                  SizedBox(height: r.h(1.5)),
                  TextButton(
                    onPressed: _toggleMode,
                    child: Text(
                      _isRegister
                          ? 'Sudah punya akun? Masuk'
                          : 'Belum punya akun? Daftar',
                      style: TextStyle(
                        fontSize: r.sp(3.8),
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: r.h(2)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}