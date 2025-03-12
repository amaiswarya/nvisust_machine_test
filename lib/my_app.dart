import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nvisust_test/routes_manager/route_imports.dart';
import 'package:nvisust_test/src/core/utils/helpers/providers.dart';
import 'package:nvisust_test/src/core/utils/styles/app_theme.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ));

    return MultiProvider(
        providers: Providers.providerLists,
        child: MaterialApp.router(
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.noScaling),
              child: child!,
            );
          },
          theme: AppTheme.theme,
          routerConfig: AppRouter().config(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
