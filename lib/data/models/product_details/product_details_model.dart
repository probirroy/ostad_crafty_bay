import 'package:ostad_crafty_bay/data/models/product_details/product_details_data.dart';

class ProductDetailsModel {
  String? msg;
  List<ProductDetailsData>? data;

  ProductDetailsModel({this.msg, this.data});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = <ProductDetailsData>[];
      json['data'].forEach((v) {
        data!.add(new ProductDetailsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



