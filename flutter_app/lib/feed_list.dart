import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/feed_dialog.dart';
import 'package:flutter_app/feed_dio.dart';
import 'package:flutter_app/feed_state.dart';
import 'feed_image.dart';
import 'dart:io';
import 'feed_body.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class FeedList extends StatefulWidget {
  final setIndex;
  const FeedList({Key key, this.setIndex}) : super(key: key);
  @override
  State<StatefulWidget> createState() => new FeedListState();
}

class FeedListState extends State<FeedList> {
  var _rowList = <ListTile>[];
  var imgurls = <String>[];
  var _imgs = <Image>[];
  var favor = <bool>[];
  FeedListState() {
    for (int i = 0; i < 6; i ++ ) {
      imgurls.add("http://localhost:8080/assets/timg.jpeg");
      _imgs.add(Image.network(imgurls[i]));
      favor.add(false);
    }
    _getArticle();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemBuilder: (context, i) {
          if (i >= _rowList.length && i < 6) {
            _rowList.add(_buildRow(i));
          }
          if (i < 6) return _rowList[i];
          return null;
        },
        padding: EdgeInsets.all(0));
  }

  Widget _buildRow(int i) {
    return new ListTile(
      title: Container(
        margin: EdgeInsets.only(bottom: 10, top: 10),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                MyImg(),
                Text("Andrew", style: TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
            GestureDetector(
              child: _imgs[i],
              onTap: _pushPage,
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  child: GestureDetector(child: favorIcon(i), onTap: (){_getFavor(i);},),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Icon(Icons.crop_3_2),
                )
              ],
            ),
            TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: MyImg(),
                hintText: 'Add a comment...',
              ),
            )
          ],
        ),
      ),
    );
  }

  void _pushPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return FeedBody();
    }));
  }
  Widget favorIcon(int i) {
    if (favor[i]) {
      return Icon(Icons.favorite);
    } else {
      return Icon(Icons.favorite_border);
    }
  }
  Future<void> _getFavor(int i) async {

    String url;
    if (favor[i]) {
      url = "http://localhost:8080/deletezan";
    } else {
      url = "http://localhost:8080/createzan";
    }
    var data;
    Response res = await new Mydio().dio.post(url,
        data: {"uid": MyState().uid, "aid": (i + 1).toString()}, queryParameters:{});
    setState(() {
      favor[i] = !favor[i];
      _rowList[i] = _buildRow(i);
    });
  }
  void _getArticle() async {
    var data;
    try {
      Response res = await new Mydio().dio.get("http://localhost:8080/getArticle",
          queryParameters: {"start": "1", "end": "6"});

      if (res.statusCode == HttpStatus.ok) {
        data = jsonDecode(res.toString());
        if (data['status'] == "error") {
          new Mydialog().getDialog(this.context, "请先登录");
          widget.setIndex(1);
          new MyState().reset();
          print(res.toString());
          return;
        }
      }
    } catch (exception) {
      print(exception.toString());
      new Mydialog().getDialog(this.context, "请先登录");
      widget.setIndex(1);
      return;
    }
    setState(() {
      for (int i = 0; i < 6; i++) {
        imgurls[i] = ("http://localhost:8080/" + data['data'][i]['imgurl']);
        _imgs[i] = Image.network(imgurls[i]);
        favor[i] =  data['data'][i]['zan'] == 1;
      }
      _rowList.clear();
    });
  }
}
