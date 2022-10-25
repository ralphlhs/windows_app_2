import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Comment_Page extends StatelessWidget {
  Comment_Page({Key? key, required this.document}) : super(key: key);
  final DocumentSnapshot document;
  final List<Map<String, dynamic>> dummyItems = [
    {
      'writer': '아무개',
      'comment': '댓글',
    },
    {
      'writer': '아무개',
      'comment': '댓글',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('댓글'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('post')
              .doc(document.id)
              .collection('comment')
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!.docs.map((e) {
                  return ListTile(
                    leading: Text(e['writer']),
                    title: Text(
                      e['comment'],
                    ),
                  );
                }).toList(),
              );

              //     ListView.separated(
              //       padding: const EdgeInsets.all(8),
              //       itemBuilder: (BuildContext context, int index) {
              //         return ListTile(leading: Text(snapshot.data!.doc()['writer']),
              //           title: Text(snapshot.data!.doc()[index]['comment'],));
              //       },
              //       itemCount: dummyItems.length,
              //       separatorBuilder: (BuildContext context, int index) {
              //         return const Divider(color: Colors.red, thickness: 2.0);
              //       });

            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
