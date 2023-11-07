import 'package:ostad_crafty_bay/presentation/state_holders/add_to_cart_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/auth_controller/create_profile_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/auth_controller/email_verification_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/auth_controller/otp_verification_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/auth_controller/read_profile_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/carousel_slider_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/cart_list_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/category_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/product_controller/create_product_review_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/create_wish_list_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/delete_cart_list_product_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/payment_controller/create_invoice_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/payment_controller/invoice_list_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/product_controller/new_product_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/product_controller/popular_product_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/product_controller/special_product_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/product_controller/product_details_controlller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/product_controller/product_list_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/product_controller/product_review_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/theme_mode_controller.dart';
import 'package:ostad_crafty_bay/presentation/state_holders/wish_list_controller.dart';
import 'package:get/get.dart';

class StateHolderBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(MainBottomNavController());
    Get.put(EmailVerificationController());
    Get.put(OtpVerificationController());
    Get.put(CarouselSliderController());
    Get.put(CategoryController());
    Get.put(PopularProductController());
    Get.put(SpecialProductController());
    Get.put(NewProductController());
    Get.put(ProductDetailsController());
    Get.put(AddToCartController());
    Get.put(ProductListController());
    Get.put(CartListController());
    Get.put(DeleteCartListProductController());
    Get.put(WishListController());
    Get.put(CreateWishListController());
    Get.put(ProductReviewController());
    Get.put(CreateProductReviewController());
    Get.put(ReadProfileController());
    Get.put(CreateProfileController());
    Get.put(ThemeModeController());
    Get.put(CreateInvoiceController());
    Get.put(InvoiceListController());
  }
}