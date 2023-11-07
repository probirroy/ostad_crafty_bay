import 'package:ostad_crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/wish_list_controller.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/product_details_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/constants.dart';
import 'package:ostad_crafty_bay/presentation/ui/widgets/home/category_card.dart';
import 'package:ostad_crafty_bay/presentation/ui/widgets/product_card.dart';
import 'package:ostad_crafty_bay/presentation/ui/widgets/wish_list.card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<WishListController>().getWishListProduct();

  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<MainBottomNavController>().backToHome();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.find<MainBottomNavController>().backToHome();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: const Text(
            "Wishlist",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
          child: GetBuilder<WishListController>(
            builder: (_wishListController) {
              if(_wishListController.isWishListInProgress){
                return Center(child: CircularProgressIndicator());
              }else if(_wishListController.wishListModel.data != null && _wishListController.wishListModel.data!.isEmpty){
                return Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/error.gif",
                      height: 60,
                      width: 60,
                    ),
                    Text("Wish List is Empty"),
                  ],
                ));
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: _wishListController.wishListModel.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return  FittedBox(
                    child: WishListCard(
                          image: _wishListController.wishListModel.data?.first.product?.image ?? '',
                          title: _wishListController.wishListModel.data?.first.product?.title ?? '',
                          price: _wishListController.wishListModel.data?.first.product?.price ?? '',
                          rating: _wishListController.wishListModel.data?.first.product?.star ?? 0,
                          onDeleteTap: () async {
                            await _wishListController.deleteWishList(productId: _wishListController.wishListModel.data!.first.productId!);
                            //_wishListController.getWishListProduct();
                          },
                          onTap: () {
                     Get.to(()=> ProductDetailsScreen(productId: _wishListController.wishListModel.data!.first.productId!,),transition: PageChangingAnimation.sendTransition,duration: PageChangingAnimation.duration);
                    }, ),
                  );
                },
              );
            }
          ),
        ),
      ),
    );
  }
}
