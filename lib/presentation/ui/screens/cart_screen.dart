import 'package:ostad_crafty_bay/presentation/state_holders/cart_list_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/payment/checkout_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/color_palette.dart';
import 'package:ostad_crafty_bay/presentation/ui/widgets/cart_product_cart.dart';
import 'package:ostad_crafty_bay/presentation/ui/widgets/custom_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<CartListController>().getCartList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
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
          "Cart",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body:  GetBuilder<CartListController>(builder: (_cartListController) {
        if (_cartListController.isCartListInProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (_cartListController.cartListModel.data != null &&
            _cartListController.cartListModel.data!.isEmpty) {
          return Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/error.gif",
                height: 60,
                width: 60,
              ),
              Text("Cart List is Empty"),
            ],
          ));
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount:
                _cartListController.cartListModel.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return CartProductCard(cartData: _cartListController.cartListModel.data![index]);
                },
              ),
            ),
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Price',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        '\$ ${_cartListController.totalPrice}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        if(Get.find<CartListController>().cartListModel.data?.isNotEmpty ?? false){
                          Get.to(()=>CheckoutScreen());
                        }
                      },
                      child: const Text('Checkout'),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}







