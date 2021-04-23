import 'package:talstegram/models/feedHandler.dart';
import 'globals.dart' as globals;
import 'package:talstegram/models/post.dart';
import 'package:talstegram/models/profile_handler.dart';
import 'package:talstegram/screens/home_pages_screens/feed.dart';
import 'package:talstegram/screens/home_pages_screens/profile.dart';
import 'package:talstegram/screens/home_pages_screens/search.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  
  ProfileHandler profileHandler;
  FeedHandler feedHandler;
  HomePage({this.profileHandler,this.feedHandler});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  List<Widget> _homePages;

  TabController _tabController;
  static const _homeTabs = <Tab>[
    Tab(icon: Icon(Icons.search, color: Colors.black45)),
    Tab(icon: Icon(Icons.home, color: Colors.black45)),
    Tab(icon: Icon(Icons.account_box_outlined, color: Colors.black45))
  ];
  ProfileHandler _profileHandler;
  FeedHandler _feedHandler;

  Map<String,String> cvtPoststoMap(){
    Map<String,String> listsOfDecodedPosts = {};
    _profileHandler.posts.forEach((post) => listsOfDecodedPosts['${post.postCaption}'] = post.encodedImage);
    return listsOfDecodedPosts;
  }
  
   List<Post> refreshProfileState(Post newPost) {
     setState(() {
      _profileHandler.posts.add(newPost);       
     });
      globals.mainDataBaseInterface.updateFeed(caption: newPost.postCaption,encodedImage: newPost.encodedImage);
      globals.mainDataBaseInterface.updateUserData(name: _profileHandler.name,bio: _profileHandler.bio,posts: cvtPoststoMap(),profileImage:_profileHandler.encodedProfileImage);
      return _profileHandler.posts;
  }
  
  @override
  void initState() { 
    super.initState();
    _feedHandler = widget.feedHandler;
    _profileHandler = widget.profileHandler;
    
    
    
    _homePages = <Widget>[
    Search(),
    
    Feed(feedPosts: _feedHandler.feed,),
    Profile(posts: _profileHandler.posts,
    refreshPosts: refreshProfileState,
    bio: _profileHandler.bio,
    name: _profileHandler.name,
    profileImage: _profileHandler.profileImage,
    )
  ];
    _tabController = TabController(
      length: _homePages.length, 
      vsync: this,
      );
      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(        
      body: TabBarView(controller: _tabController,
      children:_homePages,
      ),
              
    bottomNavigationBar: 
    
    SizedBox(
      height: 25,
          child: Material(
        color:  Colors.white,
        child: TabBar(
          indicatorColor: Colors.white,
        tabs: _homeTabs,
        controller: _tabController,
        )
      ),
    )
    );
  }
}