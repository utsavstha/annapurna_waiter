import 'package:annapurna/ui/dashboard/dashboard.dart';
import 'package:annapurna/ui/orders/take_order.dart';
import 'package:annapurna/ui/user/login_page_ui.dart';

import 'app_pages.dart';

/// Provies static  variables for routing
class AppPages {
  static const initial = Routes.login;
  static final routes = {
    Routes.dashboard: (context) => Dashboard(),
    Routes.login: (context) => LoginPage(),
    Routes.takeOrder: (context) => TakeOrder(),
  };
}
