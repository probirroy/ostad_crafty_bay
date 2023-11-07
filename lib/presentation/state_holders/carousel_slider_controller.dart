import 'dart:developer';

import 'package:ostad_crafty_bay/data/models/home/slider/slider_model.dart';
import 'package:ostad_crafty_bay/data/services/network_caller.dart';
import 'package:ostad_crafty_bay/data/services/network_response.dart';
import 'package:ostad_crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class CarouselSliderController extends GetxController{
  bool _iSliderInProgress = false;
  SliderModel _sliderModel = SliderModel();
  final String _message = '';

  SliderModel get sliderModel => _sliderModel;
  bool get isSliderInProgress =>  _iSliderInProgress;
  String get message => _message;

  Future<bool> getCarouselSlider()async{
    _iSliderInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(Urls.carouselSliderCard);

    log("carouselSliderControllerGetRequest statusCode ==> ${response.statusCode}");
    log("carouselSliderControllerGetRequest body ==> ${response.body}");

    _iSliderInProgress = false;

    if(response.isSuccess){
      update();
      _sliderModel = SliderModel.fromJson(response.body);
      return true;
    }else{
      update();
      return false;
    }
  }
}