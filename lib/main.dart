import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nvisust_test/firebase_options.dart';
import 'package:nvisust_test/my_app.dart';
import 'package:nvisust_test/src/config/dependency_injection/injection_container_imports.dart';
import 'package:nvisust_test/src/config/preference_config/preference_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getInit();
  await SharedPref().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
