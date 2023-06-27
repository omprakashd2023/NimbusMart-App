import 'package:flutter/material.dart';

import '../widgets/header_section.dart';
import '../widgets/button_tile.dart';
import '../widgets/orders.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          elevation: 0.0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1E88E5),
                  Color(0xFF64B5F6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 120,
                  height: 45.0,
                  // color: Colors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.notifications_outlined,
                      size: 28.0,
                      color: Colors.black,
                    ),
                    SizedBox(width: 15.0),
                    Icon(
                      Icons.search_outlined,
                      size: 28.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const HeaderSection(),
          const SizedBox(height: 10.0),
          Column(
            children: [
              Row(
                children: [
                  ButtonTile(
                    text: 'Your Orders',
                    onPressed: () {},
                  ),
                  ButtonTile(
                    text: 'Turn Seller',
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  ButtonTile(
                    text: 'Your Wishlist',
                    onPressed: () {},
                  ),
                  ButtonTile(
                    text: 'Logout',
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          const Orders(),
        ],
      ),
    );
  }
}
