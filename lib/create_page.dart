import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _textfield = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;

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
      title: const Text("새 게시물", textAlign: TextAlign.center),
      actions: [
        IconButton(
            onPressed: () {
              final firebaseStorageRef = FirebaseStorage.instance
                  .ref()
                  .child('post')
                  .child('${DateTime.now().microsecondsSinceEpoch}.png');
              final task = firebaseStorageRef.putFile(
                  _image!, SettableMetadata(contentType: 'image/png'));
              task.then((value) {
                var downloadUrl = value.ref.getDownloadURL();
              });
            },
            icon: const Icon(Icons.send))
      ],
    );
  }

  _buildBody() {
    return Column(
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
          ),
        ),
      ],
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
}
