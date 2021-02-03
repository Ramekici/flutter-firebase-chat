import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              keyboardType:TextInputType.emailAddress,
              decoration: InputDecoration(labelText: 'Email Adresi')
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Kullanıcı Adı')
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Parola')
            ),
            SizedBox(height: 12),
            RaisedButton(
              child:Text('Giriş'),
              onPressed: (){

              }),
            FlatButton(
              color: Theme.of(context).primaryColor,
              onPressed: (){

              }, 
              child: Text('Hesap Aç'))

          ],
        )),
      )),
    ));
  }
}
