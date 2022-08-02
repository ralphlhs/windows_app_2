import 'package:flutter/material.dart';
import 'package:windows_app_2/search_page.dart';
import 'account_page.dart';
import 'home_page.dart';

class TabPage extends StatefulWidget {
  const TabPage({Key? key, required this.titlee}) : super(key: key);
  final String titlee;

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {

  int _selectedIndex = 0;

  final _pages = [
    HomePage(),
    SearchPage(title: "히요~"),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.business), label: 'KakaoT'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}