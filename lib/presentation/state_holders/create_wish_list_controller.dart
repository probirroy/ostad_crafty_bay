import 'dart:developer';

import 'package:ostad_crafty_bay/data/models/wish_list_model.dart';
import 'package:ostad_crafty_bay/data/services/network_caller.dart';
import 'package:ostad_crafty_bay/data/services/network_response.dart';
import 'package:ostad_crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class CreateWishListController extends GetxController{
  bool _isCreateWishListInProgress = false;
  String _message = "";

  bool get isCreateWishListInProgress => _isCreateWishListInProgress;

  String get message => _message;

  Future<bool> createWishListProduct({required int productId}) async{
    _isCreateWishListInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(Urls.createWishList(productId: productId));

    log("createWishListControllerGetRequest statusCode ==> ${response.statusCode}");
    log("createWishListControllerGetRequest body ==> ${response.body}");

    _isCreateWishListInProgress = false;

    if(response.isSuccess){
      update();
      return true;
    }else{
      _message = "WishList delete failed! Try again";
      update();
      return false;
    }
  }
}