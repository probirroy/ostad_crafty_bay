import 'dart:convert';
import 'dart:developer';

import 'package:ostad_crafty_bay/application/app.dart';
import 'package:ostad_crafty_bay/data/services/network_response.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/auth_controller/auth_utility_controller.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/auth/email_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NetworkCaller{
  ///----------------------------------->> get request method <<----------------------------------
  static Future<NetworkResponse> getRequest(String url,{bool isLogin = false}) async{
   try{
     Response response = await get(Uri.parse(url),headers: {'Content-Type': 'application/json','token': AuthUtilityController.accessToken.toString()}); //headers: {'Content-Type': 'application/json','token':AuthUtility.userInfo.token.toString()

    // log("getRequest statusCode ==> ${response.statusCode}");
    //  log("getRequest body ==> ${response.body}");

     if(response.statusCode == 200 ){
       return NetworkResponse(isSuccess: true, statusCode: response.statusCode, body: jsonDecode(response.body));
     }else if(response.statusCode == 401){
      if(isLogin == false){
        gotoLogin();
      }
     }else{
       return NetworkResponse(isSuccess: false, statusCode: response.statusCode, body: null);
     }

   }catch(e){
     log(e.toString());
   }
   return NetworkResponse(isSuccess: false, statusCode: -1, body: null);
  }

  ///----------------------------------->> post request method <<----------------------------------

  static Future<NetworkResponse> postRequest(String url,Map<String,dynamic>body,{bool isLogin = false}) async{
    try{
      Response response = await post(Uri.parse(url),headers: {'Content-Type': 'application/json','token': AuthUtilityController.accessToken.toString()}, body: jsonEncode(body)); // 'token': AuthUtility.userInfo.token.toString()

      log("postRequest statusCode ==> ${response.statusCode}");
      log("postRequest body ==> ${response.body}");

      if(response.statusCode == 200 && jsonDecode(response.body)['msg'] == 'success'){
        return NetworkResponse(isSuccess: true, statusCode: response.statusCode, body: jsonDecode(response.body));
      }else if(response.statusCode == 401){
        if (isLogin == false) {

          gotoLogin();
        }
      }else{
        return NetworkResponse(isSuccess: false, statusCode: response.statusCode, body: null);
      }
    }catch(e){
      log(e.toString());
    }
    return NetworkResponse(isSuccess: false, statusCode: -1, body: null);
  }

  static Future<void> gotoLogin() async {
    await AuthUtilityController.clearInfo();
    Navigator.pushAndRemoveUntil(
        CraftyBay.globalKey.currentContext!,
        MaterialPageRoute(builder: (context) => const EmailVerificationScreen()),
            (route) => false);
  }
}