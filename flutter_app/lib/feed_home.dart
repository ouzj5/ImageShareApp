import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/feed_info.dart';
import 'package:flutter_app/feed_state.dart';
import 'package:flutter_app/feed_user.dart';
import 'package:flutter_app/feed_dialog.dart';
import 'dart:async';
import 'feed_list.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _batteryLevel = '100 %';
  var fbody = <Widget>[];
  int _index = 0;
  static const platform = const MethodChannel('samples.flutter.io/battery');
  Future<void> _getBatteryLevel() async {
    String batteryLevel;

    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = '$result %';
    } on PlatformException catch (e) {
      batteryLevel = "${e.message}";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    fbody.add(FeedList(setIndex:(i) => _setIndex(i)));
    fbody.add(LoginPage());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bytedance', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: Container(
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              Icons.camera_alt,
              color: Colors.black,
            )),
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  child: Icon(Icons.battery_unknown),
                  onTap: _getBatteryLevel,
                ),
                Text(_batteryLevel,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold))
              ],
            ),
          )
        ],
        centerTitle: true,
      ),
      body: fbody[_index],
      bottomNavigationBar: BottomAppBar(
          child: Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(icon:Icon(Icons.home, color: getColor(0)), onPressed: (){setState(() {
//              if (MyState().loginstate == 0) {
//                new dialog().getDialog(this.context);
//                _index = 1;
//              }
              _index = 0;
            });}),
            IconButton(icon: Icon(Icons.search, color: getColor(4)), onPressed: (){setState(() {
              _index = 0;
            });}),
            IconButton(icon: Icon(Icons.add_box, color: getColor(2)), onPressed: (){setState(() {
              _index = 0;
            });}),
            IconButton(icon: Icon(Icons.favorite, color: getColor(3)), onPressed: (){setState(() {
              _index = 0;
            });}),
            IconButton(icon: Icon(Icons.account_box, color: getColor(1)), onPressed: (){setState(() {
              _index = 1;
            });})
          ],
        ),
      )),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  void _setIndex(int i) {
    _index = i;
  }
  Color getColor(int i) {
    if (i != _index) {
      return Colors.grey;
    } else {
      return Colors.black;
    }
  }
}
