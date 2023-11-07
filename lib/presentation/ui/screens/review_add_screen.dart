import 'package:ostad_crafty_bay/presentation/state_holders/product_controller/create_product_review_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/product_controller/product_review_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewAddScreen extends StatefulWidget {
  final int productId;
  const ReviewAddScreen({Key? key, required this.productId}) : super(key: key);

  @override
  State<ReviewAddScreen> createState() => _ReviewAddScreenState();
}

class _ReviewAddScreenState extends State<ReviewAddScreen> {
  TextEditingController _cusController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _ratingController = TextEditingController();

  GlobalKey<FormState>_formKey = GlobalKey<FormState>();

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
          "Create Review",
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 32.0,),
                TextFormField(
                  controller: _cusController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "First Name",
                    hintStyle: TextStyle(color: Colors.grey)
                  ),
                  validator: (String? value){
                    if(value?.isEmpty ?? true){
                      "Enter your first name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0,),
                TextFormField(
                  controller: _ratingController,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Rating",
                      hintStyle: TextStyle(color: Colors.grey)
                  ),
                  validator: (String? value){
                    if(value?.isEmpty ?? true){
                      "Enter your first name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0,),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 8,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Description",
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 16.0,
                      )
                  ),
                  validator: (String? value){
                    if(value?.isEmpty ?? true){
                      "Enter your description";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0,),
               GetBuilder<CreateProductReviewController>(
                 builder: (_createProductReviewController) {
                   return SizedBox(
                       width: double.infinity,
                      child: ElevatedButton(
                        onPressed: ()async {
                          if(_formKey.currentState!.validate()){
                            final response = await _createProductReviewController
                              .createProductReview(
                            description: _descriptionController.text.trim(),
                            productId: widget.productId,
                            rating: double.parse(_ratingController.text.trim()),
                          );
                          if(response == true){
                              _cusController.clear();
                              _ratingController.clear();
                              _descriptionController.clear();
                              Get.snackbar("Success", "Review has been added");
                             if(mounted){
                               Navigator.pop(context);
                               Get.find<ProductReviewController>().getProductReview(productId: widget.productId);
                             }
                            }else{
                              Get.snackbar("Failed", "Add review failed! Try again.");
                            }
                          }
                        },
                        child:_createProductReviewController.isCreateReviewInProgress ? const Center(
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 4,
                                    )),
                              ),
                              SizedBox(width: 30,),
                              Text("Please wait",style: TextStyle(
                                color: Colors.white,
                              ),),
                            ],),
                        ) : const Text("Submit"),
                      ),
                    );
                 }
               ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
