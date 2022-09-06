import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Picview extends StatelessWidget {
  final User? user;
  final DocumentSnapshot? snapshot;

  Picview({Key? key, required this.user, required this.snapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user!.displayName!),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(snapshot!['userPhotoUrl']),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              snapshot!['email'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: _follow,
                              child: const Text(
                                "팔로우",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Text(snapshot!['displayName']),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Hero(
              tag: snapshot!['photoUrl'],
              child: Image.network(
                snapshot!['photoUrl'],
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Text(
                snapshot!['contents'],
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Image.network(
            'https://www.freeiconspng.com/uploads/blue-back-undo-return-button-png-15.png'),
      ),
    );
  }

  void _follow() {}
}
