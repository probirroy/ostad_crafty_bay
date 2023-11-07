import 'dart:developer';

import 'package:ostad_crafty_bay/data/models/home/popular/product_model.dart';
import 'package:ostad_crafty_bay/data/services/network_caller.dart';
import 'package:ostad_crafty_bay/data/services/network_response.dart';
import 'package:ostad_crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class SpecialProductController extends GetxController{
  ProductModel _specialProductModel = ProductModel();
  bool _isSpecialInProgress = false;
  String _errorMessage ='';

  ProductModel get specialProductModel => _specialProductModel;
  bool get isSpecialInProgress => _isSpecialInProgress;
  String get errorMessage => _errorMessage;

  Future<bool> getSpecialProduct()async{
    _isSpecialInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(Urls.getProductByRemark(remark: 'special'));

    log("SpecialProductControllerGetRequest statusCode ==> ${response.statusCode}");
    log("SpecialProductControllerGetRequest body ==> ${response.body}");

    _isSpecialInProgress = false;
    if(response.isSuccess){
      _specialProductModel = ProductModel.fromJson(response.body);
      update();
      return true;
    }else{
      _errorMessage = 'Fetch special product failed';
      update();
      return false;
    }
  }
}