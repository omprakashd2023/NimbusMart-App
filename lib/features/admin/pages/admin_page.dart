import 'package:flutter/material.dart';

import './posts_page.dart';
import './analytics_page.dart';
import './orders_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _page = 0;
  final double _bottomBarWidth = 42.0;
  final double _bottomBarBorderWidth = 5.0;
  List<Widget> pages = [
    const PostsPage(),
    const AnalyticsPage(),
    const OrdersPage(),
  ];
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
              const Text(
                'Admin',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        iconSize: 28,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.amber[800],
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Container(
              width: _bottomBarWidth,
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(
                  width: _bottomBarBorderWidth,
                  color: _page == 0 ? Colors.amber : Colors.transparent,
                ),
              )),
              child: const Icon(Icons.post_add_outlined),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: _bottomBarWidth,
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(
                  width: _bottomBarBorderWidth,
                  color: _page == 1 ? Colors.amber : Colors.transparent,
                ),
              )),
              child: const Icon(Icons.analytics_outlined),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: _bottomBarWidth,
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(
                  width: _bottomBarBorderWidth,
                  color: _page == 2 ? Colors.amber : Colors.transparent,
                ),
              )),
              child: const Icon(Icons.all_inbox_outlined),
            ),
            label: '',
          ),
        ],
      ),
      body: pages[_page],
    );
  }
}
