import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key, required this.user}) : super(key: key);
  final User? user;

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _textfield = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String? _text;

  dynamic _pickImageError;
  bool isVideo = false;
  VideoPlayerController? _controller;
  VideoPlayerController? _toBeDisposed;
  String? _retrieveDataError;
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  @override
  void deactivate() {
    if (_controller != null) {
      _controller!.setVolume(0.0);
      _controller!.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    maxWidthController.dispose();
    maxHeightController.dispose();
    qualityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
      floatingActionButton: _buildButton(),
    );
  }

  _buildAppbar() {
    return AppBar(
      title: const Text("새 게시물", textAlign: TextAlign.center,),
      actions: [
        IconButton(onPressed: () {
          // uploadToFirebase;

          final firebaseStorageRef = FirebaseStorage.instance
              .ref()
              .child('post')
              .child('${DateTime
              .now()
              .millisecondsSinceEpoch}.jpg');

          final task = firebaseStorageRef.putFile(
              _image!, SettableMetadata(contentType: 'image/jpg'));

          task.then((value) {
            var downloadUrl = value.ref.getDownloadURL();

            downloadUrl.then((uri) {
              var doc = FirebaseFirestore.instance.collection('post').doc();
              doc.set({
                'id': doc.id,
                'photoUrl': uri.toString(),
                'contents': _textfield.text,
                'email': widget.user!.email,
                'displayName': widget.user!.displayName,
                'userPhotoUrl': widget.user!.photoURL
              }).then((onValue) {
                Navigator.pop(context);
              });
            });
          });


        }, icon: const Icon(Icons.send)),
      ],
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _image == null ? const Text("No Image") : Image.file(_image!),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _textfield,
              // onSubmitted: sendMsg,  //키보드로 엔터 클릭 시 호출
              // onChanged: checkText,  //text 가 입력될 때 마다 호출
              decoration: const InputDecoration(
                // labelText: '텍스트 입력',
                hintText: '텍스트를 입력해주세요',
                border: OutlineInputBorder(), //외곽선
              ),
              onTap: (){
                setState(() {
                  _text = _textfield.text;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      Semantics(
        label: 'image_picker_example_from_gallery',
        child: FloatingActionButton(
          onPressed: () {
            _onImageButtonPressed(ImageSource.gallery);
          },
          heroTag: 'image0',
          tooltip: 'Pick Image from gallery',
          child: const Icon(Icons.photo),
        ),
      ),
    ]);
  }

  Future _onImageButtonPressed(ImageSource gallery) async {
    XFile? image = await _picker.pickImage(source: gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  Future<void> uploadToFirebase(BuildContext context) async {
    final firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('post')
        .child('${DateTime.now().microsecondsSinceEpoch}.jpg');

    final task = await firebaseStorageRef.putFile(
        _image!, SettableMetadata(contentType: 'image/jpg'));

    final uri = await task.ref.getDownloadURL();

    final doc = FirebaseFirestore.instance.collection('post').doc();

    await doc.set({
      'id': doc.id,
      'photoUrl': uri.toString(),
      'contents': _textfield.text,
      'email': widget.user!.email,
      'displayName': widget.user!.displayName,
      'userPhotoUrl': widget.user!.photoURL
    });

    // 완료 후 앞 화면으로 이동
    Navigator.pop(context);
  }
}

//=====================================================
// Future<void> _uploadPost(BuildContext context) async {
//   final firebaseStorageRef = FirebaseStorage.instance
//       .ref()
//       .child('post')
//       .child('${DateTime.now().millisecondsSinceEpoch}.png');
//
//   final task = await firebaseStorageRef.putFile(
//       _image, SettableMetadata(contentType: 'image/png'));
//
//   final uri = await task.ref.getDownloadURL();
//
//   final doc = FirebaseFirestore.instance.collection('post').doc();
//   await doc.set({
//     'id': doc.id,
//     'photoUrl': uri.toString(),
//     'contents': textEditingController.text,
//     'email': widget.user.email,
//     'displayName': widget.user.displayName,
//     'userPhotoUrl': widget.user.photoURL
//   });
//
//   // 완료 후 앞 화면으로 이동
//   Navigator.pop(context);
// }
//
// Widget _buildBody() {
//   return _image == null ? Text('No Image') : Image.file(_image);
// }
