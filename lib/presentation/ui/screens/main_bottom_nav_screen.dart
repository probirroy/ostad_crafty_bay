import 'package:ostad_crafty_bay/data/models/home/popular/product_model.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/carousel_slider_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/category_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/product_controller/new_product_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/product_controller/popular_product_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/product_controller/special_product_controller.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/cart_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/categories_list_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/home_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/screens/wish_list_screen.dart';
import 'package:ostad_crafty_bay/presentation/ui/utility/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({Key? key}) : super(key: key);

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  MainBottomNavController mainBottomNavController = Get.put(MainBottomNavController());
 /// int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    CategoriesListScreen(),
    CartScreen(),
    WishListScreen(),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CarouselSliderController>().getCarouselSlider();
      Get.find<CategoryController>().getCategory();
      Get.find<PopularProductController>().getPopularProduct();
      Get.find<SpecialProductController>().getSpecialProduct();
      Get.find<NewProductController>().getNewProduct();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavController>(
      builder: (controller) {
        return Scaffold(
          body: _pages[controller.currentSelectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            currentIndex: controller.currentSelectedIndex,
            onTap: controller.changeScreen,
            items: const[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: "Dashboard",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: "Wishlist",
              ),
            ],
          ),
        );
      }
    );
  }
}
