import 'dart:developer';

import 'package:ostad_crafty_bay/data/models/wish_list_model.dart';
import 'package:ostad_crafty_bay/data/services/network_caller.dart';
import 'package:ostad_crafty_bay/data/services/network_response.dart';
import 'package:ostad_crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class WishListController extends GetxController{
  bool _isWishListInProgress = false;
  WishListModel _wishListModel = WishListModel();
  String _message = "";

  bool get isWishListInProgress => _isWishListInProgress;
  WishListModel get wishListModel => _wishListModel;
  String get message => _message;

  Future<bool> getWishListProduct() async{
     _isWishListInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(Urls.getWishList);

     log("wishListControllerGetRequest statusCode ==> ${response.statusCode}");
     log("wishListControllerGetRequest body ==> ${response.body}");

    _isWishListInProgress = false;

    if(response.isSuccess){
      _wishListModel = WishListModel.fromJson(response.body);
      update();
      return true;
    }else{
      _message = "WishList product fetch failed! Try again";
      update();
      return false;
    }
  }
// -----------------------------delete wishList-------------------------
  Future<bool> deleteWishList({required int productId}) async{
    _isWishListInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(Urls.deleteWishList(productId: productId));
    _isWishListInProgress = false;

    if(response.isSuccess){
      _wishListModel.data?.removeWhere((element) => element.productId == productId);
      update();
      return true;
    }else{
      _message = "WishList product fetch failed! Try again";
      update();
      return false;
    }
  }
}