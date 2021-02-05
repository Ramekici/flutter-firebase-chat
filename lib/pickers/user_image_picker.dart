import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  
  UserImagePicker(this._imageSave);

  final void Function(File pickedImage) _imageSave;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {

  File _image;
  final picker = ImagePicker();

  

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera,
    imageQuality: 50,
    maxWidth: 150);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    widget._imageSave(File(pickedFile.path));
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children:<Widget>[
        CircleAvatar(
          radius:40,
          backgroundColor: Colors.grey,
          backgroundImage: _image != null ?  FileImage(_image) : null,    
        ),
                FlatButton.icon(
                  textColor: Theme.of(context).primaryColor,
                  onPressed: getImage, 
                  icon: Icon(Icons.image), 
                  label: Text('Add Image')),
      ]
    );
  }
}