import 'package:ostad_crafty_bay/data/models/home/popular/product_data.dart';
import 'package:ostad_crafty_bay/data/models/product_details/product_details_data.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/add_to_cart_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/create_wish_list_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/product_controller/product_details_controlller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/wish_list_controller.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/cart_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/review_list_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/color_palette.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/constants.dart';
import 'package:ostad_crafty_bay/presentation/ui/widgets/color_picker.dart';
import 'package:ostad_crafty_bay/presentation/ui/widgets/custom_stepper.dart';
import 'package:ostad_crafty_bay/presentation/ui/widgets/product_carousel_slider.dart';
import 'package:ostad_crafty_bay/presentation/ui/widgets/size_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  const ProductDetailsScreen({Key? key, required this.productId, }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 0;
  int quantity = 1;
  bool tabWish = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ProductDetailsController>().getProductDetails(productId: widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // extendBodyBehindAppBar: true,
     //  appBar: AppBar(
     //    leading: BackButton(),
     //    backgroundColor: Colors.transparent,
     //    elevation: 0,
     //  ),
      body: GetBuilder<ProductDetailsController>(
        builder: (_productDetailsController) {
          return _productDetailsController.isProductDetailsInProgress ? const Center(child: CircularProgressIndicator()) : SafeArea(
            child: Column(
              children: [
               Expanded(
                 child: SingleChildScrollView(
                   child: Column(
                     children: [
                       Stack(
                         children: [
                             ProductCarouselSliderWidget(imageList: [
                                   _productDetailsController.productDetailsData.img1 ?? '',
                                   _productDetailsController.productDetailsData.img2 ?? '',
                                   _productDetailsController.productDetailsData.img3 ?? '',
                                   _productDetailsController.productDetailsData.img4 ?? '',
                            ],),
                           productDetailsAppBar,
                         ],
                       ),
                        productDetailsBody(_productDetailsController.productDetailsData),
                     ],
                   ),
                 ),
               ),
                cartToCartContainer(
                    _productDetailsController.productDetailsData),
              ],
            ),
          );
        }
      ),
    );
  }

  Padding  productDetailsBody(ProductDetailsData productDetailsData) {
    return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                             Expanded(
                              child:  Text(productDetailsData.product?.title ?? '',style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5
                              ),),
                            ),
                            CustomStepper(
                                lowerLimit: 1,
                                upperLimit: 10,
                                stepValue: 1,
                                value: 1,
                                onChange: (newValue) {
                                  quantity = newValue;
                                })
                          ],
                        ),
                        Row(
                          children: [
                             Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 18,
                                  color: Colors.amber,
                                ),
                                Text(
                                  "${productDetailsData.product?.star ?? 0}",
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blueGrey),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Get.to(()=> ReviewListScreen(productId: productDetailsData.id!,),transition: PageChangingAnimation.sendTransition,duration: PageChangingAnimation.duration);
                              },
                              child: const Text(
                                'Review',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            GetBuilder<CreateWishListController>(
                              builder: (_createWishListController) {
                                return InkWell(
                                  onTap: (){
                                    tabWish = !tabWish;
                                    if(tabWish == true){
                                      Get.snackbar("Added", "WishList is successfully added");
                                      _createWishListController.createWishListProduct(productId: widget.productId);
                                    }else{
                                      Get.snackbar("Remove", "WishList is successfully remove");
                                      Get.find<WishListController>().deleteWishList(productId: widget.productId);
                                    }
                                    setState(() {});

                                  },
                                  child:  Card(
                                    color: AppColors.primaryColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: tabWish ?const Icon(
                                        Icons.favorite_border,
                                        size: 16,
                                        color: Colors.red,
                                      ) : const Icon(
                                        Icons.favorite_border,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            )
                          ],
                        ),
                        const Text(
                          'Color',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                      const SizedBox(
                          height: 10.0,
                        ),

                        SizedBox(
                          height: 28,
                          child: SizePicker(
                            sizes: productDetailsData.color?.split(',') ?? [],
                            initialSelectedSize: 0,
                            onSelectedSize: (int index){
                              _selectedColorIndex = index;
                            },

                          ),
                        ),

                        // SizedBox(
                        //   height: 28,
                        //   child: ColorPicker(
                        //     colors: (productDetailsData.color?.split(',') ?? []).map((colorHex) {
                        //       final trimmedHex = colorHex.trim();
                        //       if (trimmedHex.length != 7 || !trimmedHex.startsWith("#")) {
                        //         // Handle invalid color format here if necessary
                        //         return Colors.transparent; // Or any default color
                        //       }
                        //       final hexColor = int.parse(trimmedHex.substring(1), radix: 16);
                        //       return Color(hexColor | 0xFF000000); // Set the alpha channel to 255 (fully opaque)
                        //     }).toList(),
                        //
                        //     initialSelectedColor: _selectedColorIndex,
                        //     onSelectedColor: (int index) {
                        //       _selectedColorIndex = index;
                        //     },
                        //   ),
                        // ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        const Text(
                          'Size',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 28,
                          child: SizePicker(
                            sizes: productDetailsData.size?.split(RegExp(r'[,]')) ?? [],
                              initialSelectedSize: 0,
                              onSelectedSize: (int index){
                                _selectedSizeIndex = index;
                              },

                          ),
                        ),
                        const SizedBox(height: 16,),
                        const Text('Description', style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700
                        ),),
                        const SizedBox(height: 16,),
                         Text(
                            productDetailsData.product?.shortDes ?? '',
                           textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  );
  }

  AppBar get productDetailsAppBar {
    return AppBar(
      leading: const BackButton(
        color: Colors.black54,
      ),
      title: const Text(
        "Product Details",
        style: TextStyle(color: Colors.black54),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Container  cartToCartContainer(ProductDetailsData productDetailsData) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
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
              Text(
                'Price',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black54),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
               "\$ ${ productDetailsData.product?.price ?? ''}",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppColors.primaryColor),
              ),
            ],
          ),
          GetBuilder<AddToCartController>(
            builder: (_addToCartController) {
              return SizedBox(
                width: 120,
                child: ElevatedButton(
                  onPressed: () {
                    String selectedColor = productDetailsData.color?.split(',')[_selectedColorIndex] ?? '';
                    String selectedSize = productDetailsData.size?.split(',')[_selectedSizeIndex] ?? '';

                    _addToCartController.addToCart(productId: productDetailsData.id!, color: selectedColor, size: selectedSize, quanity: quantity).then((value) {
                      if(value == true){
                        Get.snackbar("Success", "Product has been added in cart");
                       // Get.to(()=> CartScreen());
                      }else{
                        Get.snackbar("Failed", "Failed to add cart");
                      }
                    });
                  },
                  child:_addToCartController.isAddToCartInProgress ?  const Center(child: SizedBox(height: 20,width: 20, child: CircularProgressIndicator(color: Colors.white,))) : const Text('Add to cart'),
                ),
              );
            }
          )
        ],
      ),
    );
  }
}

/*
class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 0;
  int quantity = 1;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ProductDetailsController>().getProductDetails(productId: widget.productId,);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProductDetailsController>(
          builder: (productDetailsController) {
            if (productDetailsController.getProductDetailsInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ProductCarouselSliderWidget(
                                imageList: [
                                  productDetailsController.productDetailsData.img1 ?? '',
                                  productDetailsController.productDetailsData.img2 ?? '',
                                  productDetailsController.productDetailsData.img3 ?? '',
                                  productDetailsController.productDetailsData.img4 ?? '',
                                ],
                              ),
                              productDetailsAppBar,
                            ],
                          ),
                          productDetails(productDetailsController.productDetailsData,
                              productDetailsController.availableColors),
                        ],
                      ),
                    ),
                  ),
                  cartToCartBottomContainer(
                    productDetailsController.productDetailsData,
                    productDetailsController.availableColors,
                    productDetailsController.availableSizes,
                  ),
                ],
              ),
            );
          }
      ),
    );
  }

  Padding productDetails(ProductDetailsData productDetailsData, List<String> colors) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child: Text(
                    productDetailsData.product?.title ?? '',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5),
                  )),
              CustomStepper(
                  lowerLimit: 1,
                  upperLimit: 10,
                  stepValue: 1,
                  value: 1,
                  onChange: (newValue) {
                    quantity = newValue;
                  })
            ],
          ),
          Row(
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Icon(
                    Icons.star,
                    size: 18,
                    color: Colors.amber,
                  ),
                  Text(
                    '${productDetailsData.product?.star ?? 0}',
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueGrey),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Review',
                  style: TextStyle(
                      fontSize: 15,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const Card(
                color: AppColors.primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Icon(
                    Icons.favorite_border,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          const Text(
            'Color',
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 28,
            child: SizedBox(
              height: 28,
              child: SizePicker(
                initialSelectedSize: 0,
                onSelectedSize: (int selectedSize) {
                  _selectedColorIndex = selectedSize;
                },
                sizes: productDetailsData.color?.split(',') ?? [],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Size',
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 28,
            child: SizedBox(
              height: 28,
              child: SizePicker(
                initialSelectedSize: 0,
                onSelectedSize: (int selectedSize) {
                  _selectedColorIndex = selectedSize;
                },
                sizes: productDetailsData.size?.split(',') ?? [],
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Description',
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(productDetailsData.des ?? ''),
        ],
      ),
    );
  }

  AppBar get productDetailsAppBar {
    return AppBar(
      leading: const BackButton(
        color: Colors.black54,
      ),
      title: const Text(
        'Product details',
        style: TextStyle(color: Colors.black54),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Container cartToCartBottomContainer(ProductDetailsData details, List<String> colors, List<String> sizes) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price', style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black54
              ),),
              SizedBox(height: 4,),
              Text('\$1000', style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: AppColors.primaryColor
              ),),
            ],
          ),
          SizedBox(
            width: 120,
            child: GetBuilder<AddToCartController>(
                builder: (addToCartController) {
                  if (addToCartController.isAddToCartInProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ElevatedButton(
                    onPressed: () async {
                      final result = await addToCartController.addToCart(
                        productId: details.id!,
                    color: colors[_selectedColorIndex].toString(),
                    size: sizes[_selectedSizeIndex],
                    quanity: quantity,
                  );
                      if (result) {
                        Get.snackbar('Added to cart',
                            'This product has been added to cart list',
                            snackPosition: SnackPosition.BOTTOM);
                      }
                    },
                    child: const Text('Add to cart'),
                  );
                }
            ),
          )
        ],
      ),
    );
  }
}

*/


/*
 --------------------------------- main large code ----------------------------------
import 'package:crafty_bay/presentation/ui/screens/review_list_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/color_palette.dart';
import 'package:crafty_bay/presentation/ui/utility/constants.dart';
import 'package:crafty_bay/presentation/ui/widgets/custom_stepper.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _selectedColorIndex = 0;
  List<Color> colors =[
    Colors.deepOrange,
    Colors.amber,
    Colors.blue,
    Colors.yellow,
    Colors.pink,
    Colors.black,
  ];
  int _selectedSizeIndex = 0;
  List<String> sizes = [
    'S',
    'M',
    'L',
    'XL',
    'XXL',
    'XXXL'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // extendBodyBehindAppBar: true,
     //  appBar: AppBar(
     //    leading: BackButton(),
     //    backgroundColor: Colors.transparent,
     //    elevation: 0,
     //  ),
      body: SafeArea(
        child: Column(
          children: [
           Expanded(
             child: SingleChildScrollView(
               child: Column(
                 children: [
                   Stack(
                     children: [
                       const ProductCarouselSliderWidget(),
                       AppBar(
                         leading: const BackButton(
                             color: Colors.black54,
                         ),
                         title: const Text("Product Details",style: TextStyle(color: Colors.black54),),
                         backgroundColor: Colors.transparent,
                         elevation: 0,
                       ),
                     ],
                   ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                child:  Text("Addidas Shoe HK23454 - Black Edition",style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5
                                ),),
                              ),
                              CustomStepper(
                                  lowerLimit: 1,
                                  upperLimit: 10,
                                  stepValue: 1,
                                  value: 1,
                                  onChange: (newValue) {
                                    print(newValue);
                                  })
                            ],
                          ),
                          Row(
                            children: [
                              const Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 18,
                                    color: Colors.amber,
                                  ),
                                  Text(
                                    '4.5',
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blueGrey),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(()=>const ReviewListScreen(),transition: PageChangingAnimation.sendTransition,duration: PageChangingAnimation.duration);
                                },
                                child: const Text(
                                  'Review',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const Card(
                                color: AppColors.primaryColor,
                                child: Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Icon(
                                    Icons.favorite_border,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Text(
                            'Color',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        const SizedBox(
                            height: 10.0,
                          ),
                          SizedBox(
                            height: 28,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: colors.length,
                                itemBuilder: (context,index){
                                  return InkWell(
                                    borderRadius: BorderRadius.circular(16.0),
                                    onTap: (){
                                      _selectedColorIndex = index;
                                      if(mounted){
                                        setState(() {});
                                      }
                                    },
                                    child: CircleAvatar(
                                      radius: 18,
                                      backgroundColor: colors[index],
                                      child: _selectedColorIndex == index ? const Icon(Icons.done,color: Colors.white,) : null,
                                    ),
                                  );
                                }, separatorBuilder: (BuildContext context, int index) {
                                 return const SizedBox(width: 8.0);
                            },
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          const Text(
                            'Size',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          SizedBox(
                            height: 28,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: colors.length,
                              itemBuilder: (context,index){
                                return InkWell(
                                  borderRadius: BorderRadius.circular(4),
                                  onTap: (){
                                    _selectedSizeIndex =index;
                                    if(mounted){
                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(4.0),
                                      color: _selectedSizeIndex == index ? AppColors.primaryColor : null,
                                    ),
                                    child: Text(sizes[index],style: TextStyle(
                                      fontSize: _selectedSizeIndex == index ? 14 : null,
                                      fontWeight: _selectedSizeIndex == index ? FontWeight.bold : null,
                                      color: _selectedSizeIndex == index ? Colors.white : null,
                                    ),),
                                  )
                                );
                              }, separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox(width: 8.0);
                            },
                            ),
                          ),
                          const SizedBox(height: 16,),
                          const Text('Description', style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w700
                          ),),
                          const SizedBox(height: 16,),
                          const Text(
                              '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                                    '''
                          ),
                        ],
                      ),
                    ),
                 ],
               ),
             ),
           ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 16),
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price', style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black54
                    ),),
                    SizedBox(height: 4,),
                    Text('\$1000', style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: AppColors.primaryColor
                    ),),
                  ],
                ),
                SizedBox(
                  width: 120,
                  child: ElevatedButton(onPressed: () {}, child: const Text('Add to cart'),),)
              ],
            ),
            )
          ],
        ),
      ),
    );
  }
}


*/

/*
* import 'package:crafty_bay/data/models/home/popular/product_data.dart';
import 'package:crafty_bay/presentation/state_holders/product_details_controlller.dart';
import 'package:crafty_bay/presentation/ui/screens/review_list_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/color_palette.dart';
import 'package:crafty_bay/presentation/ui/utility/constants.dart';
import 'package:crafty_bay/presentation/ui/widgets/color_picker.dart';
import 'package:crafty_bay/presentation/ui/widgets/custom_stepper.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_carousel_slider.dart';
import 'package:crafty_bay/presentation/ui/widgets/size_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  const ProductDetailsScreen({Key? key, required this.productId, }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _selectedColorIndex = 0;
  List<Color> colors =[
    Colors.deepOrange,
    Colors.amber,
    Colors.blue,
    Colors.yellow,
    Colors.pink,
    Colors.black,
  ];
  int _selectedSizeIndex = 0;
  List<String> sizes = [
    'S',
    'M',
    'L',
    'XL',
    'XXL',
    'XXXL'
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ProductDetailsController>().getProductDetails(productId: widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // extendBodyBehindAppBar: true,
     //  appBar: AppBar(
     //    leading: BackButton(),
     //    backgroundColor: Colors.transparent,
     //    elevation: 0,
     //  ),
      body: GetBuilder<ProductDetailsController>(
        builder: (_productDetailsController) {
          return _productDetailsController.isProductDetailsInProgress ? const Center(child: CircularProgressIndicator()) : SafeArea(
            child: Column(
              children: [
               Expanded(
                 child: SingleChildScrollView(
                   child: Column(
                     children: [
                       Stack(
                         children: [
                             ProductCarouselSliderWidget(imageList: [
                                   _productDetailsController.productDetailsData.img1 ?? '',
                                   _productDetailsController.productDetailsData.img2 ?? '',
                                   _productDetailsController.productDetailsData.img3 ?? '',
                                   _productDetailsController.productDetailsData.img4 ?? '',
                            ],),
                           productDetailsAppBar,
                         ],
                       ),
                        productDetailsBody,
                     ],
                   ),
                 ),
               ),
                cartToCartContainer
              ],
            ),
          );
        }
      ),
    );
  }

  Padding get productDetailsBody {
    return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                             Expanded(
                              child:  Text(widget.productData.title ?? '',style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5
                              ),),
                            ),
                            CustomStepper(
                                lowerLimit: 1,
                                upperLimit: 10,
                                stepValue: 1,
                                value: 1,
                                onChange: (newValue) {
                                  print(newValue);
                                })
                          ],
                        ),
                        Row(
                          children: [
                             Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 18,
                                  color: Colors.amber,
                                ),
                                Text(
                                  "${widget.productData.star ?? 0}",
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blueGrey),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Get.to(()=>const ReviewListScreen(),transition: PageChangingAnimation.sendTransition,duration: PageChangingAnimation.duration);
                              },
                              child: const Text(
                                'Review',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const Card(
                              color: AppColors.primaryColor,
                              child: Padding(
                                padding: EdgeInsets.all(2.0),
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        const Text(
                          'Color',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                      const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 28,
                          child: ColorPicker(
                              colors: colors,
                              initialSelectedColor: 0,
                              onSelectedColor: (int index){
                                _selectedColorIndex = index;
                              }),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        const Text(
                          'Size',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 28,
                          child: SizePicker(
                              sizes: sizes,
                              initialSelectedSize: 0,
                              onSelectedSize: (int index){
                                _selectedSizeIndex = index;
                              },

                          ),
                        ),
                        const SizedBox(height: 16,),
                        const Text('Description', style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700
                        ),),
                        const SizedBox(height: 16,),
                         Text(
                            widget.productData.shortDes ?? '',
                           textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  );
  }

  AppBar get productDetailsAppBar {
    return AppBar(
      leading: const BackButton(
        color: Colors.black54,
      ),
      title: const Text(
        "Product Details",
        style: TextStyle(color: Colors.black54),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Container get cartToCartContainer {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
      decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Price',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.black54),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                '\$1000',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppColors.primaryColor),
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Add to cart'),
            ),
          )
        ],
      ),
    );
  }
}

*
* */