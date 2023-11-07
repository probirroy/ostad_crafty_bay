import 'package:ostad_crafty_bay/application/app.dart';
import 'package:ostad_crafty_bay/data/models/home/popular/product_data.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/auth_controller/auth_utility_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/carousel_slider_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/category_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/product_controller/new_product_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/product_controller/popular_product_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/product_controller/special_product_controller.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/auth/create_profile_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/auth/read_profile_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/payment/invoice_list_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/product_details_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/product_list_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/product_list_screen_by_remarks.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/color_palette.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/constants.dart';
import 'package:ostad_crafty_bay/presentation/ui/widgets/home/category_card.dart';
import 'package:ostad_crafty_bay/presentation/ui/widgets/home/carousel_slider.dart';
import 'package:ostad_crafty_bay/presentation/ui/widgets/circular_icon_button.dart';
import 'package:ostad_crafty_bay/presentation/ui/widgets/home/home_section_title.dart';
import 'package:ostad_crafty_bay/presentation/ui/widgets/product_card.dart';
import 'package:ostad_crafty_bay/presentation/ui/widgets/shimmer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();
   bool _changeText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // logo fix
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            SvgPicture.asset(AssetsPath.craftybayLogoNavSVG),
            const Spacer(),
            CircularIconButton(
              icon: Icons.light_mode_outlined,
              onTap: (){
                themeModeController.toggleThemeMode();
               //  if(Get.isDarkMode){
               //    Get.changeThemeMode(ThemeMode.light);
               //  }
               // else{
               //    Get.changeThemeMode(ThemeMode.dark);
               //  }
              },
            ),
            const SizedBox(width: 8.0,),
            CircularIconButton(
              icon: Icons.person,
              onTap: (){
                Get.to(()=> const CreateProfileScreen());
              },
            ),
            const SizedBox(width: 8.0,),
            CircularIconButton(
              icon: Icons.call,
              onTap: (){
                _lunchPhoneUrl(phoneNumber: "01845565746");
              },
            ),
            const SizedBox(width: 8.0,),
            CircularIconButton(
              icon: Icons.notifications_active_outlined,
              onTap: (){
                Get.to(()=> InvoiceListScreen());
              },
            ),
            const SizedBox(width: 8.0,),
            CircularIconButton(
              icon: Icons.logout,
              onTap: () async {
                if(AuthUtilityController.accessToken != null){
                  await AuthUtilityController.clearInfo();
                  await AuthUtilityController.getAccessToken();
                  Get.snackbar(
                    'Success', 'Logout successful.',
                     backgroundColor: Colors.red.withOpacity(0.5),
                     colorText: Colors.white,
                  );
                }else{
                  Get.snackbar(
                  'Alert', 'You are not logged!',
                   backgroundColor: AppColors.primaryColor.withOpacity(0.5),
                    colorText: Colors.white,
                  );
                }


              },
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          Get.find<CarouselSliderController>().getCarouselSlider();
          Get.find<CategoryController>().getCategory();
          Get.find<PopularProductController>().getPopularProduct();
          Get.find<SpecialProductController>().getSpecialProduct();
          Get.find<NewProductController>().getNewProduct();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  onChanged: (String value){
                    if (value.isNotEmpty) {
                      _changeText = true;
                    } else {
                      _changeText = false;
                    }
                    setState(() {});
                  },
                  controller: _searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search",
                    hintStyle: const TextStyle(color:Colors.grey),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder:  const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder:  const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                      suffixIcon: InkWell(
                        onTap: () {
                            _searchController.clear();
                            _changeText = false;
                            setState(() {});
                        },
                        child: SizedBox(
                          width: 24.0,
                          height: 24.0,
                          child: Center(
                            child: _changeText ? const Icon(Icons.close, size: 20,) : null,
                          ),
                        ),

                      )


                  ),
                ),
                const SizedBox(height:16.0),
                GetBuilder<CarouselSliderController>(
                    builder: (_caroselSliderController) {
                      return  _caroselSliderController.isSliderInProgress ?
                      SizedBox(
                        // width: 200.0,
                        height: 180.0,
                        child: Stack(
                          children: [
                            Center(
                              child: Opacity(
                                opacity: 0.05,
                                child: SvgPicture.asset(
                                  AssetsPath.craftybayLogoSVG,
                                  width: double.infinity,
                                  height: 180,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor:Colors.black.withOpacity(0.04),
                                period: const Duration(milliseconds: 800),
                                direction: ShimmerDirection.ltr,
                                child: Container(
                                  height: 180,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                )
                            ),
                          ],
                        ),
                      ) : CarouselSliderWidget(
                        carouselSliders: _caroselSliderController.sliderModel.data ?? [],
                      );
                    }
                ),
                SectionHeader(
                  title: 'All Category',
                  onTap: () {
                    Get.find<MainBottomNavController>().changeScreen(1);
                    // Get.to(()=> const CategoriesListScreen(),transition: PageChangingAnimation.sendTransition,duration: PageChangingAnimation.duration);
                  },
                ),
                SizedBox(
                  height: 110,
                  child: GetBuilder<CategoryController>(
                      builder: (_categoryController) {
                        return _categoryController.isCategoryInProgress ?
                        ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context,index){
                            return SizedBox(
                              width: 80,
                              height: 120,
                              child: Stack(
                                children: [
                                  Center(
                                    child: Opacity(
                                      opacity: 0.09,
                                      child: FittedBox(
                                        child: Center(
                                          child: SvgPicture.asset(
                                            AssetsPath.craftybayLogoSVG,
                                            width: 80,
                                            height: 50,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor:
                                      Colors.black.withOpacity(0.04),
                                      period: const Duration(milliseconds: 800),
                                      direction: ShimmerDirection.ltr,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryColor.withOpacity(0.2),
                                              borderRadius:
                                              BorderRadius.circular(16.0),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          Container(
                                            height: 20,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryColor.withOpacity(0.2),
                                              borderRadius:
                                              BorderRadius.circular(16.0),
                                            ),
                                          ),

                                        ],
                                      )
                                  ),
                                ],
                              ),
                            );
                          }, separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            width: 16.0,
                          );
                        },)

                            : ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: getLength(_categoryController.categoryModel.data?.length ?? 0),
                          itemBuilder: (context, index) {
                            return CategoryCard(
                              image: _categoryController.categoryModel.data?[index].categoryImg ?? '',
                              categoryName: _categoryController.categoryModel.data?[index].categoryName ?? '',
                              onTab: () {
                                Get.to(()=> ProductListScreen(categoryId: _categoryController.categoryModel.data![index].id!, categoryName: _categoryController.categoryModel.data?[index].categoryName ?? '',));
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              width: 16.0,
                            );
                          },
                        );
                      }
                  ),
                ),

                SectionHeader(
                  title: 'Popular',
                  onTap: () {
                    Get.to(()=> ProductListScreen(productModel: Get.find<PopularProductController>().popularProductModel,),transition: PageChangingAnimation.sendTransition,duration:PageChangingAnimation.duration);
                  },
                ),
                GetBuilder<PopularProductController>(
                    builder: (_popularProductController) {
                      return SizedBox(
                        height: 170,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: getLength(_popularProductController.popularProductModel.data?.length ?? 4),
                          itemBuilder: (context, index) {
                            return _popularProductController.isPopularInProgress
                                ? const ShimmerCard()
                                :  ProductCard(
                              image: _popularProductController.popularProductModel.data?[index].image ?? '',
                              title: _popularProductController.popularProductModel.data?[index].title ?? '',
                              price: _popularProductController.popularProductModel.data?[index].price ?? '',
                              rating: (_popularProductController.popularProductModel.data?[index].star)?.toInt() ?? 0,
                              onTap: () {
                              Get.to(()=> ProductDetailsScreen(productId: _popularProductController.popularProductModel.data?[index].id ?? 0,),transition: PageChangingAnimation.sendTransition,duration: PageChangingAnimation.duration);
                            },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              width: 8.0,
                            );
                          },
                        ),
                      );
                    }
                ),

                SectionHeader(
                  title: 'Special',
                  onTap: () {
                    Get.to(()=> ProductListScreen(productModel: Get.find<SpecialProductController>().specialProductModel,),transition: PageChangingAnimation.sendTransition,duration:PageChangingAnimation.duration);
                  },
                ),
                GetBuilder<SpecialProductController>(
                  builder: (_specialProductController) {
                    return SizedBox(
                      height: 170,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: getLength(_specialProductController.specialProductModel.data?.length ?? 4),
                        itemBuilder: (context, index) {
                        return _specialProductController.isSpecialInProgress ? const ShimmerCard() : ProductCard(
                          image: _specialProductController.specialProductModel.data?[index].image ?? '',
                          title: _specialProductController.specialProductModel.data?[index].title ?? '',
                          price: _specialProductController.specialProductModel.data?[index].price ?? '',
                          rating: (_specialProductController.specialProductModel.data?[index].star ?? 0).toInt(),
                          onTap: () {
                                  Get.to(() =>  ProductDetailsScreen(productId: _specialProductController.specialProductModel.data?[index].id ?? 0), transition: PageChangingAnimation.sendTransition, duration: PageChangingAnimation.duration);
                                },
                              );
                      },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            width: 8.0,
                          );
                        },
                      ),
                    );
                  }
                ),

                SectionHeader(
                  title: 'New',
                  onTap: () {
                    Get.to(()=> ProductListScreen(productModel: Get.find<NewProductController>().newProductModel,),transition: PageChangingAnimation.sendTransition,duration:PageChangingAnimation.duration);
                  },
                ),
                GetBuilder<NewProductController>(
                  builder: (_newProductController) {
                    return SizedBox(
                      height: 170,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: getLength(_newProductController.newProductModel.data?.length ?? 4),
                        itemBuilder: (context, index) {
                        return _newProductController.isNewInProgress ? const ShimmerCard() : ProductCard(
                          image: _newProductController.newProductModel.data?[index].image ?? '',
                          title: _newProductController.newProductModel.data?[index].title ?? '',
                          price: _newProductController.newProductModel.data?[index].price ?? '',
                          rating: (_newProductController.newProductModel.data?[index].star ?? 0).toInt(), onTap: () {
                          Get.to(()=> ProductDetailsScreen(productId: _newProductController.newProductModel.data?[index].id ?? 0,),transition: PageChangingAnimation.sendTransition,duration: PageChangingAnimation.duration);
                        },
                        );
                      },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            width: 8.0,
                          );
                        },
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
  int getLength (int length){
    return length > 4 ? 4 : length;
  }

  _lunchPhoneUrl({required String phoneNumber}) async{
    String url = 'tel:$phoneNumber';
    try{
      if(await canLaunchUrl(Uri.parse(url))){
        await launchUrl(Uri.parse(url));
      }else{
        Get.snackbar("Error Occurred", "Can't be launch");
      }

    }catch(e){
      Get.snackbar("Error Occurred", "Can't be launch: $e");
    }
  }
}