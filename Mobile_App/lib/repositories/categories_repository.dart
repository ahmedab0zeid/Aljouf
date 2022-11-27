import '../shared/network_helper.dart';

class CategoriesRepository{
  static Future fetchBanners() async {
    return await NetworkHelper.repo("route=feed/rest_api/banners&id=9","get",headerState: false);
  }

  static Future fetchCategories() async {
    return await NetworkHelper.repo("route=feed/rest_api/categories","get",headerState: false);
  }

  static Future fetchSubCategories(id) async {
    return await NetworkHelper.repo("route=feed/rest_api/categories&id=$id","get",headerState: false);
  }

  static Future productsByCatID(id,{search,page,sort = '',order = ''}) async {
    return await NetworkHelper.repo("route=feed/rest_api/products&category=${id??''}&search=${search??''}&sort=$sort&order=$order&limit=10&page=$page","get",headerState: false);
  }

  static Future productsOffers({page}) async {
    return await NetworkHelper.repo("route=feed/rest_api/specials&limit=8&page=$page","get",headerState: false);
  }

  static Future addReview(id, Map<String, String> formData) async {
    return await NetworkHelper.repo("route=feed/rest_api/reviews&id=$id","post",formData: formData);
  }

  static Future addToCart(Map<String, String> formData) async {
    return await NetworkHelper.repo("route=rest/cart/cart","post",formData: formData);
  }

  static Future changeQuantity(Map<String, String> formData) async {
    return await NetworkHelper.repo("route=rest/cart/cart","put",formData: formData);
  }

  static Future deleteItemFromCart(id) async {
    return await NetworkHelper.repo("route=rest/cart/cart&key=$id","delete");
  }

  static Future cart() async {
    return await NetworkHelper.repo("route=rest/cart/cart","get");
  }

  static Future wishList() async {
    return await NetworkHelper.repo("route=rest/wishlist/wishlist","get");
  }

  static Future addToWishList(id) async {
    return await NetworkHelper.repo("route=rest/wishlist/wishlist&id=$id","post");
  }

  static Future deleteFromWishList(id) async {
    return await NetworkHelper.repo("route=rest/wishlist/wishlist&id=$id","delete");
  }

  static Future addCoupon(coupon) async {
    return await NetworkHelper.repo("route=rest/cart/coupon","post",formData: {"coupon": coupon});
  }

  static Future deleteCoupon() async {
    return await NetworkHelper.repo("route=rest/cart/coupon","delete");
  }

}