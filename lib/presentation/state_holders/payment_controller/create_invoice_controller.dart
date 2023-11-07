import 'dart:developer';

import 'package:ostad_crafty_bay/data/models/payment/incoive_create_response_model.dart';
import 'package:ostad_crafty_bay/data/models/payment/invoice_create_data.dart';
import 'package:ostad_crafty_bay/data/services/network_caller.dart';
import 'package:ostad_crafty_bay/data/services/network_response.dart';
import 'package:ostad_crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class CreateInvoiceController extends GetxController{
  bool _isCreateInvoiceInProgress = false;
  InvoiceCreateResponseModel _invoiceCreateResponseModel = InvoiceCreateResponseModel();
  String _errorMessage = '';

  bool get isCreateInvoiceInProgress => _isCreateInvoiceInProgress;
  InvoiceCreateResponseModel get invoiceCreateResponseModel => _invoiceCreateResponseModel;
  //InvoiceCreateData? get invoiceCreateResponseModel => _invoiceCreateResponseModel.data?.first;
  String get errorMessage => _errorMessage;

  Future<bool>createInvoice()async{
    _isCreateInvoiceInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(Urls.createInvoice);

    log("createInvoiceControllerGetRequest statusCode ==> ${response.statusCode}");
    log("createInvoiceControllerGetRequest body ==> ${response.body}");

    _isCreateInvoiceInProgress = false;

    if(response.isSuccess){
      _invoiceCreateResponseModel = InvoiceCreateResponseModel.fromJson(response.body);
      update();
      return true;
    }else{
      _errorMessage = 'Invoice creation failed';
      update();
      return false;
    }
  }
}