import 'dart:developer';

import 'package:ostad_crafty_bay/data/models/home/popular/product_model.dart';
import 'package:ostad_crafty_bay/data/services/network_caller.dart';
import 'package:ostad_crafty_bay/data/services/network_response.dart';
import 'package:ostad_crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class ProductListController extends GetxController {
  bool _isProductsInProgress = false;
  ProductModel _productModel = ProductModel();
  String _message = '';

  ProductModel get productModel => _productModel;

  bool get isProductsInProgress => _isProductsInProgress;

  String get message => _message;

  Future<bool> getProductsByCategory({required int categoryId}) async {
    _isProductsInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(Urls.getProductByCategory(categoryId:categoryId));

    log("productListControllerGetRequest statusCode ==> ${response.statusCode}");
    log("productListControllerGetRequest body ==> ${response.body}");


    _isProductsInProgress = false;
    if (response.isSuccess) {
      _productModel = ProductModel.fromJson(response.body ?? {});
      update();
      return true;
    } else {
      _message = 'Product list data fetch failed!';
      update();
      return false;
    }
  }
void setProducts(ProductModel productModel){
  _productModel = productModel;
  update();
}

}