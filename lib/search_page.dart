import 'package:flutter/material.dart';
import 'package:windows_app_2/create_page.dart';
import 'package:windows_app_2/pic_view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push( context,
          MaterialPageRoute(builder: (context) => const CreatePage()),
          );
        },
        // _incrementCounter,
        tooltip: 'Increment',
        backgroundColor: Colors.amber,
        child: const Icon(Icons.account_box_outlined),
      ),
    );
  }

  Widget _buildBody() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            crossAxisCount: 3,
            childAspectRatio: 1.0),
        primary: false,
        padding: const EdgeInsets.all(8),
        itemCount: 10,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Picview(
                        height: "e.height",
                        imageurl:
                            "https://64.media.tumblr.com/88b38f715767d34d7a9d33ca93182e80/tumblr_of3e2uI1471vitnh0o4_400.jpg")),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(2),
              color: Colors.teal[100],
              child: Image.network(
                  "https://techbigs.com/uploads/2020/02/adorable-home-5717.jpg",
                  fit: BoxFit.cover),
            ),
          );
        }

        // children: <Widget>[
        //   InkWell(
        //     onTap: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => Picview(
        //                 height: "e.height",
        //                 imageurl:
        //                     "https://techbigs.com/uploads/2020/02/adorable-home-5717.jpg")),
        //       );
        //     },
        //     child: Container(
        //       padding: const EdgeInsets.all(8),
        //       color: Colors.teal[100],
        //       child: Image.network(
        //           "https://techbigs.com/uploads/2020/02/adorable-home-5717.jpg"),
        //     ),
        //   ),
        //   Container(
        //     padding: const EdgeInsets.all(8),
        //     color: Colors.teal[200],
        //     child: Image.network(
        //         "https://dbdzm869oupei.cloudfront.net/img/sticker/preview/29027.png"),
        //   ),
        //   Container(
        //     padding: const EdgeInsets.all(8),
        //     color: Colors.teal[300],
        //     child: const Text('Sound of screams but the'),
        //   ),
        //   Container(
        //     padding: const EdgeInsets.all(8),
        //     color: Colors.teal[400],
        //     child: const Text('Who scream'),
        //   ),
        //   Container(
        //     padding: const EdgeInsets.all(8),
        //     color: Colors.teal[500],
        //     child: const Text('Revolution is coming...'),
        //   ),
        //   Container(
        //     padding: const EdgeInsets.all(8),
        //     color: Colors.teal[600],
        //     child: const Text('Revolution, they...'),
        //   ),
        // ],
        );
  }
}
