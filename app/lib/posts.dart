import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  dynamic posts;
  List<Widget> children = [];
  bool loading = true;

  void fetchPosts() {
    final s = http.get(
        Uri.parse('https://blog-flask-api-python.herokuapp.com/getAllPosts'));

    s.then((value) => {
          if (value.statusCode == 200)
            {
              setState(() {
                this.posts = jsonDecode(value.body)['posts'];
                if (this.posts.length > 0) {
                  for (int i = 0; i < this.posts.length; i++) {
                    this.children.add(Post(this.posts[i]));
                    this.loading = false;
                  }
                } else {
                  debugPrint("No Posts");
                }
              })
            }
        });
  }

  _PostPageState() {
    fetchPosts();
  }

  @override
  Widget build(BuildContext c) {
    if (this.loading == false) {
      if (this.children.length == 0) {
        return Text('No Posts Available at this Time');
      } else {
        return Column(
          children: this.children,
        );
      }
    } else {
      return Text('Loading...');
    }
  }
}

/*

Sample Post
[
    [
        1,
        "Not Om's Post",
        "Shivam",
        "11:00AM",
        0,
        "This is definitely not OM's post"
    ]
]

[
    [
        1,
        "Om",
        "Great Post!",
        "3:45",
        1
    ]
]
*/

class Post extends StatelessWidget {
  int id, likes;
  String body, author, title, timestamp;

  List comments;

  Post(List post) {
    this.id = post[0];
    this.title = post[1];
    this.author = post[2];
    this.timestamp = post[3];
    this.likes = post[4];
    this.body = post[5];
  }

  @override
  Widget build(BuildContext c) {
    return Text('Post');
  }
}

class Comment extends StatelessWidget {
  int id;
  String author, body, timestamp;

  Comment(List comment) {
    this.id = comment[0];
    this.author = comment[1];
    this.body = comment[2];
    this.timestamp = comment[3];
  }

  @override
  Widget build(BuildContext c) {
    return Text('Comment');
  }
}
