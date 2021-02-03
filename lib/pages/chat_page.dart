import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatPage extends StatefulWidget {
  static final routeName = '/chat';
  const ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference documents = FirebaseFirestore.instance
        .collection('chats/hRUNrDpg1RY8DdBK6qpf/messages');

    return Scaffold(
        appBar: AppBar(
          title: Text('Chat Sayfası'),
        ),
        body: StreamBuilder(
          stream: documents.snapshots(),
          builder: (ctx, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final items = streamSnapshot.data.docs;
            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (ctx, ind) => Container(
                      padding: EdgeInsets.all(8),
                      child: Text(items[ind]['text']),
                    ));
          },
        ),
        floatingActionButton:
            FloatingActionButton(child: Icon(Icons.add), onPressed: () {
               return documents.add({
                 'text': 'Merhaba Nehir'
               });
            }));
  }
}
