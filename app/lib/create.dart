import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext c) {
    return Row(
      children: [
        Text('$_counter'),
        TextButton(onPressed: _incrementCounter, child: Text("Click Me"))
      ],
    );
  }
}
