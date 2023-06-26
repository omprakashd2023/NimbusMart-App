import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Welcome ${user.user.name}'),
            Text('Your Email: ${user.user.email}'),
          ],
        ),
      ),
    );
  }
}
