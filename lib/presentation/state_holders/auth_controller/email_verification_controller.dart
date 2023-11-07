import 'dart:developer';

import 'package:ostad_crafty_bay/data/services/network_caller.dart';
import 'package:ostad_crafty_bay/data/services/network_response.dart';
import 'package:ostad_crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class EmailVerificationController extends GetxController{
  bool _emailVerificationInProgress = false;
  String _message = '';

  bool get emailVerificationInProgress => _emailVerificationInProgress;
  String get message => _message;

  Future<bool> verifyEmail({required String email}) async{
    _emailVerificationInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller.getRequest(Urls.verifyEmail(email: email));

    log("emailControllerGetRequest statusCode ==> ${response.statusCode}");
    log("emailControllerGetRequest body ==> ${response.body}");

    _emailVerificationInProgress = false;
    update();
    if(response.isSuccess){
      _message = response.body['data'];
      return true;
    }else{
      return false;
    }
  }
}