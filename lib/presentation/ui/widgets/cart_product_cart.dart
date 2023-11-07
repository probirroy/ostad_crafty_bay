import 'package:cached_network_image/cached_network_image.dart';
import 'package:ostad_crafty_bay/data/models/cart_list_model.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/cart_list_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/delete_cart_list_product_controller.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/product_details_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/color_palette.dart';
import 'package:ostad_crafty_bay/presentation/ui/widgets/custom_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CartProductCard extends StatelessWidget {
  final CartData cartData;
  const CartProductCard({
    super.key, required this.cartData,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(()=> ProductDetailsScreen(productId: cartData.productId!) );
      },
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 90,
             decoration: BoxDecoration(
               color: AppColors.primaryColor.withOpacity(0.2),
               borderRadius:  BorderRadius.circular(12.0),
             ),
              child: CachedNetworkImage(
                imageUrl: cartData.product?.image ?? "", // Provide the URL of the image
                placeholder: (context, url) => SvgPicture.asset(AssetsPath.craftybayLogoSVG),
                errorWidget: (context, url, error) => SvgPicture.asset(AssetsPath.craftybayLogoSVG),
                fit: BoxFit.cover, // You can adjust this to your needs
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text(cartData.product?.title ?? '',style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                RichText(text:  TextSpan(
                                    style: const TextStyle(
                                        color: Colors.black54
                                    ),
                                    children: [
                                      TextSpan(text: 'Color: ${cartData.color ?? ''}'),
                                  WidgetSpan(
                                    child: SizedBox(
                                      width: 8.0,
                                    ),
                                  ),
                                  TextSpan(text: 'Size : ${cartData.size ?? ''}'),
                                    ]
                                ))
                              ],

                            ),
                          ),

                           GetBuilder<DeleteCartListProductController>(
                             builder: (_deleteCartListProductController) {
                               return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: IconButton(onPressed: () async{
                                  await _deleteCartListProductController.deleteCartProduct(productId: cartData.productId!);
                                  Get.find<CartListController>().getCartList();
                                }, icon: const Icon(Icons.delete_outline_outlined)),
                          );
                             }
                           )
                        ],
                      ),
                      Row(
                        children: [
                           Text("\$ ${cartData.product?.price ?? 0}",style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),),
                          const Spacer(),
                          SizedBox(
                           width: 85,
                            child: FittedBox(
                              child: CustomStepper(
                                  lowerLimit: 1,
                                  upperLimit: 10,
                                  stepValue: 1,
                                  //value: cartData.numberOfItems,
                                  value: cartData.quantity ?? 1,
                                  onChange: (int value){
                                    Get.find<CartListController>().changeItem(cartData.id!, value);
                                  }),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
