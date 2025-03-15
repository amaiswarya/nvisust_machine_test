part of 'route_imports.dart';

@AutoRouterConfig(replaceInRouteName: 'Route')
class AppRouter extends RootStackRouter {
  RouteType get defualtType => const RouteType.cupertino();
  @override
  List<AutoRoute> get routes => [
        CupertinoRoute<dynamic>(page: LoginRoute.page, initial: true),
        CupertinoRoute<dynamic>(
          page: DashboardRoute.page,
          // initial: true,
        ),
      ];
}
