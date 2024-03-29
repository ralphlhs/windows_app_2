import 'package:flutter/material.dart';
import 'package:windows_app_2/tab_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'loginPage.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData == null) {
              return const LogInIn();
            } else {
              return
              //
              const TabPage(titlee: "{snapshot!.data.displayName}님 반갑습니다.");



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
        ),
      ),
    );
  }
}
