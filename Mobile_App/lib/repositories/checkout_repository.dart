import 'dart:convert';

import '../shared/network_helper.dart';
import 'package:http/http.dart' as http;

class CheckoutRepository{
  static Future countries() async {
    return await NetworkHelper.repo("route=feed/rest_api/countries","get");
  }

  static Future states(id) async {
    return await NetworkHelper.repo("route=feed/rest_api/countries&id=$id","get");
  }


  static Future cities(id) async {
    return await NetworkHelper.repo("route=feed/rest_api/cities&id=$id","get");
  }

  static Future saveShippingAddress(formData) async {
    return await NetworkHelper.repo("route=rest/shipping_address/shippingaddress","post",formData: formData);
  }

  static Future saveBillingAddress(formData) async {
    return await NetworkHelper.repo("route=rest/payment_address/paymentaddress","post",formData: formData);
  }

  static Future paymentMethods() async {
    return await NetworkHelper.repo("route=rest/payment_method/payments","get");
  }

  static Future savePaymentMethods(formData) async {
    return await NetworkHelper.repo("route=rest/payment_method/payments","post",formData: formData);
  }

  static Future shippingMethods() async {
    return await NetworkHelper.repo("route=rest/shipping_method/shippingmethods","get");
  }

  static Future saveShippingMethods(formData) async {
    return await NetworkHelper.repo("route=rest/shipping_method/shippingmethods","post",formData: formData);
  }

  static Future confirmOrder() async {
    return await NetworkHelper.repo("route=rest/confirm/confirm ","post");
  }

  static Future clearSessions() async {
    return await NetworkHelper.repo("route=rest/confirm/confirm ","put");
  }

  static Future<int> payWithPayfort(formData) async {
    print('https://sbpaymentservices.payfort.com/FortAPI/paymentApi');
    http.Response response = await http.post(Uri.parse("https://sbpaymentservices.payfort.com/FortAPI/paymentApi"),body: jsonEncode(formData),headers: {"Accept": "application/json"});
    return response.statusCode;
  }

}