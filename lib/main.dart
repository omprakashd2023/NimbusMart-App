import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

//Routes
import './routes.dart';
import './features/auth/pages/auth_page.dart';

import './features/auth/services/auth_service.dart';

import './provider/user_provider.dart';

import './common/widgets/bottom_appbar.dart';
import './features/admin/pages/admin_page.dart';

void main() async {
  await dotenv.load();
  runApp(
    const NimbusMart(),
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: Consumer<UserProvider>(
        builder: (context, userData, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'NimbusMart',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            onGenerateRoute: (settings) => generateRoute(settings),
            home: userData.isAuth
                ? userData.user.type == 'user'
                    ? const BottomBar()
                    : const AdminPage()
                : FutureBuilder(
                    future: _authService.autoLogin(
                      context: context,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Scaffold(
                          body: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        return const AuthPage();
                      }
                    },
                  ),
          );
        },
      ),
    );
  }
}
