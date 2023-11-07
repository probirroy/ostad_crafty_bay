import 'package:ostad_crafty_bay/data/models/home/popular/product_model.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/product_controller/product_list_controller.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/product_details_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/constants.dart';
import 'package:ostad_crafty_bay/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatefulWidget {
 final int? categoryId;
 final String? categoryName;
 final String? title;
 final ProductModel? productModel;
  const ProductListScreen({Key? key,  this.categoryId,  this.categoryName,  this.productModel, this.title}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     if(widget.categoryId != null){
       Get.find<ProductListController>().getProductsByCategory(categoryId: widget.categoryId!);
     }else if(widget.productModel != null){
         Get.find<ProductListController>().setProducts(widget.productModel!);
       }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        title:   Text(
          (widget.categoryId != null)  ? widget.categoryName ?? '' : 'Product List',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
        child: GetBuilder<ProductListController>(
          builder: (_productListController) {
            if(_productListController.isProductsInProgress){
             return  const Center(child: CircularProgressIndicator());
            }
            if(_productListController.productModel.data?.isEmpty ?? true){
              return const Center(child: Text("Empty"),);
            }
            return  GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 16.0,
              ),
              itemCount: _productListController.productModel.data?.length ?? 0,
              itemBuilder: (context, index) {
                return  FittedBox(
                  child: ProductCard(image: _productListController.productModel.data?[index].image ?? '',
                    title: _productListController.productModel.data?[index].title ?? '',
                    price: _productListController.productModel.data?[index].price ?? '',
                    rating: (_productListController.productModel.data?[index].star ?? 0).toInt(),
                    onTap: () {
                      Get.to(()=> ProductDetailsScreen(productId: _productListController.productModel.data?[index].id ?? 0,),transition: PageChangingAnimation.sendTransition,duration: PageChangingAnimation.duration);
                  },),
                );
              },
            );
          }
        ),
      ),
    );
  }
}
