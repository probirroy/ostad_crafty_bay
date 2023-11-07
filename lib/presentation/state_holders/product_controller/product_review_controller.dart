import 'dart:developer';

import 'package:ostad_crafty_bay/data/models/product_review_model.dart';
import 'package:ostad_crafty_bay/data/services/network_caller.dart';
import 'package:ostad_crafty_bay/data/services/network_response.dart';
import 'package:ostad_crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class ProductReviewController extends GetxController{
  bool _isProductReviewInProgress = false;
  ProductReviewModel _productReviewModel = ProductReviewModel();
  String _errorMessage = '';

  bool get isProductReviewInProgress => _isProductReviewInProgress;
  ProductReviewModel get productReviewModel => _productReviewModel;
  String get errorMessage => _errorMessage;

  Future<bool> getProductReview({required int productId})async{
    _isProductReviewInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.getRequest(Urls.getProductReview(productId: productId));

    log("productReviewControllerGetRequest statusCode ==> ${response.statusCode}");
    log("productReviewControllerGetRequest body ==> ${response.body}");

    _isProductReviewInProgress = false;

    if(response.isSuccess){
      _productReviewModel = ProductReviewModel.fromJson(response.body);
      update();
      return true;
    }else{
      _errorMessage = "Get product review failed!";
      update();
      return false;
    }
  }
}