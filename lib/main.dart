import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

//Routes
import './routes.dart';
import './features/auth/pages/auth_page.dart';
import './features/home/pages/home_page.dart';

import './features/auth/services/auth_service.dart';

import './provider/user_provider.dart';

void main() async {
  await dotenv.load();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const NimbusMart(),
    ),
  );
}

//todo: Add a custom theme

class NimbusMart extends StatefulWidget {
  const NimbusMart({super.key});

  @override
  State<NimbusMart> createState() => _NimbusMartState();
}

class _NimbusMartState extends State<NimbusMart> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    _authService.autoLogin(
      context: context,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NimbusMart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? const HomePage()
          : const AuthPage(),
    );
  }
}