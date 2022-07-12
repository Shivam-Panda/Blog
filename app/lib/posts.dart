import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext c) {
    return Column(
      children: [
        Text(_counter.toString()),
        TextButton(onPressed: _incrementCounter, child: Text("Click Me!"))
      ],
    );
  }
}
