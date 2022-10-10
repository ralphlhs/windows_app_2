import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key, required this.user}) : super(key: key);
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('post');

  final User user;

  @override
  Widget build(BuildContext context) {
    List<QueryDocumentSnapshot> docu = collectionReference.data!.docs ?? [];
    return Scaffold(
      body: StreamBuilder(
        stream: ,
        builder: (context, snapshot){},

      ),



      _buildHasPostBody(collectionReference),
    );
  }

  Widget _buildHasPostBody(List<DocumentSnapshot> docu) {

          List abc = docu
          .where(docu['email'] == user.email)
          .take(5)
          .toList();
  }



}
