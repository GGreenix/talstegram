import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talstegram/screens/auth_screens/signUpScreen.dart';
import 'globals.dart' as globals;

import 'package:talstegram/home_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:talstegram/models/auth.dart';
import 'package:talstegram/models/database.dart';
import 'package:talstegram/models/feedHandler.dart';
import 'package:talstegram/models/profile_handler.dart';

import 'models/post.dart';


class AuthPage extends StatefulWidget {
  AuthPage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<AuthPage> {
   AuthService _authenticationHandler;
   
   ProfileHandler _profileHandler;
   FeedHandler _feedHandler;
   var userProfile;
  String _password,_email;
  
  @override
  void initState() {
    super.initState();
    _authenticationHandler = AuthService(); 
  }
  Map mapUserData(DocumentSnapshot userDataSnapshot) {
    Map userData = {'bio': "",'name': "",'posts': "",'friends': "",'profile_image':""};
     userData.forEach((key, value) => userData[key] = userDataSnapshot[key]);
     return userData;
  }
  
  Image cvtBase64ToImageObject(String base64Image){
    return Image.memory(base64Decode(base64Image));
  }
  List<Post> cvtEncodedPostsToPostObjectFeed(Map<dynamic,dynamic> encodedPosts){
    
    List<Post> ret = [];
    
    encodedPosts.forEach((key,value) => ret.add(Post(encodedImage: value,postImage: cvtBase64ToImageObject(value),postCaption: key,)));
    return ret;
  }
  List<Post> cvtEncodedPostsToPostObjects(LinkedHashMap<dynamic,dynamic> encodedPosts){
    List<Post> ret = [];
    encodedPosts == null ? encodedPosts = {"":''} as LinkedHashMap:
    encodedPosts.forEach((key, value) => ret.add(Post(encodedImage: value,postImage: cvtBase64ToImageObject(value),postCaption: key,)));
    return ret;
  }
  Future fetchUserData() async{
    dynamic userData = await globals.mainDataBaseInterface.getUserData();
    dynamic feedData = await globals.mainDataBaseInterface.getFeedData();
    print("infetch");
    userProfile = mapUserData(userData);
    setState(() {
     
      _profileHandler = ProfileHandler(userProfile['name'],userProfile['bio'],cvtBase64ToImageObject(userProfile['profile_image']),cvtEncodedPostsToPostObjects(userProfile['posts'],),userProfile['profile_image']);
      _feedHandler = FeedHandler(feed: cvtEncodedPostsToPostObjectFeed(feedData.data));
      
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(profileHandler: _profileHandler,feedHandler: _feedHandler,)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Login"),
        
      ),
      body: 
        Container(
        child: Column(
          children: [
            Image(image: AssetImage('images/logo.jpg')),
            
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                      
                      
                      decoration: InputDecoration(
                      border: OutlineInputBorder(),
                        labelText: "Email"),
                        onChanged: (val){
                          setState(() {
                            _email = val;
                          });
                        },
                        
                        ),
                        
                    ),
            
            Padding(padding: EdgeInsets.all(7)),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
              
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "password"),
                        onChanged: (val){
                          setState(() {
                            _password = val;
                          });
                        },
            ),
            ),
            
        Padding(padding: EdgeInsets.all(10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: FlatButton(
                color: Colors.green
                ,onPressed: () => _authenticationHandler.signIn(_email, _password).then(
                  (userID) {
                    setState(() => globals.mainDataBaseInterface = DataBaseService(uid:userID));
                    fetchUserData();
                  }),

                 child: Text("sign in")
                 ),
            ),
              
            Expanded(
              child: FlatButton(
                color: Colors.amber,
                onPressed: () async{ 
                  final ditails = await  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen()));
                  
                  
                  _authenticationHandler.signUp(_email,_password,ditails['name'],ditails['bio'],ditails['profileImage']);},
                child: 
                  Text("sign up")),
            )
          ]
        )
        ],
        )
      
      
      )
    );
      
      
  }
}

  
