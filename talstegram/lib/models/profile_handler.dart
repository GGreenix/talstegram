import 'package:flutter/material.dart';
import 'package:talstegram/models/post.dart';




class ProfileHandler
{
  List<Post> posts;
  String name,bio,encodedProfileImage;
  Image profileImage;
  
  
  ProfileHandler(name,bio,profileImage, List<Post> posts,encodedProfileImage)
  {
    this.encodedProfileImage = encodedProfileImage;
    this.name = name;
    this.bio = bio;
    this.profileImage = profileImage;
    this.posts = posts;
  }


  
  
}
  

  
