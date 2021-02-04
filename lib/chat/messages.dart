import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../chat/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strem = FirebaseFirestore.instance.collection('chat');
    return StreamBuilder(
      stream: strem.orderBy('createdAt', descending: true).snapshots(),
      builder: (ctx, chatSnapshot){
        if(chatSnapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        final chatDocs = chatSnapshot.data.docs;
        final user = FirebaseAuth.instance.currentUser;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx,index){
            return MessageBubble(
              chatDocs[index]['text'], 
            chatDocs[index]['userId'] == user.uid,
            key: ValueKey(chatDocs[index].id)
            );
          });

      },
      );
  }
}