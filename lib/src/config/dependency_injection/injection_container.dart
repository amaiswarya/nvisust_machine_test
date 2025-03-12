part of 'injection_container_imports.dart';

final servicelocator = GetIt.instance;
Future<void> getInit() async {
  servicelocator
    ..registerFactory(() => AuthViewModel())
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImplements());
}
