import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;

import '../../features/home/pages/home_page.dart';
import '../../features/account/pages/account_page.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  final double _bottomBarWidth = 42.0;
  final double _bottomBarBorderWidth = 5.0;

  List<Widget> pages = [
    const HomePage(),
    const AccountPage(),
    const Center(child: Text('Cart')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: const Icon(Icons.home_outlined),
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
              child: const Icon(Icons.person_outline),
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
              child: badge.Badge(
                badgeStyle: const badge.BadgeStyle(
                  badgeColor: Colors.black54,
                ),
                position: badge.BadgePosition.topEnd(
                  top: -10.0,
                  end: 8.0,
                ),
                badgeContent: const Text(
                  '3',
                  style: TextStyle(color: Colors.white),
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                ),
              ),
            ),
            label: '',
          ),
        ],
      ),
      body: pages[_page],
    );
  }
}
