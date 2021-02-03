import 'package:flutter/material.dart';
import './pages/auth_page.dart';
import './pages/chat_page.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthPage(),
      routes: {
        ChatPage.routeName: (ctx) =>  ChatPage() 
      },
    );
  }
}

