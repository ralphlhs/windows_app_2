import 'package:flutter/material.dart';

class Picview extends StatelessWidget {
  final height;
  final imageurl;

  Picview({Key? key, this.height, this.imageurl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$height'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: imageurl,
              child: Image.network(
                imageurl,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              '$imageurl',
              style: TextStyle(fontSize: 15),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('오빠를 위해 준비했어'),
            ),
          ],
        ),
      ),
    );
  }
}