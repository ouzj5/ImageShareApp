import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'dart:io';
class MyState {
  factory MyState() => _getInstance();
  int loginstate;
  int uid;
  String username;
  String password;
  static MyState _instance;
  MyState._() {
    loginstate = 0;
  }
  static MyState _getInstance() {
    if (_instance == null) {
      _instance = MyState._();
    }
    return _instance;
  }
  void setState(int i) {
    loginstate = i;
  }
  void setInfo(int uid, String username, String password) {
    this.uid = uid;
    this.username = username;
    this.password = password;
  }
  void reset() {
    loginstate = 0;
    this.username = "";
    this.password = "";
    this.uid = 0;
  }
}