import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitForm(String email, String password, String username, bool isLogin, BuildContext ctx) async {
    
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
      await FirebaseFirestore.instance.collection('users').doc(authResult.user.uid).set({
        'username': username,
        'email': email
      });
    } on PlatformException catch (err) {
      var message = 'Hata meydana geldi, bilgilerini kontrol et.';
      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
        backgroundColor: Theme.of(ctx).accentColor,
      ));
       setState(() {
        _isLoading = false;
      });
    } catch(err){
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitForm, _isLoading),
    );
  }
}
