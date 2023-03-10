import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:io';

/**
 *注册界面
 */
class SignInPage extends StatefulWidget {
  final signin;

  const SignInPage({Key key, this.signin}) : super(key: key);

  @override
  _SignInPageState createState() => new _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String username;
  String password;
  GlobalKey<FormState> _SignInFormKey = new GlobalKey();


  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(top: 23),
      child: new Stack(
        alignment: Alignment.center,
        children: <Widget>[
          new Column(
            children: <Widget>[
              buildSignInTextForm(),
              new SizedBox(
                height: 10,
              ),
            ],
          ),
          new Positioned(
            child: buildSignInButton(),
            top: 200,
          )
        ],
      ),
    );
  }
  Widget buildSignInTextForm() {
    return new Container(
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white),
      width: 300,
      height: 190,
      child: new Form(
        key: _SignInFormKey,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20, bottom: 20),
                child: new TextFormField(
                  decoration: new InputDecoration(
                      icon: new Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      hintText: "Username",
                      border: InputBorder.none),
                  style: new TextStyle(fontSize: 16, color: Colors.black),
                  onSaved: (value) {
                    username = value;
                  },
                  validator: (value) {
                    return value.trim().length > 0 ? null : "用户名不能为空";
                  },
                ),
              ),
            ),
            new Container(
              height: 1,
              width: 250,
              color: Colors.grey[400],
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
                child: new TextFormField(
                  decoration: new InputDecoration(
                    icon: new Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    hintText: "Password",
                    border: InputBorder.none,
                  ),
                  obscureText: true,
                  style: new TextStyle(fontSize: 16, color: Colors.black),
                  onSaved: (value) {
                    password = value;
                  },
                  validator: (value) {
                    return value.trim().length > 0 ? null : "密码不能为空";
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildSignInButton() {
    return new GestureDetector(
      child: new Container(
        padding: EdgeInsets.only(left: 42, right: 42, top: 10, bottom: 10),
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.grey
        ),
        child: new Text(
          "LOGIN",
          style: new TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      onTap: () {
        var signinform = _SignInFormKey.currentState;
        if (signinform.validate()) {
          signinform.save();
          print(username);
          widget.signin(username, password);
        }
      },
    );
  }
}
