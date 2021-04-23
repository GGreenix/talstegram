import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //CircleAvatar(backgroundImage: profile_image,
          Center(
            child: Icon(Icons.search),),
          TextField(
            
          )
          
        ]
      ),

    );
  }
}