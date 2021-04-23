
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Image _profileImage;
  
  final picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController()
  ,_bioController = TextEditingController()
  ,_emailController = TextEditingController()
  ,_passwordController = TextEditingController();
  String _encodedImage;

  Future getProfilePic()async{
    final pickedfile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _encodedImage = base64Encode(File(pickedfile.path).readAsBytesSync());
      _profileImage = Image.file(File(pickedfile.path));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sign up page"),
        
      ),
      body: Column(children:[
        Center(child: CircleAvatar(radius: 30,
          child: _profileImage
          ,),),
          Center(
            child: FlatButton(onPressed: getProfilePic, child: Text("press to pick profile")),
          ),
          Padding(padding: EdgeInsets.all(20)),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "name"
            ),
            
          ),
          TextField(
            controller: _bioController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "bio"
            ),
            
          ),
          Padding(padding: EdgeInsets.all(20)),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "email"
            ),
            
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "password"
            ),
            
          ),
          
          FlatButton(
            onPressed: () { 
              //print('$_encodedImage');
              Navigator.pop(context,{'name': _nameController.text,'bio': _bioController.text,'profileImage':_encodedImage});},
          child: Text("finish"))

      ]),
    );
  }
}