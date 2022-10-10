import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedWidget extends StatelessWidget {
  FeedWidget({Key? key}) : super(key: key);

  CollectionReference docu =
  FirebaseFirestore.instance.collection('post').docs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                   CircleAvatar(
                      backgroundImage: NetworkImage(docu!['userPhotoUrl']),

                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              docu!['email'],
                              style:
                              const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            StreamBuilder<DocumentSnapshot>(
                                stream: _followingStream(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const CircularProgressIndicator();
                                  }
                                  final data = snapshot.data!.data();
                                  if (data == null ||
                                      (data as Map<String, dynamic>)[
                                      docu!['email']] ==
                                          null ||
                                      data[docu!['email']] == false) {
                                    return GestureDetector(
                                      onTap: _follow,
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(
                                              height: 18,
                                              width: 18,
                                              child: Image.asset(
                                                  'images/bad_icon.png')),
                                          const Text(
                                            " 팔로우",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  return GestureDetector(
                                    onTap: _unfollow,
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(
                                            height: 18,
                                            width: 18,
                                            child: Image.asset(
                                                'images/good_icon.png')),
                                        const Text(
                                          " 언팔로우",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        ),
                        Text(docu!['displayName']),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Hero(
              tag: docu!.id,
              child: Image.network(
                docu!['photoUrl'],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                docu!['contents'],
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
