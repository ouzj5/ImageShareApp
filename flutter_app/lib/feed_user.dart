import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/feed_dio.dart';
import 'package:flutter_app/feed_info.dart';
import 'package:flutter_app/feed_login.dart';
import 'package:flutter_app/feed_signup.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'dart:io';

import 'package:flutter_app/feed_state.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  PageController _pageController;
  String username;
  String password;
  int _currentPage = 0;
  int loginstate = 0;
  @override
  void initState() {
    loginstate = new MyState().loginstate;
    username = new MyState().username;
    username = new MyState().password;
    super.initState();
    _pageController = new PageController();
  }
  Future<void> _signin(String username, String password) async {
    String url;
      url = "http://localhost:8080/login";
    var data;
    print(username);
    print(password);
    Response res = await new Mydio().dio.post(url,
        data: {"username": username, "password": password}, queryParameters:{});
    print(new Mydio().cookieJar.loadForRequest(Uri.parse("http://localhost:8080/login")));
    data = jsonDecode(res.toString());
    int uid = data['uid'];
    print(res.toString());
    setState(() {
      this.username = username;
      new MyState().setInfo(uid, username, password);
      loginstate = 1;
      new MyState().setState(1);
    });
  }
  Future<void> _signup(String username, String password) async {
    String url;
      url = "http://localhost:8080/signup";
    var data;
    Response res = await new Mydio().dio.post(url,
        data: {"username": username, "password": password}, queryParameters:{});
    data = jsonDecode(res.toString());
    int uid = data['uid'];
    setState(() {
      this.username = username;
      new MyState().setInfo(uid, username, password);
      new MyState().setState(1);
    });
  }
  Future<void> _logout() async {
    String url;
    url = "http://localhost:8080/logout";
    var data;
    Response res = await new Mydio().dio.get(url, queryParameters:{});
    print(res.toString());
    setState(() {
      new MyState().setInfo(0, "", "");
      new MyState().setState(0);
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new SafeArea(
          child: new SingleChildScrollView(
              child: new Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: new BoxDecoration(
                    //gradient: theme.Theme.primaryGradient,
                  ),
                  child: new Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      new SizedBox(
                        height: 75,
                      ),
                      new SizedBox(
                        height: 20,
                      ),
                      new Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Colors.grey,
                        ),
                        child: loginstate == 0 ? new Row(
                          children: <Widget>[
                            Expanded(
                                child: new Container(
                                  decoration: _currentPage == 0
                                      ? BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    color: Colors.white,
                                  )
                                      : null,
                                  child: new Center(
                                    child: new FlatButton(
                                      onPressed: () {
                                        _pageController.animateToPage(0,
                                            duration: Duration(milliseconds: 500),
                                            curve: Curves.decelerate);
                                      },
                                      child: new Text(
                                        "Existing",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                )),
                            Expanded(
                                child: new Container(
                                  decoration: _currentPage == 1
                                      ? BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    ),
                                    color: Colors.white,
                                  )
                                      : null,
                                  child: new Center(
                                    child: new FlatButton(
                                      onPressed: () {
                                        _pageController.animateToPage(1,
                                            duration: Duration(milliseconds: 500),
                                            curve: Curves.decelerate);
                                      },
                                      child: new Text(
                                        "New",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ) : null,
                      ),
                      new Expanded(child: new PageView(
                        controller: _pageController,
                        children: loginstate == 0 ? <Widget>[
                          new SignInPage(signin:(username, password)=>_signin(username, password),),
                          new SignUpPage(signup:(username, password)=>_signup(username, password),),
                        ] : <Widget>[
                          new InfoPage(logout: ()=>_logout()),
                        ],
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                      )),
                    ],
                  ))),
        ));
  }
}