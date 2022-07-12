import 'package:flutter/material.dart';

// import 'posts.dart';
// import 'home.dart';
import 'create.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sampler",
      home: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: Row(
                children: [Text("Home"), Text("Posts"), Text("Create")],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              )),
          body: CreatePage()),
      theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity),
    );
  }
}
