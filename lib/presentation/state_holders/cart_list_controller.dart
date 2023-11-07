import 'dart:developer';

import 'package:ostad_crafty_bay/data/models/cart_list_model.dart';
import 'package:ostad_crafty_bay/data/services/network_caller.dart';
import 'package:ostad_crafty_bay/data/services/network_response.dart';
import 'package:ostad_crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class CartListController extends GetxController{
  bool _isCartListInProgress = false;
  String _message = '';
  CartListModel _cartListModel = CartListModel();
  double _totalPrice = 0;


  bool get isCartListInProgress => _isCartListInProgress;
  String get message => _message;
  CartListModel get cartListModel => _cartListModel;
  double get totalPrice => _totalPrice;

  Future<bool>getCartList()async{
    _isCartListInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(Urls.getCartList);

    log("cartListControllerGetRequest statusCode ==> ${response.statusCode}");
    log("cartListControllerGetRequest body ==> ${response.body}");


    _isCartListInProgress = false;

    if(response.isSuccess){
      _cartListModel = CartListModel.fromJson(response.body);
      _calculateTotalPrice();
      update();
      return true;
    }else{
      update();
      return false;
    }
  }
  void changeItem(int cartId,int noOfItems){
     _cartListModel.data?.firstWhere((element) => element.id == cartId).quantity = noOfItems;
     _calculateTotalPrice();
  }
  void _calculateTotalPrice(){
    _totalPrice =0;
    for(CartData data in _cartListModel.data ?? []){
      _totalPrice += ((data.quantity ?? 1) * (double.tryParse(data.product?.price ?? '0')?? 0));
    }
    update();
  }
}