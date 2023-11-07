class Urls{
  Urls._();

  static const String _baseUrl = "https://ecom-api.teamrabbil.com/api";
  static String verifyEmail({required String email}) => "$_baseUrl/UserLogin/$email";
  static String verifyOtp({required String email,required String otp}) => "$_baseUrl/VerifyLogin/$email/$otp";
  static String carouselSliderCard = "$_baseUrl/ListProductSlider";
  static String getCategoryList = "$_baseUrl/CategoryList";
  static String getProductByRemark({required String remark}) => "$_baseUrl/ListProductByRemark/$remark";
  static String getProductDetails({required int productId}) => "$_baseUrl/ProductDetailsById/$productId";
  static String addToCard = "$_baseUrl/CreateCartList";
  static String getProductByCategory({required int categoryId}) => '$_baseUrl/ListProductByCategory/$categoryId';
  static String getCartList = "$_baseUrl/CartList";

  static String deleteCartListProduct({required int productId}) => "$_baseUrl/DeleteCartList/$productId";

  static String getWishList = "$_baseUrl/ProductWishList";
  static String createWishList({required int productId}) => "$_baseUrl/CreateWishList/$productId";
  static String deleteWishList({required int productId}) => "$_baseUrl/RemoveWishList/$productId";

  static String createProductReview = "$_baseUrl/CreateProductReview";
  static String getProductReview({required int productId}) => "$_baseUrl/ListReviewByProduct/$productId";

  static String readUserProfile = "$_baseUrl/ReadProfile";
  static String createUserProfile = "$_baseUrl/CreateProfile";


  static String createInvoice = "$_baseUrl/InvoiceCreate";
  static String invoiceList = "$_baseUrl/InvoiceList";

}