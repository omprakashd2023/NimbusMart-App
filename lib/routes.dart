import 'package:flutter/material.dart';

//Pages
import './features/auth/pages/auth_page.dart';

class Routes{
  static const String authRoute = '/auth-screen';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.authRoute:
      return MaterialPageRoute<dynamic>(
        builder: (_) => const AuthPage(),
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