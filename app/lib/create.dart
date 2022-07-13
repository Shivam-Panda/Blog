import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  String post_author = '', post_body = '', post_title = '';

  Widget s = Container();

  void makePost() {
    DateTime _now = DateTime.now();
    String timestamp =
        '${_now.hour}:${_now.minute}:${_now.second}.${_now.millisecond}';

    dynamic s = http.post(
        'https://blog-flask-api-python.herokuapp.com/makePost',
        headers: {
          'Content-Type': 'application/json',
          'User-Agent': 'PostmanRuntime/7.29.0'
        },
        body: json.encode({
          "author": this.post_author,
          "body": this.post_body,
          "time": timestamp,
          "title": this.post_title
        }));
    s.then((v) => {
          setState(() {
            this.s = Text('Submitted, move to the Posts page');
          })
        });
  }

  @override
  Widget build(BuildContext c) {
    return Column(
      children: [
        // Text('$_counter'),
        // TextButton(onPressed: _incrementCounter, child: Text("Click Me"))
        TextField(
          decoration: InputDecoration(labelText: 'Author'),
          onSubmitted: (String s) {
            post_author = s;
          },
        ),
        TextField(
            decoration: InputDecoration(labelText: 'Body'),
            onSubmitted: (String value) {
              post_body = value;
            }),
        TextField(
            decoration: InputDecoration(labelText: 'Title'),
            onSubmitted: (String value) {
              post_title = value;
            }),
        TextButton(onPressed: makePost, child: Text('Submit')),
        this.s
      ],
    );
  }
}
