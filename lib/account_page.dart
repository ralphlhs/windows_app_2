import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 2.0,
          child: Column(children: const <Widget>[
            CircleAvatar(foregroundImage: NetworkImage("https://imgnews.pstatic.net/image/031/2022/07/26/0000687803_001_20220726110601140.jpg?type=w647")),
            Text("e-mail"),
            Text("name"),
          ]),
        ),
      ),
    );
  }
}
