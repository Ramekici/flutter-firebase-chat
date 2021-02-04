import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './pages/auth_page.dart';
import './pages/chat_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // if (snapshot.hasError) {
          //   return SomethingWentWrong();
          // }

          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Chat Uygulaması',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.pink,
                backgroundColor: Colors.pink,
                accentColor: Colors.purpleAccent,
                accentColorBrightness: Brightness.dark,
                buttonTheme: ButtonTheme.of(context).copyWith(
                    buttonColor: Colors.pink,
                    textTheme: ButtonTextTheme.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), 
              builder: (ctx, userSnapshot){
                if(userSnapshot.hasData){
                  return ChatPage();
                }
                return AuthPage();
              } ,),
              //routes: {ChatPage.routeName: (ctx) => ChatPage()},
            );
          }
          return MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator(),)
            )
          );
        });
  }
}
