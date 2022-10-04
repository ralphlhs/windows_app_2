import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:windows_app_2/create_page.dart';
import 'package:windows_app_2/pic_view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.user}) : super(key: key);
  final User? user;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: _buildAppBar() as PreferredSizeWidget?,
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CreatePage(user: widget.user!)),
          );
        },
        // _incrementCounter,
        tooltip: 'Increment',
        backgroundColor: Colors.amber,
        child: const Icon(Icons.account_box_outlined),
      ),
    );
  }

  Widget _buildAppBar() {
   return AppBar(
      title: Text(widget.user!.displayName!,
          style: const TextStyle(color: Colors.black)),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildBody() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('post').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var _items = snapshot.data!.docs ?? [];
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 3,
                childAspectRatio: 1.0),
            primary: false,
            padding: const EdgeInsets.all(8),
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return Hero(
                tag: _items[index]['photoUrl'],
                child: Material(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Picview(
                                  user: widget.user,
                                  docu: _items[index],
                                )),
                      );
                    },
                    child:  Image.network(_items[index]['photoUrl'],
                          fit: BoxFit.cover),

                  ),
                ),
              );
            },
          );
        }

        // GridView.builder(
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisSpacing: 5,
        //       mainAxisSpacing: 5,
        //       crossAxisCount: 3,
        //       childAspectRatio: 1.0),
        //   primary: false,
        //   padding: const EdgeInsets.all(8),
        //   itemCount: 10,
        //   itemBuilder: (context, index) {
        //     return InkWell(
        //       onTap: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => Picview(
        //                   height: "e.height",
        //                   imageurl:
        //                       "https://64.media.tumblr.com/88b38f715767d34d7a9d33ca93182e80/tumblr_of3e2uI1471vitnh0o4_400.jpg")),
        //         );
        //       },
        //       child: Container(
        //         padding: const EdgeInsets.all(2),
        //         color: Colors.teal[100],
        //         child: Image.network(
        //             "https://techbigs.com/uploads/2020/02/adorable-home-5717.jpg",
        //             fit: BoxFit.cover),
        //       ),
        //     );
        //   }

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
