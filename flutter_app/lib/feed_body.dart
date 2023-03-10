import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedBody extends StatefulWidget {
  @override
  _FeedBodyState createState() => _FeedBodyState();
}

class _FeedBodyState extends State<FeedBody> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Andrew', style: TextStyle(fontWeight: FontWeight.bold))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('images/timg.jpeg')
        ],
      ),
    );
  }
}
