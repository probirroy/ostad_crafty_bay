import 'dart:developer';

import 'package:ostad_crafty_bay/data/models/payment/invoice_list_model.dart';
import 'package:ostad_crafty_bay/data/services/network_caller.dart';
import 'package:ostad_crafty_bay/data/services/network_response.dart';
import 'package:ostad_crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class InvoiceListController extends GetxController{
  bool _isInvoiceListInProgress = false;
  List<InvoiceListModel>_invoiceList = [];
  String _errorMessage = '';

  bool get isInvoiceListInProgress => _isInvoiceListInProgress;
  List<InvoiceListModel> get invoiceList => _invoiceList;
  String get errorMessage => _errorMessage;

  Future<bool>getInvoiceList()async{
    _isInvoiceListInProgress = true;
    update();
    NetworkResponse response = await NetworkCaller.getRequest(Urls.invoiceList);

    log("InvoiceListControllerGetRequest statusCode ==> ${response.statusCode}");
    log("InvoiceListControllerGetRequest body ==> ${response.body}");

    _isInvoiceListInProgress = false;

    if(response.isSuccess){
      List<dynamic> jsonData = response.body;
      _invoiceList = jsonData.map((item) => InvoiceListModel.fromJson(item)).toList();
      update();
      return true;
    }else{
      _errorMessage = 'Invoice creation failed';
      update();
      return false;
    }
  }
}