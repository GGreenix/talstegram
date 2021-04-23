import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService{
  final String uid;
  final String feedID = 'RQK6k4bdRSzvrnJexYxQ';
  DataBaseService({this.uid});
  final CollectionReference users = Firestore.instance.collection('users');
  final CollectionReference feedPosts = Firestore.instance.collection('posts');

  Future updateUserData ({String name,String bio,Map<String,String> posts, String profileImage}) async{
    print(profileImage);
    return await users.document(uid).setData({
      'name': name,
      'bio': bio,
      'posts': posts,
      'friends': [''],
      'profile_image': profileImage
      
      
    });
  }

  Future updateFeed({String caption,String encodedImage})async{
    feedPosts.document(feedID).updateData({caption:encodedImage});

  }
  Future getFeedData()async{
    try{
       DocumentSnapshot feedData = await feedPosts.document(feedID).get();

       return feedData;
        
       }
       
    
     catch(e){
       print(e);
     }
  }


  Future getUserData() async
  {
    
     try{
       DocumentSnapshot userData = await users.document(uid).get();

       return userData;
        
       }
       
    
     catch(e){
       print(e);
     }
  }

}

