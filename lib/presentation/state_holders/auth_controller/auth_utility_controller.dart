import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUtilityController{
  static String? _accessToken;

  static String? get accessToken => _accessToken;

  static Future<void>setAccessToken({required String token}) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await  sharedPreferences.setString('accessToken', token);
    _accessToken = token;
    debugPrint("Token: $_accessToken");
  }
  static Future<void> getAccessToken()async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _accessToken =  sharedPreferences.getString('accessToken');
    debugPrint("====>Token: $_accessToken");
  }
  static Future<void> clearInfo()async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
     sharedPreferences.clear();
  }
  static bool get isLoggedIn{
    return _accessToken != null;
  }

}