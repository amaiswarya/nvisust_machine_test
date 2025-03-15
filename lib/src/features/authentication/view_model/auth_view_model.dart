import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nvisust_test/routes_manager/route_imports.gr.dart';
import 'package:nvisust_test/src/config/dependency_injection/injection_container_imports.dart';
import 'package:nvisust_test/src/core/utils/helpers/toast.dart';
import 'package:nvisust_test/src/core/utils/shared_utils/preference_utils.dart';
import 'package:nvisust_test/src/features/authentication/model/user_model.dart';
import 'package:nvisust_test/src/features/authentication/repo/auth_repo.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  FutureOr<void> googleLogin(
      String email, String password, BuildContext context) async {
    try {
      final response = await servicelocator<AuthRepo>().signIn(email, password);

      response.fold((fail) {
        _isLoading = false;
        showErrorToast(fail.message);
      }, (User user) async {
        await SharedUtils.setUUID(user.uid);
        final data = UserModel(
          name: user.displayName,
          email: email,
          uuid: user.uid,
        );

        final result = await servicelocator<AuthRepo>().addUser(data);

        result.fold((fail) {
          _isLoading = false;
          showErrorToast(fail.message);
        }, (right) async {
          _isLoading = false;
          context.replaceRoute(DashboardRoute());
        });
      });
    } catch (e) {
      showErrorToast(e.toString());
    }
  }
}
