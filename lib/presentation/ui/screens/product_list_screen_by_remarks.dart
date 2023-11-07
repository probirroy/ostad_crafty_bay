import 'package:ostad_crafty_bay/data/models/home/popular/product_data.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/product_controller/popular_product_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/product_controller/product_list_controller.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/product_details_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/constants.dart';
import 'package:ostad_crafty_bay/presentation/ui/widgets/home/category_card.dart';
import 'package:ostad_crafty_bay/presentation/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreenByRemarks extends StatefulWidget {
  final List<ProductData> productData;
  const ProductListScreenByRemarks({Key? key, required this.productData}) : super(key: key);

  @override
  State<ProductListScreenByRemarks> createState() => _ProductListScreenByRemarksState();
}

class _ProductListScreenByRemarksState extends State<ProductListScreenByRemarks> {

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     Get.find<PopularProductController>().getPopularProduct();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        title:  Text(
          widget.productData[0].remark ?? '',
          // widget.categoryName,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: widget.productData.isEmpty
          ? const Center(
        child: Text('No data available!'),
      )
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
        child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: widget.productData.length,
                itemBuilder: (context, index) {
                  return  FittedBox(
                    child: ProductCard(
                      image: widget.productData?[index].image ?? '',
                      title: widget.productData?[index].title ?? '',
                      price: widget.productData?[index].price ?? '',
                      rating: (widget.productData?[index].star ?? 0).toInt(),
                      onTap: () {
                        // Get.to(()=>const ProductDetailsScreen(productData: " ",),transition: PageChangingAnimation.sendTransition,duration: PageChangingAnimation.duration);
                      },),
                  );
                },
              )


      ),
    );
  }
}














// import 'package:crafty_bay/data/models/home/popular/product_data.dart';
// import 'package:crafty_bay/presentation/state_holders/product_controller/popular_product_controller.dart';
// import 'package:crafty_bay/presentation/state_holders/product_list_controller.dart';
// import 'package:crafty_bay/presentation/ui/screens/product_details_screen.dart';
// import 'package:crafty_bay/presentation/ui/utility/constants.dart';
// import 'package:crafty_bay/presentation/ui/widgets/home/category_card.dart';
// import 'package:crafty_bay/presentation/ui/widgets/product_card.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ProductListScreenByRemarks extends StatefulWidget {
//   final List<ProductData> productData;
//   const ProductListScreenByRemarks({Key? key, required this.productData}) : super(key: key);
//
//   @override
//   State<ProductListScreenByRemarks> createState() => _ProductListScreenByRemarksState();
// }
//
// class _ProductListScreenByRemarksState extends State<ProductListScreenByRemarks> {
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//   //     Get.find<PopularProductController>().getPopularProduct();
//   //   });
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: const BackButton(
//           color: Colors.black,
//         ),
//         title:  Text(
//          widget.productData[0].remark ?? '',
//          // widget.categoryName,
//           style: const TextStyle(
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
//         child: GetBuilder<ProductListController>(
//             builder: (_productListController) {
//               if(_productListController.isProductsInProgress){
//                 return  const Center(child: CircularProgressIndicator());
//               }
//               if(_productListController.productModel.data?.isEmpty ?? true){
//                 return const Center(child: Text("Empty"),);
//               }
//               return  GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   mainAxisSpacing: 16.0,
//                 ),
//                 itemCount: _productListController.productModel.data?.length ?? 0,
//                 itemBuilder: (context, index) {
//                   return  FittedBox(
//                     child: ProductCard(
//                       image: _productListController.productModel.data?[index].image ?? '',
//                       title: _productListController.productModel.data?[index].title ?? '',
//                       price: _productListController.productModel.data?[index].price ?? '',
//                       rating: (_productListController.productModel.data?[index].star ?? 0).toInt(),
//                       onTap: () {
//                         // Get.to(()=>const ProductDetailsScreen(productData: " ",),transition: PageChangingAnimation.sendTransition,duration: PageChangingAnimation.duration);
//                       },),
//                   );
//                 },
//               );
//             }
//         ),
//       ),
//     );
//   }
// }
