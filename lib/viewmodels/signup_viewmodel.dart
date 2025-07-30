import 'package:flutter/material.dart';
import 'package:nike_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool isLoading = false;
  String? errorMessage;

  Future<User?> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      final user = await _authService.signUpWithEmail(
        email: email,
        password: password,
      );

      isLoading = false;
      notifyListeners();
      return user;
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message;
      isLoading = false;
      notifyListeners();
      return null;
    }
  }
}
