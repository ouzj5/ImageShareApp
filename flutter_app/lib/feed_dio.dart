import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'dart:io';
class Mydio {
  factory Mydio() => _getInstance();
  Dio dio;
  var cookieJar;
  static Mydio _instance;
  Mydio._() {
    dio = new Dio();
    cookieJar = new CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    dio.options.contentType = ContentType.parse("application/x-www-form-urlencoded").toString();
  }
  static Mydio _getInstance() {
    if (_instance == null) {
      _instance = Mydio._();
    }
    return _instance;
  }
}