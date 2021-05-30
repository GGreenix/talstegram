import 'package:firebase_auth/firebase_auth.dart';

import 'package:talstegram/models/database.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signIn (String email,String password)async {
    try{
      
       AuthResult userResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
       
       FirebaseUser user = userResult.user;
       return user.uid;       
    }catch(e){
      
      print("unable to login");
    }
  }

  Future signUp (String email,String password,String name,String bio,String encodedImage)async {
    try{
      
      AuthResult userResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
     
      FirebaseUser user =  userResult.user;
       
       
      DataBaseService(uid: user.uid).updateUserData(name:name,bio: bio,profileImage:encodedImage);
    }catch(e){
      print(e);
      print("unable to create user");
    }
  }

  
}