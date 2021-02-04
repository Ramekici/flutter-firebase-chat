import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_chat_ekici/chat/messages.dart';
import 'package:flutter_app_chat_ekici/chat/new_message.dart';


class ChatPage extends StatefulWidget {
  static final routeName = '/chat';
  const ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  Widget build(BuildContext context) {
    // CollectionReference documents = FirebaseFirestore.instance
    //     .collection('chats/hRUNrDpg1RY8DdBK6qpf/messages');

    return Scaffold(
        appBar: AppBar(
          title: Text('Chat Sayfası'),
          actions: [
            DropdownButton(
              icon: Icon(Icons.more_vert, color: Theme.of(context).primaryIconTheme.color), 
            items: [DropdownMenuItem(child: Container(child: Row(children: <Widget>[
              Icon(Icons.exit_to_app),
              SizedBox(width: 8,),
              Text('Çıkış')
            ],)
            ),
            value: 'logout',
            ),], 
            onChanged: (itemIdendifier){
              if(itemIdendifier == 'logout'){
                FirebaseAuth.instance.signOut();
              }
            }),
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(child: Messages(),
              ),
              NewMessage()
            ],
          )),
        );
  }
}
