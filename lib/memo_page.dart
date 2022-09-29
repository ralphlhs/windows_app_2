import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

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

  //data 얻는 방법 1.
  void adfa() async {
    DocumentReference documentReference =
        collectionReference.doc('BhHOZL2cKON5RNyyib4R');
    DocumentSnapshot documentSnapshot = await documentReference.get();
    print(documentSnapshot.data());
    print('이 머저리');
  }

  //data 얻는 방법 2.
  void abcd() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('memo').get();
    List<QueryDocumentSnapshot> list = querySnapshot.docs;
    list.forEach((element) {
      print(element.data());
    });
  }

  @override
  void initState() {
    super.initState();
    text01;
    text02;
  }

  @override
  Widget build(BuildContext context) {
    DocumentReference documentReference = collectionReference.doc();
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
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          List<QueryDocumentSnapshot> docu = snapshot.data?.docs ?? [];
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
                          Text(docu[index]['name'] == ''
                              ? '이름을 쓰시오'
                              : docu[index]['name']),
                          Text(docu[index]['amount'] == ''
                              ? '-숫자를 쓰시오-'
                              : '${docu[index]['amount']}'),
                        ],
                      ),
                      const SizedBox(
                        width: 120.0,
                      ),
                      IconButton(
                        onPressed: () {
                          _amendText(docu[index]);
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
                          _deleteText(docu[index]);
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

  Future<void> _addText() async {
    // final documentReference = collectionReference.doc().set({'data': 'adfads'});
    await showModalBottomSheet<void>(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "입력할 메모를 작성하세요",
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
                        //또는 collectionReference.add({})
                        collectionReference.doc().set({
                          'id': widget.user!.email,
                          'name': text01.text,
                          'amount': int.parse(text02.text.trim()),
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('올리기'),
                    ),
                  ],
                ),
              ),

          );
        });
  }

  Future<void> _amendText(snapshot) async {
    await showModalBottomSheet<void>(
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
                      "메모의 내용을 수정하세요",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                      child: TextField(
                        controller: text01,
                        decoration: InputDecoration(
                          helperText: snapshot['name'],
                          hintText: snapshot['name'],
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(
                              RegExp(r'(idiot|donkey|fool)',
                                  caseSensitive: false),
                              replacementString: '***')
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: text02,
                        decoration: InputDecoration(
                            labelText: snapshot['amount'],
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50))),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        collectionReference.doc(snapshot.id).update({
                          'id': widget.user!.email,
                          'name': text01.text,
                          'amount': text02.text,
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('수정하기'),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> _deleteText(snapshot) async {
    // final documentReference = collectionReference.doc().set({'data': 'adfads'});
    await showModalBottomSheet<void>(
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
                      "아래의 내용을 삭제",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                      child: Text(
                        snapshot['name'],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                      child: Text(
                        snapshot['amount'],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _showDialog(snapshot);
                        // collectionReference.doc(snapshot.id).delete();
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(content: Text(snapshot['name']+', '+snapshot['amount']+'  를  ' '삭제하였습니다')));
                      },
                      child: const Text('삭제하기'),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _showDialog(snapshot) {
    showDialog(
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
                _diallogagain(snapshot);
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

  void _diallogagain(snapshot) {
    showDialog(
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
                abcd();
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
