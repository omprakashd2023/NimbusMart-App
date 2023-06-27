import 'package:flutter/material.dart';

//Pages
import './features/auth/pages/auth_page.dart';
import './features/home/pages/home_page.dart';
import './common/widgets/bottom_appbar.dart';
import './features/admin/pages/admin_page.dart';
import './features/admin/pages/add_product_page.dart';

class Routes {
  //Route names
  static const String authRoute = '/auth-page';
  static const String homeRoute = '/home-page';
  static const String adminRoute = '/admin-page';
  static const String bottomBar = '/bottom-bar';
  static const String addProduct = '/add-product';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.authRoute:
      return MaterialPageRoute<dynamic>(
        builder: (_) => const AuthPage(),
        settings: settings,
      );
    case Routes.homeRoute:
      return MaterialPageRoute<dynamic>(
        builder: (_) => const HomePage(),
        settings: settings,
      );
    case Routes.bottomBar:
      return MaterialPageRoute<dynamic>(
        builder: (_) => const BottomBar(),
        settings: settings,
      );
    case Routes.adminRoute:
      return MaterialPageRoute<dynamic>(
        builder: (_) => const AdminPage(),
        settings: settings,
      );
    case Routes.addProduct:
      return MaterialPageRoute<dynamic>(
        builder: (_) => const AddProductPage(),
        settings: settings,
      );
    default:
      return MaterialPageRoute<dynamic>(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
        settings: settings,
      );
  }
}
