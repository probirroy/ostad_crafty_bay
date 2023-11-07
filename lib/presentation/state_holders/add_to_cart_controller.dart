import 'dart:developer';

import 'package:ostad_crafty_bay/data/services/network_caller.dart';
import 'package:ostad_crafty_bay/data/services/network_response.dart';
import 'package:ostad_crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class AddToCartController extends GetxController{
  bool _isAddToCartInProgress = false;
  String _message = '';

  bool get isAddToCartInProgress => _isAddToCartInProgress;
  String get message => _message;

  Future<bool>addToCart({required int productId,required String color, required String size,required int quanity}) async {
    _isAddToCartInProgress = true;
    update();
    Map<String,dynamic> requestBody = {
        "product_id":productId,
        "color":color,
        "size":size,
        "qty": quanity,
    };
    final NetworkResponse response = await NetworkCaller.postRequest(Urls.addToCard, requestBody);

    log("addToCartPostRequest statusCode ==> ${response.statusCode}");
    log("addToCartPostRequest body ==> ${response.body}");


    _isAddToCartInProgress = false;
    update();

    if(response.isSuccess){
      return true;
    }else{
      _message = "failed to add cart";
      return false;
    }
  }
}