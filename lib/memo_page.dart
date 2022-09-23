import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MemoPage extends StatefulWidget {
  const MemoPage({Key? key, required this.user}) : super(key: key);
  final User? user;

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('memo');
  final TextEditingController text01 = TextEditingController();
  final TextEditingController text02 = TextEditingController();

  @override
  void initState() {
    super.initState();
    text01;
    text02;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.user!.displayName!)),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return StreamBuilder(
        stream: collectionReference.doc().snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
// final DocumentSnapshot docu = snapshot.data;
          return ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 100,
                width: 10,
                child: Card(
                  margin: const EdgeInsets.all(7),
                  shape: RoundedRectangleBorder(
//모서리를 둥글게 하기 위해 사용
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 8.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Content Number1 ${index}'),
                          Text('Content Number2 ${index}'),
                        ],
                      ),
                      const SizedBox(
                        width: 120.0,
                      ),
                      IconButton(
                        onPressed: () {
                          _addText();
                        },
                        icon: const Icon(Icons.add),
                        color: Colors.teal,
                        iconSize: 30.0,
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      IconButton(
                        onPressed: () {
                          _deleteText();
                        },
                        icon: const Icon(Icons.remove),
                        color: Colors.red,
                        iconSize: 30.0,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  void _addText() {
    // final documentReference = collectionReference.doc().set({'data': 'adfads'});
    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 250,
            color: Colors.transparent,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: text01,
                        decoration: const InputDecoration(
                          labelText: 'Input',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: text02,
                        decoration: const InputDecoration(
                          labelText: 'Input',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _deleteText() {}
}
