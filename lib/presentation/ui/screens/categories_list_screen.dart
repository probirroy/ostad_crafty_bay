import 'package:ostad_crafty_bay/presentation/state_holders/category_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/product_list_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/color_palette.dart';
import 'package:ostad_crafty_bay/presentation/ui/widgets/home/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CategoriesListScreen extends StatelessWidget {
  const CategoriesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
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
            "Categories",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async{
            Get.find<CategoryController>().getCategory();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 16),
            child: GetBuilder<CategoryController>(
              builder: (_categoryController) {
               if(_categoryController.isCategoryInProgress)
                   {
                    return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                         crossAxisCount: _categoryController.categoryModel.data?.length ?? 0,
                         mainAxisSpacing: 16.0,
                         crossAxisSpacing: 16.0
                     ),
                         itemCount: _categoryController.categoryModel.data?.length ?? 0,
                         itemBuilder: (context,index){
                           return SizedBox(
                             width: 80,
                             height: 200,
                             child: Stack(
                               children: [
                                 Center(
                                   child: Opacity(
                                     opacity: 0.03,
                                     child: SvgPicture.asset(
                                       AssetsPath.cadreBlackSVG,
                                       width: 50,
                                       height: 50,
                                       fit: BoxFit.cover,
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
                                         Expanded(
                                           child: Container(
                                             height: 80,
                                             width: 80,
                                             decoration: BoxDecoration(
                                               color: AppColors.primaryColor.withOpacity(0.2),
                                               borderRadius:
                                               BorderRadius.circular(16.0),
                                             ),
                                           ),
                                         ),
                                         const SizedBox(
                                           height: 8.0,
                                         ),
                                         Container(
                                           height: 16.0,
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
                         });
                   }
               if(_categoryController.categoryModel.data?.isEmpty ?? true){
                 return const Center(child: Text("Empty"),);
               }

                    return GridView.builder(
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 16.0,
                  ),
                  itemCount: _categoryController.categoryModel.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return  FittedBox(
                          child: CategoryCard(
                            image: _categoryController.categoryModel.data?[index].categoryImg ?? "",
                            categoryName: _categoryController.categoryModel.data?[index].categoryName ?? '',
                            onTab: () {
                              Get.to(()=> ProductListScreen(categoryId: _categoryController.categoryModel.data![index].id!, categoryName: _categoryController.categoryModel.data?[index].categoryName ?? '',));
                            },
                          ),
                        );
                  },
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
