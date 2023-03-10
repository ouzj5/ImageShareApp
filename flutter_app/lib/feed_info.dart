import 'package:flutter/material.dart';
import 'package:flutter_app/feed_dialog.dart';
import 'package:flutter_app/feed_state.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dio/dio.dart';

/**
 * 注册界面
 */
class InfoPage extends StatefulWidget {
  final logout;
  const InfoPage({Key key, this.logout}) : super(key: key);
  @override
  _InfoPageState createState() => new _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  GlobalKey<FormState> _SignUpFormKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: EdgeInsets.only(top: 23),
        child: new Stack(
          alignment: Alignment.topCenter,
          overflow: Overflow.visible,
          children: <Widget>[
            new Container(
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Colors.white,),
                width: 300,
                height: 190,
                child: buildSignUpTextForm()
            ),

            new Positioned(
              child: buildSignInButton(),
              top: 200,)

          ],
        )
    );
  }

  Widget buildSignUpTextForm() {
    return new Form(
        key: _SignUpFormKey,
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            //用户名字
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20, bottom: 20),
                child: new TextFormField(
                    decoration: new InputDecoration(
                        icon: new Icon(Icons.person, color: Colors.black,),
                        hintText: MyState().username,
                        border: InputBorder.none
                    ),
                    style: new TextStyle(fontSize: 16, color: Colors.black),
                    enabled: false,
                ),
              ),
            ),
            new Container(
              height: 1,
              width: 250,
              color: Colors.grey[400],
            ),
            //邮箱
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20, bottom: 20),
                child: new TextFormField(
                  decoration: new InputDecoration(
                      icon: new Icon(Icons.email, color: Colors.black,),
                      hintText: "Email",
                      border: InputBorder.none
                  ),
                  style: new TextStyle(fontSize: 16, color: Colors.black),
                  enabled: false,
                ),
              ),
            ),
          ],
        ));
  }
  Widget buildSignInButton() {
    return new GestureDetector(
      child: new Container(
        padding: EdgeInsets.only(left: 42, right: 42, top: 10, bottom: 10),
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.grey
//            gradient: theme.Theme.primaryGradient,
        ),
        child: new Text(
          "LOGOUT",
          style: new TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      onTap: () {
        new Mydialog().getDialog(this.context, "请先登录");
        widget.logout();
      },
    );
  }
}