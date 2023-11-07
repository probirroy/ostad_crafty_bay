import 'dart:developer';

import 'package:ostad_crafty_bay/data/models/product_review_model.dart';
import 'package:ostad_crafty_bay/data/models/read_profile_model.dart';
import 'package:ostad_crafty_bay/data/services/network_caller.dart';
import 'package:ostad_crafty_bay/data/services/network_response.dart';
import 'package:ostad_crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class ReadProfileController extends GetxController{
  bool _isReadProfileInProgress = false;
  ReadProfileModel _readProfileModel = ReadProfileModel();
  String _errorMessage = '';

  bool get isReadProfileInProgress => _isReadProfileInProgress;
  ReadProfileModel get profileModel => _readProfileModel;
  String get errorMessage => _errorMessage;

  Future<bool> getUserProfile()async{
    _isReadProfileInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(Urls.readUserProfile);

    log("readProfileControllerGetRequest statusCode ==> ${response.statusCode}");
    log("readProfileControllerGetRequest body ==> ${response.body}");

    _isReadProfileInProgress = false;

    if(response.isSuccess){
      _readProfileModel = ReadProfileModel.fromJson(response.body);

      update();
      return true;
    }else{
      _errorMessage = "Somthing worng";
      update();
      return false;
    }
  }
}