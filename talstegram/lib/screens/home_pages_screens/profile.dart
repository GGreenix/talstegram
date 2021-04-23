import 'dart:io';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:talstegram/models/post.dart';

import 'package:image_picker/image_picker.dart';

import 'editingPost.dart';



class Profile extends StatefulWidget {
  List<Post> posts;
  String name, bio;
  Image profileImage;
  Function refreshPosts;
  String uid;
  Profile(
  {
    this.uid,
    Key key,
    this.bio,
    this.name,
    this.refreshPosts,
    this.posts,
    this.profileImage
    
  });
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  final picker = ImagePicker();
  String _name,_bio;
  
  int _numOfPosts = 0;
  
  List<Post> _posts ;
  
  Future<void> newPost() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    final fileImage = File(pickedFile.path);
    Image img = Image.file(File(pickedFile.path));
    
    final Post newPost = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => PostEditor(newPost: img,fileImage: fileImage,)));
    
    setState(()  {
      if (pickedFile != null){
        _posts = widget.refreshPosts(newPost);
        _numOfPosts = _posts.length;
      }
      else{
        print('no image selected.');
      }
    });
  }

  
 @override
  void initState() {
    super.initState();

    _posts = widget.posts;
    _numOfPosts = _posts.length;
    _name = widget.name;
    _bio = widget.bio;
  }
  
  

  @override
  Widget build(BuildContext context) {
    
    
    
    
    return Scaffold(
      appBar: PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: AppBar(
          
          actions: <Widget>[
             Padding(
        padding: EdgeInsets.only(right: 20),
        child: GestureDetector(
          
          child: Icon(
            Icons.remove,
            size: 26.0,)
            )
          ),
            Padding(
        padding: EdgeInsets.only(right: 20),
        child: GestureDetector(
          onTap: newPost ,
          child: Icon(
            Icons.add,
            size: 26.0,)
            )
          ),
         
          ],
          backgroundColor: Colors.black87,
          
          
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start ,
        children: [
          Padding(padding: EdgeInsets.all(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.all(10)),
              CircleAvatar(child: widget.profileImage,),
              Padding(padding: EdgeInsets.fromLTRB(45, 0, 40, 0)),
              
              Column(children: [
                Text('$_numOfPosts'),
                Text("posts"),
              ],),
              Padding(padding: EdgeInsets.fromLTRB(20, 0, 40, 0)),
              Column(children: [
                Text("0"
                ),
                Text("friends"),
                
              ],
            ),
            Padding(padding: EdgeInsets.fromLTRB(20, 0, 40, 0)),
            ],
          ),
          
          Row(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(15, 20, 0, 7)),
              Text(_name),
            ],
          ),
          Row(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(15, 20, 0, 7)),
              Text(_bio),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.fromBorderSide(BorderSide(
                width: 0,
              ))
            ),
          ),
          Expanded(
              child: ListView.builder(
              itemCount: widget.posts.length == null ? 0:widget.posts.length,
              itemBuilder: (context, index){
                return _posts[index];

            }),
        )
  
          
        
        ]
      ),
      
    );
  }
}