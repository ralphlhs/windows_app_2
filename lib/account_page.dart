import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  _buildAppbar() {
    AppBar(
      title: const Text("Instagram Clon", textAlign: TextAlign.center),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.exit_to_app),
        )
      ],
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(children: <Widget>[
            Stack(alignment: Alignment.center, children: [
              const SizedBox(
                height: 100,
                width: 100,
                child: CircleAvatar(
                    foregroundImage: NetworkImage(
                        "https://imgnews.pstatic.net/image/031/2022/07/26/0000687803_001_20220726110601140.jpg?type=w647")),
              ),
              Container(
                width: 100.0,
                height: 100.0,
                alignment: Alignment.bottomRight,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const SizedBox(
                      height: 35,
                      width: 35,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                      ),
                    ),
                    SizedBox(
                        height: 30,
                        width: 30,
                        child: FloatingActionButton(
                          onPressed: () {},
                          child: const Icon(Icons.add),
                        )),
                  ],
                ),
              ),
            ]),
            const Padding(padding: EdgeInsets.all(8.0)),
            Text(user.displayName!),
          ]),
          const SizedBox(
            height: 30,
            width: 30,
          ),
          const Text(
            "0\n게시물",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
          ),
          const Text(
            "0\n팔로어",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
          ),
          const Text(
            "0\n팔로잉",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
