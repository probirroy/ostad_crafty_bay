import 'dart:developer';

import 'package:ostad_crafty_bay/data/models/product_review_model.dart';
import 'package:ostad_crafty_bay/data/models/read_profile_model.dart';
import 'package:ostad_crafty_bay/data/services/network_caller.dart';
import 'package:ostad_crafty_bay/data/services/network_response.dart';
import 'package:ostad_crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class CreateProfileController extends GetxController{
  bool _isCreateProfileInProgress = false;
  String _errorMessage = '';

  bool get isCreateProfileInProgress => _isCreateProfileInProgress;
  String get errorMessage => _errorMessage;

  Future<bool> createUserProfile({
    required String cusName,
    required String cusAdd,
    required String cusCity,
    required String cusState,
    required String cusPostcode,
    required String cusCountry,
    required String cusPhone,
    required String cusFax,
    required String shipName,
    required String shipAdd,
    required String shipCity,
    required String shipState,
    required String shipPostcode,
    required String shipCountry,
    required String shipPhone
})async{
    _isCreateProfileInProgress = true;
    update();
    Map<String,dynamic> requestBody = {
      "cus_name": cusName,
      "cus_add": cusAdd,
      "cus_city": cusCity,
      "cus_state": cusState,
      "cus_postcode": cusPostcode,
      "cus_country": cusCountry,
      "cus_phone": cusPhone,
      "cus_fax": cusFax,
      "ship_name": shipName,
      "ship_add": shipAdd,
      "ship_city": shipCity,
      "ship_state": shipState,
      "ship_postcode": shipPostcode,
      "ship_country": shipCountry,
      "ship_phone": shipPhone
    };
    NetworkResponse response = await NetworkCaller.postRequest(Urls.createUserProfile, requestBody);

    log("profilePostRequest statusCode ==> ${response.statusCode}");
    log("profilePostRequest body ==> ${response.body}");


    _isCreateProfileInProgress = false;

    if(response.isSuccess){
      update();
      return true;
    }else{
      _errorMessage = "Create profile failed";
      update();
      return false;
    }
  }
}