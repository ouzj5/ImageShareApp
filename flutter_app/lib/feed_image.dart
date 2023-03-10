import 'package:flutter/material.dart';

class MyImg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      width: 40,
      height: 40,
      margin: const EdgeInsets.all(10),
      decoration: new BoxDecoration(
        image: new DecorationImage(image: AssetImage('images/dog.jpeg')),
        shape: BoxShape.circle
      ),
    );
  }
}
