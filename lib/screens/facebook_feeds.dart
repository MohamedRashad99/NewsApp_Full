import 'dart:math';
import 'package:flutter/material.dart';

import '../api/post_api.dart';
import '../models/post.dart';
import '../shared_ui/navigation_drawer.dart';
import '../utilities/data_utilities.dart';
class FacebookFeed extends StatefulWidget {
  @override
  _FacebookFeedState createState() => _FacebookFeedState();
}

class _FacebookFeedState extends State<FacebookFeed> {
  PostsAPI postsAPI = PostsAPI();
  List<int>ids=[0,2,7];
  TextStyle _hasTagStyle = TextStyle(
    color: Colors.orange,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Facebook Feeds',
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {


            },
          ),
        ],
      ),
      drawer: NavigationDrawer(),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemBuilder: (context, position) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _drawHeader(position),
                  _drawTitle(),
                  _drawHastages(),
                  _drawBody(),
                  _drawFooter(),
                ],
              ),
            ),
          );
        },
        itemCount: 20,
      ),
    );
  }


  Widget _drawHeader(int position) {
    return FutureBuilder(
      future: postsAPI.fetchWhatsNew(),
      builder: (context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return loading();
            break;
          case ConnectionState.active:
            return loading();
            break;
          case ConnectionState.none:
          // TODO handle problem
            return connectionerror();
            break;
          case ConnectionState.done:
            if (snapshot.error != null) {
              return error(snapshot.error);
            } else {
              List<Post> posts = snapshot.data;
              Random random = Random();
              int randomIndex = random.nextInt(posts.length);
              Post post = posts[randomIndex];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:NetworkImage(post.urlToImage),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                           post.author,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.grey.shade900,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(post.publishedAt),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite),
                        onPressed: () {
                          if(ids.contains(position)){
                            ids.remove(position);
                          }else{
                            ids.add(position);
                          }
                          setState(() {

                          });
                          print(ids);
                        },
                        color: (ids.contains(position)) ? Colors.red : Colors.grey.shade400,
                      ),
                      Transform.translate(
                        offset: Offset(-12, 0),
                        child: Text(
                          '25',
                          style: TextStyle(color: Colors.grey.shade400, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
            break;
        }
        return Container(
          color: Colors.red,
        );
      },
    );
  }

  Widget _drawTitle() {
    return FutureBuilder(
      future: postsAPI.fetchWhatsNew(),
      builder: (context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return loading();
            break;
          case ConnectionState.active:
            return loading();
            break;
          case ConnectionState.none:
          // TODO handle problem
            return connectionerror();
            break;
          case ConnectionState.done:
            if (snapshot.error != null) {
              return error(snapshot.error);
            } else {
              List<Post> posts = snapshot.data;
              Random random = Random();
              int randomIndex = random.nextInt(posts.length);
              Post post = posts[randomIndex];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
                child: Text(
                 post.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey.shade900),
                ),
              );
            }
            break;
        }
        return Container(
          color: Colors.red,
        );
      },
    );
  }

  Widget _drawHastages() {
    return Container(
      child: Wrap(
        children: [
          FlatButton(
              onPressed: () {},
              child: Text(
                '#advance',
                style: _hasTagStyle,
              )),
          FlatButton(
              onPressed: () {},
              child: Text(
                '#retro',
                style: _hasTagStyle,
              )),
          FlatButton(
              onPressed: () {},
              child: Text(
                '#instagram',
                style: _hasTagStyle,
              )),
        ],
      ),
    );
  }

  Widget _drawBody() {
    return FutureBuilder(
      future: postsAPI.fetchWhatsNew(),
      builder: (context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return loading();
            break;
          case ConnectionState.active:
            return loading();
            break;
          case ConnectionState.none:
          // TODO handle problem
            return connectionerror();
            break;
          case ConnectionState.done:
            if (snapshot.error != null) {
              return error(snapshot.error);
            } else {
              List<Post> posts = snapshot.data;
              Random random = Random();
              int randomIndex = random.nextInt(posts.length);
              Post post = posts[randomIndex];
              return SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height*0.25,
                child: Image(
                  image:NetworkImage(post.urlToImage),
                  fit: BoxFit.cover,
                ),
              );
            }
            break;
        }
        return Container(
          color: Colors.red,
        );
      },
    );
  }

  Widget _drawFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FlatButton(onPressed: (){}, child: Text('10 COMMENTS',style: _hasTagStyle,),),
        Row(
          children: [
            FlatButton(onPressed: (){}, child: Text('SHARE',style: _hasTagStyle,),),
            FlatButton(onPressed: (){}, child: Text('OPEN',style: _hasTagStyle,),),
          ],
        ),
      ],
    );
  }
}
