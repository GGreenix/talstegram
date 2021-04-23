import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:talstegram/models/post.dart';

// ignore: must_be_immutable
class PostEditor extends StatelessWidget {
  final Image newPost;
  var fileImage;
  final myCaptionController = TextEditingController();
  PostEditor({this.newPost,this.fileImage});
  
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(40),
              child: AppBar(
                actions: <Widget>[
                  Padding(padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: (){
                      List<int> encodedImage = fileImage.readAsBytesSync();
                      String base64Image = base64Encode(encodedImage);
                      Navigator.pop(context,Post(postCaption: myCaptionController.text,postImage: newPost,encodedImage:base64Image));
                    },
                    child: Text("SHARE",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    )
                    ,)
                    ,)
                ],
              )
              
              ),
              body: Column(children: [
                
                Expanded(child: newPost),
                Padding(padding: EdgeInsets.all(20)),
                TextField(
                      controller: myCaptionController,
                      decoration: InputDecoration(
                      border: OutlineInputBorder(),
                        labelText: "Caption"),
                        ),

              ],),
    );
  }
}