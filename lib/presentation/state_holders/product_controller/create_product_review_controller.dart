import 'dart:developer';

import 'package:ostad_crafty_bay/data/models/product_review_model.dart';
import 'package:ostad_crafty_bay/data/services/network_caller.dart';
import 'package:ostad_crafty_bay/data/services/network_response.dart';
import 'package:ostad_crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class CreateProductReviewController extends GetxController{
  bool _isCreateReviewInProgress = false;
  String _errorMessage = '';

  bool get isCreateReviewInProgress => _isCreateReviewInProgress;
  String get errorMessage => _errorMessage;

  Future<bool> createProductReview({required String description,required int productId,required double rating})async{
    Map<String,dynamic>requestBody = {
      "description":description,
      "product_id":productId,
      "rating": rating
    };
    _isCreateReviewInProgress = true;
    update();

    NetworkResponse response = await NetworkCaller.postRequest(Urls.createProductReview, requestBody);

    log("createProductReviewControllerPostRequest statusCode ==> ${response.statusCode}");
    log("createProductReviewControllerPostRequest body ==> ${response.body}");

    _isCreateReviewInProgress = false;

    if(response.isSuccess){
      update();
      return true;
    }else{
      _errorMessage = "Create product review failed!";
      update();
      return false;
    }
  }
}