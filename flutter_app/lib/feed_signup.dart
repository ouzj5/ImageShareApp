import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:dio/dio.dart';

/**
 * 注册界面
 */
class SignUpPage extends StatefulWidget {
  final signup;
  const SignUpPage({Key key, this.signup}) : super(key: key);
  @override
  _SignUpPageState createState() => new _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String username;
  String password;
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
                height: 360,
                child: buildSignUpTextForm()
            ),

            new Positioned(
              child: buildSignInButton(),
              top: 340,)

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
                  hintText: "Name",
                  border: InputBorder.none
              ),
              style: new TextStyle(fontSize: 16, color: Colors.black),
              onSaved: (value) {
                username = value;
              },
                validator: (value) {
                  return value.trim().length > 0 ? null : "用户名不能为空";
                }
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
            ),
          ),
        ),
        new Container(
          height: 1,
          width: 250,
          color: Colors.grey[400],
        ),
        //密码
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 25, right: 25, top: 20, bottom: 20),
            child: new TextFormField(
              decoration: new InputDecoration(
                icon: new Icon(Icons.lock, color: Colors.black,),
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
        new Container(
          height: 1,
          width: 250,
          color: Colors.grey[400],
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 25, right: 25, top: 20, bottom: 20),
            child: new TextFormField(
              decoration: new InputDecoration(
                icon: new Icon(Icons.lock, color: Colors.black,),
                hintText: "Confirm Passowrd",
                border: InputBorder.none,
              ),
              obscureText: true,
              style: new TextStyle(fontSize: 16, color: Colors.black),
              validator: (value) {
                return value.trim() == password.trim() ? null : "密码前后不一致";
              },
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
          "SIGNUP",
          style: new TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      onTap: () {
          var signupform = _SignUpFormKey.currentState;
          print(username);
          signupform.save();
          if (signupform.validate()) {
            widget.signup(username, password);
          }
      },
    );
  }
}