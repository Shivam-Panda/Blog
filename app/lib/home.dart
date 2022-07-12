import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext c) {
    return Column(children: [
      Expanded(
          child: Container(
            child: Text('About Developer'),
            width: MediaQuery.of(c).size.width,
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0), color: Colors.blue),
          ),
          flex: 5),
      Expanded(
          child: Container(
            child: Text('About Project'),
            width: MediaQuery.of(c).size.width,
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0), color: Colors.red),
          ),
          flex: 5)
    ], mainAxisAlignment: MainAxisAlignment.spaceEvenly);
  }
}
