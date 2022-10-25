import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'CommentPage.dart';

class FeedWidget extends StatefulWidget {
  FeedWidget({Key? key, required this.docu, required this.user})
      : super(key: key);

  final User? user;
  final DocumentSnapshot? docu;

  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  // List mylist = [];
  TextEditingController textinput = TextEditingController();

  late Map<String, dynamic> data;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    textinput;
  }

  CollectionReference docur = FirebaseFirestore.instance.collection('post');

  @override
  Widget build(BuildContext context) {
    //이렇게 해도되고 그냥 widget.docu!로 해도 되고. 아래에 번갈아가면서 사용.
    data = widget.docu!.data() as Map<String, dynamic>;

    // var datgullist = widget.docu!['datdatgul'] ?? 0;
    // return ListView.builder(
    //     itemCount: mylist.length,
    //     itemBuilder: (context, index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.docu!['userPhotoUrl'] ??
                    'https://t1.daumcdn.net/cfile/tistory/993C45375E6218A604'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          widget.docu!['email'] ?? '이멜없어',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                    Text(widget.docu!['displayName'] ?? 'No name'),
                  ],
                ),
              )
            ],
          ),
        ),
        Image.network(
          widget.docu!['photoUrl'] ??
              'http://www.finomy.com/news/photo/201812/61721_46421_3444.png',
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        ListTile(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              widget.docu!['datgul']?.contains(widget.user!.email) ?? false
                  ? GestureDetector(
                      onTap: _unlike,
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.pink,
                      ),
                    )
                  : GestureDetector(
                      onTap: _like, child: const Icon(Icons.favorite_border)),
              const SizedBox(
                width: 8.0,
              ),
              const Icon(Icons.comment),
              const SizedBox(
                width: 8.0,
              ),
              const Icon(Icons.send),
            ],
          ),
          trailing: const Icon(Icons.bookmark_border),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '좋아요 ${data['datgul']?.length ?? 0}개',
            style: const TextStyle(fontSize: 15),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Comment_Page(document: widget.docu!)));
            },
            child: const Text(
              '댓글 보기',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
        // Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Navigator.push( context,
        //     MaterialPageRoute(builder: (context) => Comment_Page(
        //       document: widget.docu!,
        //     )),
        //     );

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: textinput,
            onSubmitted: (text) {
              _writeComment(text);
              textinput.text = '';
            },
            decoration: InputDecoration(
                labelText: '댓글 달기',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
            inputFormatters: [
              FilteringTextInputFormatter.deny(
                  RegExp(r'(idiot|donkey|fool|바보|병신|등신|보지|자지|씹질|fuck|씨팔|씨발|)',
                      caseSensitive: false),
                  replacementString: '***')
            ],
          ),
        ),
      ],
    );
    // });
  }

  void _like() {
    final List listdatum = List<String?>.from(data['datgul'] ?? []);
    listdatum.add(widget.user!.email);
    final updateData = {'datgul': listdatum};
    FirebaseFirestore.instance
        .collection('post')
        .doc(widget.docu!.id)
        .update(updateData);
  }

  void _unlike() {
    final List listdata = List<String?>.from(data['datgul'] ?? []);
    listdata.remove(widget.user!.email);
    final updateData = {'datgul': listdata};
    FirebaseFirestore.instance
        .collection('post')
        .doc(widget.docu!.id)
        .update(updateData);
  }

  void _writeComment(String text) {
    // final List listdatumm = List<String?>.from(widget.docu!['comment'] ?? []);
    // listdatumm.add(widget.user!.email);
    final Map<String, dynamic> updateData = {'writer': widget.user!.email,'comment':text};
    FirebaseFirestore.instance
        .collection('post')
        .doc(widget.docu!.id)
        .collection('comment')
        .add(updateData);
  }
}
