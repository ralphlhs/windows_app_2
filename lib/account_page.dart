import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key, required this.user}) : super(key: key);
  final User user;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black45,
        backgroundColor: Colors.white,
        title: Text(
          'Instagram Clone',
          style: GoogleFonts.pacifico(fontSize: 20.0, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              _handleSignOut();
              // FirebaseAuth.instance.signOut();
              // _googleSignIn.signOut();
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('post');
    DocumentReference documentReference = FirebaseFirestore.instance.collection('following').doc(user.email);
    return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(children: <Widget>[
                  Stack(alignment: Alignment.center, children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                          foregroundImage: NetworkImage(user.photoURL!)),
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
                StreamBuilder<QuerySnapshot>(
                  stream: collectionReference.snapshots(),
                  builder: (context, snapshot) {
                    var num = 0;
                    if(snapshot.hasData){
                      num = snapshot.data!.docs.length;
                    }
                    return Text(
                      "$num\n게시물",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18.0),
                    );
                  }
                ),
                StreamBuilder<DocumentSnapshot>(
                  stream: documentReference.snapshots(),
                  builder: (context, snapshot) {
                    var num01 = 0;
                    if(snapshot.hasData){
                      num01 = snapshot.data!.id.length;
                    }
                    return Text(
                      "$num01\n팔로어",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18.0),
                    );
                  }
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

  // 내 게시물 가져오기
  Stream<QuerySnapshot>_myStream() {
    return FirebaseFirestore.instance.collection('post').snapshots();
  }
// 팔로잉 가져오기
Stream<DocumentSnapshot> _myFollowing(){
    return FirebaseFirestore.instance.collection('follower').doc(user.email).snapshots();

}
// 팔로워 가져오기
}
