import '../shared/network_helper.dart';

class OrdersRepository {
  static Future orders(status,page) async {
    return await NetworkHelper.repo("route=rest/order/orders&order_status=$status&limit=20&page=$page","get");
  }

  static Future reOrders(orderId,productId) async {
    return await NetworkHelper.repo("route=rest/order/orders&id=$orderId&order_product_id=$productId","post");
  }

}