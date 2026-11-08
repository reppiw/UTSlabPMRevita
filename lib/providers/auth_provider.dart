import 'package:flutter/foundation.dart';
import '../models/account.dart';

class AuthProvider extends ChangeNotifier {
  final List<Account> _accounts = [];
  Account? _current;

  Account? get currentUser => _current;
  bool get isLoggedIn => _current != null;

  String _normalize(String email) => email.trim().toLowerCase();

  String? register({
    required String name,
    required String email,
    required String password,
  }) {
    final key = _normalize(email);
    if (_accounts.any((a) => a.email == key)) {
      return 'Email sudah terdaftar, silakan masuk.';
    }
    final account = Account(
      name: name.trim(),
      email: key,
      password: password,
    );
    _accounts.add(account);
    _current = account;
    notifyListeners();
    return null;
  }

  String? login({required String email, required String password}) {
    final key = _normalize(email);
    final matches =
        _accounts.where((a) => a.email == key && a.password == password);
    if (matches.isEmpty) return 'Email atau kata sandi salah.';
    _current = matches.first;
    notifyListeners();
    return null;
  }

  void logout() {
    _current = null;
    notifyListeners();
  }
}