import 'package:flutter/material.dart';
import 'package:talstegram/models/post.dart';

class Feed extends StatefulWidget {
  
  List<Post> feedPosts;
  Feed({this.feedPosts});

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          
          Center(
            child: Icon(
              Icons.home_rounded
            ),
          ),
          Expanded(
              child: ListView.builder(
              itemCount: widget.feedPosts.length == null ? 0:widget.feedPosts.length,
              itemBuilder: (context, index){
                return widget.feedPosts[index];

            }),
        )
        ]
      ),

    );
  }
}