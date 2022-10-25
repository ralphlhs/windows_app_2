import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'feed_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.user}) : super(key: key);
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('post');

  final User user;

  @override
  Widget build(BuildContext context) {
    DocumentReference documentReference = collectionReference.doc();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Instagram Clone",
          style: GoogleFonts.pacifico(),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: collectionReference.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          List<QueryDocumentSnapshot> docu = snapshot.data?.docs ?? [];
          if (!snapshot.hasData) {
            return _buildNoPostBody();
          }
          return _buildHasPostBody(docu);
        },
      ),
    );
  }

  Widget _buildHasPostBody(List<DocumentSnapshot> docus) {
    List mylist =
        docus.where((doc) => doc['email'] == user.email).take(3).toList();
    List otherlist =
        docus.where((doc) => doc['email'] != user.email).take(3).toList();
    mylist.addAll(otherlist);
    return mylist.length != 0 ?
      ListView(children:
    mylist.map((e) => FeedWidget(user: user, docu: e)).toList(),)
        : const Center(
        child: Text('데이터가 없음'),);
  }

  Widget _buildNoPostBody() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Instagram에 오신 것을 환영합니다',
              style: TextStyle(fontSize: 24.0),
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            const Text('사진과 동영상을 보려면 팔로우하세요.'),
            const Padding(padding: EdgeInsets.all(16.0)),
            SizedBox(
              width: 260.0,
              child: Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: 80.0,
                        height: 80.0,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(user.photoURL!),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.all(8.0)),
                      Text(
                        user.email!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(user.displayName!),
                      const Padding(padding: EdgeInsets.all(8.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 70.0,
                            height: 70.0,
                            child: Image.network(
                                'https://cdn.pixabay.com/photo/2017/09/21/19/12/france-2773030_1280.jpg',
                                fit: BoxFit.cover),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(1.0),
                          ),
                          SizedBox(
                            width: 70.0,
                            height: 70.0,
                            child: Image.network(
                                'https://cdn.pixabay.com/photo/2017/06/21/05/42/fog-2426131_1280.jpg',
                                fit: BoxFit.cover),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(1.0),
                          ),
                          SizedBox(
                            width: 70.0,
                            height: 70.0,
                            child: Image.network(
                                'https://cdn.pixabay.com/photo/2019/02/04/20/07/flowers-3975556_1280.jpg',
                                fit: BoxFit.cover),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.all(4.0)),
                      const Text('Facebook 친구'),
                      const Padding(padding: EdgeInsets.all(4.0)),
                      ElevatedButton(
                        child: const Text('팔로우'),
                        onPressed: () => print('팔로우 클릭'),
                      ),
                      const Padding(padding: EdgeInsets.all(4.0))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
