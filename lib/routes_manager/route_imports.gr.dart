// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:nvisust_test/src/features/authentication/view/login.dart'
    as _i4;
import 'package:nvisust_test/src/features/dashboard/view/dashboard.dart' as _i2;
import 'package:nvisust_test/src/features/leave_management/view/apply_leave.dart'
    as _i1;
import 'package:nvisust_test/src/features/leave_management/view/leave_dashboard.dart'
    as _i3;

/// generated route for
/// [_i1.ApplyLeave]
class ApplyLeaveRoute extends _i5.PageRouteInfo<void> {
  const ApplyLeaveRoute({List<_i5.PageRouteInfo>? children})
    : super(ApplyLeaveRoute.name, initialChildren: children);

  static const String name = 'ApplyLeaveRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.ApplyLeave();
    },
  );
}

/// generated route for
/// [_i2.Dashboard]
class DashboardRoute extends _i5.PageRouteInfo<void> {
  const DashboardRoute({List<_i5.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.Dashboard();
    },
  );
}

/// generated route for
/// [_i3.LeaveDashboard]
class LeaveDashboardRoute extends _i5.PageRouteInfo<void> {
  const LeaveDashboardRoute({List<_i5.PageRouteInfo>? children})
    : super(LeaveDashboardRoute.name, initialChildren: children);

  static const String name = 'LeaveDashboardRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.LeaveDashboard();
    },
  );
}

/// generated route for
/// [_i4.Login]
class LoginRoute extends _i5.PageRouteInfo<void> {
  const LoginRoute({List<_i5.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.Login();
    },
  );
}
