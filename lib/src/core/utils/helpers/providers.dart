import 'package:nvisust_test/src/features/authentication/view_model/auth_view_model.dart';
import 'package:nvisust_test/src/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Providers {
  static List<SingleChildWidget> providerLists = [
    ChangeNotifierProvider(create: (context) => AuthViewModel()),
    ChangeNotifierProvider(create: (context) => DashboardViewModel()),
  ];
}
