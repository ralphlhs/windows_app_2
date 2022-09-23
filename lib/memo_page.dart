import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addText();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    return StreamBuilder<QuerySnapshot>(
        stream: collectionReference.snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          var docu = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemCount: docu.length,
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
                          Text(docu[index]['name']),
                          Text(docu[index]['amount']),
                        ],
                      ),
                      const SizedBox(
                        width: 120.0,
                      ),
                      IconButton(
                        onPressed: () {
                          _amendText();
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
            height: 320,
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
                    const Text(
                      "입력할 메모를 작성하세요.",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: text01,
                        decoration: const InputDecoration(
                          labelText: '글 내용',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: text02,
                        decoration: const InputDecoration(
                          labelText: '액수',
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        collectionReference.doc().set({
                          'id': widget.user!.email,
                          'name': text01.text,
                          'amount': text02.text,
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('올리기'),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _amendText() {}

  void _deleteText() {}
}
