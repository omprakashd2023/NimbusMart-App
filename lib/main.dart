import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//Routes
import './routes.dart';
import './features/auth/pages/auth_page.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const ECommerce());
}

//todo: Add a custom theme

class ECommerce extends StatelessWidget {
  const ECommerce({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const AuthPage(),
    );
  }
}
