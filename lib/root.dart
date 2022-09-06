import 'package:flutter/material.dart';
import 'package:windows_app_2/tab_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'loading_page.dart';
import 'loginPage.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingPage();
        } else {
          if (snapshot.hasData) {
            return TabPage(user: snapshot.data!);
          } else {
            return const LoginPage();
          }

          //   Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text("${snapshot.data.displayName}님 반갑습니다."),
          //       TextButton(
          //         child: Text("로그아웃"),
          //         onPressed: () {
          //           FirebaseAuth.instance.signOut();
          //         },
          //       ),
          //     ],
          //   ),
          // );

        }
      },
    );
  }
}

class Merong extends StatelessWidget {
  const Merong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text("메롱 약오르지",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
    );
  }
}
