import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final Image postImage;
  final String postCaption;
  final String encodedImage;
  Post({this.postImage,this.postCaption, this. encodedImage}) ;

  
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 8,
        margin: EdgeInsets.fromLTRB(50, 45, 50, 45),
       child: Column(
         children: [
           postImage,
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text(postCaption,
                style: TextStyle(fontSize: 10),
                )
             ]
           )
         ],
       ),
    );
  }
}