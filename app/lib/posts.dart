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
                  this.loading = false;
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
        return Center(child: Text('No Posts Available at this Time'));
      } else {
        return ListView(
          scrollDirection: Axis.vertical,
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

class Post extends StatefulWidget {
  List<dynamic> post;

  Post(_post) {
    this.post = _post;
  }

  @override
  _PostState createState() => _PostState(this.post);
}

class _PostState extends State<Post> {
  int id, likes;
  String body, author, title, timestamp;

  List comments;
  List<Widget> commentComponents = [
    Text(
      'Comments',
      style: TextStyle(fontWeight: FontWeight.bold),
    )
  ];

  bool loading = true;

  void likePost() {
    final s = http.get(Uri.parse(
        'https://blog-flask-api-python.herokuapp.com/likePost/${this.id}'));

    s.then((value) => {
          if (value.statusCode == 200)
            {
              setState(() {
                this.likes = jsonDecode(value.body)['likes'];
              })
            }
        });
  }

  void fetchComments() {
    String url = 'https://blog-flask-api-python.herokuapp.com/getComments/' +
        this.id.toString();
    final s = http.get(Uri.parse(url));

    s.then((value) => {
          if (value.statusCode == 200)
            {
              if (this.mounted)
                {
                  setState(() {
                    List<dynamic> c = jsonDecode(value.body)['comments'];
                    if (c.length != 0) {
                      for (int i = 0; i < c.length; i++) {
                        this.commentComponents.add(Comment(c[i]));
                      }
                    }
                    this.loading = false;
                  })
                }
            }
        });
  }

  _PostState(List post) {
    this.id = post[0];
    this.title = post[1];
    this.author = post[2];
    this.timestamp = post[3];
    this.likes = post[4];
    this.body = post[5];
    fetchComments();
  }

  @override
  Widget build(BuildContext c) {
    if (this.loading) {
      return Center(child: Text('Loading...'));
    }
    return Container(
      child: Column(children: [
        Center(
            child: Text('${this.title}',
                style: TextStyle(fontWeight: FontWeight.bold))),
        Container(
          child: Column(
            children: [
              Text('${this.author}'),
              Text('${this.timestamp}'),
              Text('ID: ${this.id}')
            ],
          ),
        ),
        Container(
          child: Row(children: [
            Text('${this.likes}'),
            TextButton(
              child: Text('Like Post', style: TextStyle(color: Colors.black)),
              onPressed: this.likePost,
            )
          ]),
        ),
        Center(
          child: Text('${this.body}'),
        ),
        Column(
          children: this.commentComponents,
        )
      ]),
      width: MediaQuery.of(c).size.width,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(10.0)),
    );
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
    return Text('${this.body}');
  }
}
