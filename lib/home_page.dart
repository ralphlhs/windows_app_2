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
                    const CircleAvatar(
                      radius: 60.0,
                      backgroundImage: NetworkImage(
                          "https://cf.bstatic.com/xdata/images/hotel/max1024x768/183655908.jpg?k=9ef9b22c28d993f3efd23a27e2c8aa2f43e3da805d0383bd769b166f0b537c20&o=&hp=1"),
                    ),
                    const SizedBox(
                      width: 100.0,
                      height: 30.0,
                    ),
                    const Text("e-mail"),
                    const Text("{widget.snapshot.data.displayName}"),
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
