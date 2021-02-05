import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_chat_ekici/pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String username, File userImage,
      bool ilsLogin, BuildContext ctx) _submitFn;
  final bool _isLoader;

  const AuthForm(this._submitFn, this._isLoader);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _password = '';
  File _userImageFile;

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if(_userImageFile == null && !_isLogin){
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text('Lütfen resim seçin'),
        backgroundColor: Theme.of(context).errorColor,)
      );
      return;
    }
    if (isValid) {
      _formKey.currentState.save();
      widget._submitFn(_userEmail.trim(), _password.trim(), _userName.trim(), _userImageFile,
          _isLogin, context);
    }
  }

  void saveImage(File image){
    _userImageFile = image;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if(!_isLogin)
                UserImagePicker(saveImage),
                TextFormField(
                  key: ValueKey('email'),
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Email Hatalı Giriş';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email Adresi'),
                  onSaved: (value) {
                    _userEmail = value;
                  },
                ),
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey('username'),
                    decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 6) {
                        return '6 karakterden az olmamalı.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userName = value;
                    },
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  decoration: InputDecoration(labelText: 'Parola'),
                  validator: (value) {
                    if (value.isEmpty || value.length < 7) {
                      return '7 karakterden az olmamalı.';
                    }
                    return null;
                  },
                  obscureText: true,
                  onSaved: (value) {
                    _password = value;
                  },
                ),
                SizedBox(height: 12),
                if (widget._isLoader) CircularProgressIndicator(),
                if (!widget._isLoader)
                  RaisedButton(
                    child: Text(_isLogin ? 'Giriş' : 'Üye Ol'),
                    onPressed: _trySubmit,
                  ),
                if (!widget._isLoader)
                  FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin ? 'Hesap Aç' : 'Hesabım Var!'))
              ],
            )),
      )),
    ));
  }
}
