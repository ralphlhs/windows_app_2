import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text("인스타그램에 오신것을 환영합니다.",
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center),
            ),
            SizedBox(
              width: 300.0,
              height: 450.0,
              child: Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(children: <Widget>[
                    CircleAvatar(
                      radius: 60.0,
                      backgroundImage: NetworkImage(
                          user.photoURL!),
                    ),
                    const SizedBox(
                      width: 100.0,
                      height: 30.0,
                    ),
                    Text(user.displayName!),
                    Text(user.email!),
                    const SizedBox(
                      width: 100.0,
                      height: 70.0,
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text("팔로우"),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
