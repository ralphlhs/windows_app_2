import 'package:flutter/material.dart';
import 'package:windows_app_2/tab_page.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TabPage(title: 'Hi');
  }
}
