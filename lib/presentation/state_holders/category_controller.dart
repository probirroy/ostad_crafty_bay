import 'dart:developer';

import 'package:ostad_crafty_bay/data/models/home/category/category_model.dart';
import 'package:ostad_crafty_bay/data/services/network_caller.dart';
import 'package:ostad_crafty_bay/data/services/network_response.dart';
import 'package:ostad_crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController{
  CategoryModel _categoryModel = CategoryModel();
  bool _isCategoryInProgress = false;
  String _message = '';

  CategoryModel get categoryModel => _categoryModel;
  bool get isCategoryInProgress => _isCategoryInProgress;
  String get message => _message;

  Future<bool> getCategory() async{
    _isCategoryInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(Urls.getCategoryList);

    log("categoryControllerGetRequest statusCode ==> ${response.statusCode}");
    log("categoryControllerGetRequest body ==> ${response.body}");


    _isCategoryInProgress = false;
    if(response.isSuccess){
      _categoryModel = CategoryModel.fromJson(response.body);
      update();
      return true;
    }else{
      update();
      return false;
    }
  }
}