import 'dart:developer';

import 'package:ostad_crafty_bay/data/models/product_details/product_details_data.dart';
import 'package:ostad_crafty_bay/data/models/product_details/product_details_model.dart';
import 'package:ostad_crafty_bay/data/services/network_caller.dart';
import 'package:ostad_crafty_bay/data/services/network_response.dart';
import 'package:ostad_crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';


class ProductDetailsController extends GetxController{
  bool _isProductDetailsInProgress = false;
  ProductDetailsData _productDetailsData = ProductDetailsData();
  String _errorMessage = '';

  bool  get isProductDetailsInProgress => _isProductDetailsInProgress;
  ProductDetailsData get productDetailsData => _productDetailsData;
  String get errorMessage => _errorMessage;

  Future<bool>getProductDetails({required int productId})async{
    _isProductDetailsInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(Urls.getProductDetails(productId: productId));

    log("productDetailsControllerGetRequest statusCode ==> ${response.statusCode}");
    log("productDetailsControllerGetRequest body ==> ${response.body}");


    _isProductDetailsInProgress = false;
    if(response.isSuccess){
      _productDetailsData = ProductDetailsModel.fromJson(response.body ?? {}).data!.first;
      update();
      return true;
    }else{
      _errorMessage = 'fetch product details failed';
      update();
      return false;
    }
  }
}


/*
class ProductDetailsController extends GetxController {
  bool _getProductDetailsInProgress = false;
  ProductDetailsData _productDetailsData = ProductDetailsData();
  String _errorMessage = '';
  final List<String> _availableColors = [];
  List<String> _availableSizes = [];

  bool get getProductDetailsInProgress => _getProductDetailsInProgress;

  ProductDetailsData get productDetailsData => _productDetailsData;

  List<String> get availableColors => _availableColors;

  List<String> get availableSizes => _availableSizes;

  String get errorMessage => _errorMessage;

  Future<bool>getProductDetails({required int productId})async {
    _getProductDetailsInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(Urls.getProductDetails(productId: productId));
    _getProductDetailsInProgress = false;
    if (response.isSuccess) {
      _productDetailsData = (ProductDetailsModel.fromJson(response.body ?? {})).data!.first;
      _convertStringToColor(_productDetailsData.color ?? '');
      _convertStringToSizes(_productDetailsData.size ?? '');
      update();
      return true;
    } else {
      _errorMessage = 'Fetch product details has been failed! Try again.';
      update();
      return false;
    }
  }

  void _convertStringToColor(String color) {
    _availableColors.clear();
    final List<String> splittedColors = color.split(',');
    for (String c in splittedColors) {
      if (c.isNotEmpty) {
        _availableColors.add(c);
      }
    }
  }

  void _convertStringToSizes(String sizes) {
    _availableSizes = sizes.split(',');
  }

}*/
