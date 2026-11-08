import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/responsive.dart';
import 'primary_button.dart';

class NameDialog extends StatefulWidget {
  final String categoryName;
  final String initialName;

  const NameDialog({
    super.key,
    required this.categoryName,
    this.initialName = '',
  });

  /// Tampilkan dialog. Hasilnya nama yang diisi, atau null jika dibatalkan.
  static Future<String?> show(
    BuildContext context, {
    required String categoryName,
    String initialName = '',
  }) {
    return showDialog<String>(
      context: context,
      builder: (_) => NameDialog(
        categoryName: categoryName,
        initialName: initialName,
      ),
    );
  }

  @override
  State<NameDialog> createState() => _NameDialogState();
}

class _NameDialogState extends State<NameDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(context, _controller.text.trim());
  }

  OutlineInputBorder _border(Responsive r, Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(r.sp(4)),
      borderSide: BorderSide(color: color, width: r.sp(0.6)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final imageHeight = r.isLandscape ? r.h(22) : r.h(16);
    final dialogWidth = r.isLandscape ? r.w(60) : r.w(88);

    return Dialog(
      backgroundColor: AppColors.surface,
      insetPadding: EdgeInsets.symmetric(
        horizontal: r.w(6),
        vertical: r.h(3),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(r.sp(5)),
      ),
      child: SizedBox(
        width: dialogWidth,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(r.sp(5)),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'lib/assets/images/icon22.png',
                  height: imageHeight,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => SizedBox(height: imageHeight),
                ),
                SizedBox(height: r.h(1.5)),
                Text(
                  widget.categoryName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: r.sp(5.5),
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: r.h(0.8)),
                Text(
                  'Masukkan namamu untuk memulai',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: r.sp(3.6),
                    color: AppColors.textMuted,
                  ),
                ),
                SizedBox(height: r.h(2.5)),
                TextFormField(
                  controller: _controller,
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                  style: TextStyle(
                    fontSize: r.sp(4.2),
                    color: AppColors.textDark,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    hintText: 'Contoh: Budi',
                    filled: true,
                    fillColor: AppColors.surface,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: r.sp(4),
                      vertical: r.sp(4),
                    ),
                    enabledBorder: _border(r, AppColors.border),
                    focusedBorder: _border(r, AppColors.primary),
                    errorBorder: _border(r, Colors.red.shade400),
                    focusedErrorBorder: _border(r, Colors.red.shade400),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SizedBox(height: r.h(2.5)),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        label: 'Batal',
                        outlined: true,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    SizedBox(width: r.w(3)),
                    Expanded(
                      child: PrimaryButton(
                        label: 'Mulai',
                        onPressed: _submit,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}