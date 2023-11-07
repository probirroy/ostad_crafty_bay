import 'package:ostad_crafty_bay/data/models/product_review_model.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/product_controller/product_review_controller.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/review_add_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/color_palette.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewListScreen extends StatefulWidget {
  final int productId;
  const ReviewListScreen({Key? key, required this.productId}) : super(key: key);

  @override
  State<ReviewListScreen> createState() => _ReviewListScreenState();
}

class _ReviewListScreenState extends State<ReviewListScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      Get.find<ProductReviewController>().getProductReview(productId: widget.productId);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black54,
        ),
          title: const Text(
            "Reviews",
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
      body: RefreshIndicator(
        onRefresh: () async{
          Get.find<ProductReviewController>().getProductReview(productId: widget.productId);
        },
        child: GetBuilder<ProductReviewController>(
          builder: (_productReviewController) {
            return Column(
              children: [
                Expanded(
                  child:_productReviewController.isProductReviewInProgress ? const Center(child: CircularProgressIndicator()) : ListView.separated(
                    itemCount: _productReviewController.productReviewModel.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          shape: BoxShape.circle),
                                      child: const Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Icon(
                                          Icons.person_outlined,
                                          size: 18,
                                          color: Colors.blueAccent,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16.0,
                                    ),
                                     Text(
                                     _productReviewController.productReviewModel.data?[index].profile?.cusName ?? '',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey),
                                    ),
                                    Spacer(),
                                    const Icon(
                                      Icons.star,
                                      size: 18,
                                      color: Colors.amber,
                                    ),
                                    Text(
                                      _productReviewController.productReviewModel.data?.first.rating ?? '',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  _productReviewController.productReviewModel.data?[index].description ?? '',
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    letterSpacing: 0.4,
                                    wordSpacing: 0.4,
                                  ),
                                  textAlign: TextAlign.justify,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 8.0,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16.0,right: 16.0,top: 15,bottom: 55),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text('Total Reviews (${ _productReviewController.productReviewModel.data?.length ?? 0})', style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.black54
                      ),),
                      FloatingActionButton(onPressed: (){
                        Get.to(()=> ReviewAddScreen(productId: widget.productId,),transition: PageChangingAnimation.sendTransition,duration: PageChangingAnimation.duration);
                      },child: const Icon(Icons.add),),
                      ],
                  ),
                )
              ],
            );
          }
        ),
      )
    );
  }
}
