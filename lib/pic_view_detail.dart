import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PicViewDetail extends StatelessWidget {
  const PicViewDetail({Key? key, required this.docu}) : super(key: key);
  final DocumentSnapshot? docu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
          children: [
            SizedBox(
              width: 400.0,
              height: 678.0,
              child: SingleChildScrollView(
                child: Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Column(children: <Widget>[
                      Image.network(
                        docu!['userPhotoUrl'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      const SizedBox(
                        width: 100.0,
                        height: 30.0,
                      ),
                      Text(docu!['displayName']),
                      Text(docu!['email']),
                      const SizedBox(
                        width: 100.0,
                        height: 40.0,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("되돌아가기"),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),

    );
  }
}