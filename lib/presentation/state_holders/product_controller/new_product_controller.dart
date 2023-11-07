import 'dart:developer';

import 'package:ostad_crafty_bay/data/models/home/popular/product_model.dart';
import 'package:ostad_crafty_bay/data/services/network_caller.dart';
import 'package:ostad_crafty_bay/data/services/network_response.dart';
import 'package:ostad_crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class NewProductController extends GetxController{
  ProductModel _newProductModel = ProductModel();
  bool _isNewInProgress = false;
  String _errorMessage ='';

  ProductModel get newProductModel => _newProductModel;
  bool get isNewInProgress => _isNewInProgress;
  String get errorMessage => _errorMessage;

  Future<bool> getNewProduct()async{
    _isNewInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(Urls.getProductByRemark(remark: 'new'));

    log("newProductControllerGetRequest statusCode ==> ${response.statusCode}");
    log("newProductControllerGetRequest body ==> ${response.body}");


    _isNewInProgress = false;
    if(response.isSuccess){
      _newProductModel = ProductModel.fromJson(response.body);
      update();
      return true;
    }else{
      _errorMessage = 'Fetch popular product failed';
      update();
      return false;
    }
  }
}