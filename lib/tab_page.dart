import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:windows_app_2/search_page.dart';
import 'account_page.dart';
import 'home_page.dart';
import 'memo_page.dart';

class TabPage extends StatefulWidget {
  const TabPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIndex = 0;
  late List _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(user: widget.user),
      SearchPage(user: widget.user),
      MemoPage(user: widget.user),
      AccountPage(user: widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 23.0,
        selectedFontSize: 14.0,
        unselectedFontSize: 11.0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'KakaoT'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.airport_shuttle), label: 'Memo'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
