import 'package:flutter/material.dart';
import 'package:talstegram/auth_page_screen.dart';

void main() => runApp(MyApp());
  


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthPage(),
      
      
    );
  }
}
