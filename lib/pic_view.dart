import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Picview extends StatelessWidget {
  final User? user;
  final DocumentSnapshot? docu;
  CollectionReference collectionReference =
  FirebaseFirestore.instance.collection('post');

  Picview({Key? key, required this.user, required this.docu})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(user!.displayName!),
      // ),
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Image.asset('images/blue_button.png')),
          const SizedBox(
            height: 30.0,
          ),
          FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () {
                _showDialog(context, docu);
                // collectionReference
                //     .doc(docu!.id)
                //     .delete();
                // Navigator.pop(context);
              },
              child: Image.asset('images/trash.png')),
        ],
      ),
    );
  }

  void _follow() {
    FirebaseFirestore.instance
        .collection('following')
        .doc(user!.email)
        .set({docu!['email']: true});
    FirebaseFirestore.instance
        .collection('follower')
        .doc(docu!['email'])
        .set({user!.email!: true});
  }

  void _unfollow() {
    FirebaseFirestore.instance.collection('following').doc(user!.email).set({
      docu!['email']: false,
    });
    FirebaseFirestore.instance.collection('follower').doc(docu!['email']).set({
      user!.email!: false,
    });
  }

  Stream<DocumentSnapshot> _followingStream() {
    return FirebaseFirestore.instance
        .collection('following')
        .doc(user!.email)
        .snapshots();
  }

  void _showDialog(context, snapshot) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("정말 삭제하시겠습니까?"),
          content: const Text("삭제되면 복구가 불가능합니다"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('취소'),
            ),
            const SizedBox(
              width: 30.0,
            ),
            ElevatedButton(
              onPressed: () {
                collectionReference.doc(snapshot.id).delete();
                Navigator.pop(context);
                _diallogagain(context, snapshot);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: SizedBox(
                        height: 50.0,
                        child: Center(
                            child: Text(snapshot['name'] +
                                ', ' +
                                snapshot['amount'] +
                                '  를  \n' '삭제하였습니다')))));
              },
              child: const Text('진짜 삭제하기'),
            ),
          ],
        );
      },
    );
  }

  void _diallogagain(context, snapshot) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: const SizedBox(
              height: 80, width: 200, child: Center(child: Text("삭제되었습니다."))),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Center(child: Text('창닫기')),
            ),
            const SizedBox(
              width: 30.0,
            ),
          ],
        );
      },
    );
  }
}
