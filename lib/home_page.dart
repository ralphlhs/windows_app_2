import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(width: 300.0, height: 450.0,
          child: Card(
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(children: const <Widget>[
                CircleAvatar(
                  radius: 60.0,
                  backgroundImage: NetworkImage(
                      "https://imgnews.pstatic.net/image/031/2022/07/26/0000687803_001_20220726110601140.jpg?type=w647"),
                ),
                Text("e-mail"),
                Text("name"),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
