import 'package:flutter/material.dart';

//Pages
import './features/auth/pages/auth_page.dart';
import './features/home/pages/home_page.dart';

class Routes {
  static const String authRoute = '/auth-page';
  static const String homeRoute = '/home-page';
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
