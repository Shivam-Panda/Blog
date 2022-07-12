import 'package:app/home.dart';
import 'package:app/posts.dart';
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
      home: SwitcherPage(),
      theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity),
    );
  }
}

class SwitcherPage extends StatefulWidget {
  @override
  _SwitcherPageState createState() => _SwitcherPageState();
}

class _SwitcherPageState extends State<SwitcherPage> {
  Widget _curPage = HomePage();

  void _setToHome() {
    setState(() {
      _curPage = HomePage();
    });
  }

  void _setToPosts() {
    setState(() {
      _curPage = PostPage();
    });
  }

  void _setToCreate() {
    setState(() {
      _curPage = CreatePage();
    });
  }

  @override
  Widget build(BuildContext c) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Row(
              children: [
                FlatButton(onPressed: _setToHome, child: Text("Home")),
                FlatButton(onPressed: _setToPosts, child: Text("Posts")),
                FlatButton(onPressed: _setToCreate, child: Text("Create")),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            )),
        body: _curPage);
  }
}
