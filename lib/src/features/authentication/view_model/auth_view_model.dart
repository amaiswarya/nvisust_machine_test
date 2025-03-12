import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nvisust_test/src/config/dependency_injection/injection_container_imports.dart';
import 'package:nvisust_test/src/core/utils/helpers/toast.dart';
import 'package:nvisust_test/src/features/authentication/repo/auth_repo.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  FutureOr<void> googleLogin(String email, String password) async {
    try {
      final response = await servicelocator<AuthRepo>().signIn(email, password);
      response.fold((fail) {
        _isLoading = false;
        showErrorToast("Something went wrong!");
      }, (right) {
        _isLoading = false;
        showSuccessToast("Login Successful");
      });
    } catch (e) {
      showErrorToast(e.toString());
    }
  }
}
