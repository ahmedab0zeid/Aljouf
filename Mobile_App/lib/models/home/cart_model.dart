import 'package:aljouf/models/home/products_model.dart';

class CartModel {
  int? success;
  List<String>? error;
  Data? data;

  CartModel({this.success, this.error, this.data});

  CartModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    error = json["error"]==null ? null : List<String>.from(json["error"]);
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["success"] = success;
    if(error != null) {
      data["error"] = error;
    }
    if(this.data != null) {
      data["data"] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  String? weight;
  List<Products>? products;
  List<dynamic>? vouchers;
  String? couponStatus;
  String? coupon;
  String? voucherStatus;
  String? voucher;
  bool? rewardStatus;
  String? reward;
  List<Totals>? totals;
  String? total;
  dynamic totalRaw;
  dynamic totalProductCount;
  dynamic hasShipping;
  dynamic hasDownload;
  dynamic hasRecurringProducts;
  Currency? currency;

  Data({this.weight, this.products, this.vouchers, this.couponStatus, this.coupon, this.voucherStatus, this.voucher, this.rewardStatus, this.reward, this.totals, this.total, this.totalRaw, this.totalProductCount, this.hasShipping, this.hasDownload, this.hasRecurringProducts, this.currency});

  Data.fromJson(Map<String, dynamic> json) {
    weight = json["weight"];
    products = json["products"]==null ? null : (json["products"] as List).map((e)=>Products.fromJson(e)).toList();
    vouchers = json["vouchers"] ?? [];
    couponStatus = json["coupon_status"];
    coupon = json["coupon"];
    voucherStatus = json["voucher_status"];
    voucher = json["voucher"];
    rewardStatus = json["reward_status"];
    reward = json["reward"];
    totals = json["totals"]==null ? null : (json["totals"] as List).map((e)=>Totals.fromJson(e)).toList();
    total = json["total"];
    totalRaw = json["total_raw"];
    totalProductCount = json["total_product_count"];
    hasShipping = json["has_shipping"];
    hasDownload = json["has_download"];
    hasRecurringProducts = json["has_recurring_products"];
    currency = json["currency"] == null ? null : Currency.fromJson(json["currency"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["weight"] = weight;
    if(products != null) {
      data["products"] = products?.map((e)=>e.toJson()).toList();
    }
    if(vouchers != null) {
      data["vouchers"] = vouchers;
    }
    data["coupon_status"] = couponStatus;
    data["coupon"] = coupon;
    data["voucher_status"] = voucherStatus;
    data["voucher"] = voucher;
    data["reward_status"] = rewardStatus;
    data["reward"] = reward;
    if(totals != null) {
      data["totals"] = totals?.map((e)=>e.toJson()).toList();
    }
    data["total"] = total;
    data["total_raw"] = totalRaw;
    data["total_product_count"] = totalProductCount;
    data["has_shipping"] = hasShipping;
    data["has_download"] = hasDownload;
    data["has_recurring_products"] = hasRecurringProducts;
    if(currency != null) {
      data["currency"] = currency?.toJson();
    }
    return data;
  }
}

class Currency {
  String? currencyId;
  String? symbolLeft;
  String? symbolRight;
  String? decimalPlace;
  String? value;

  Currency({this.currencyId, this.symbolLeft, this.symbolRight, this.decimalPlace, this.value});

  Currency.fromJson(Map<String, dynamic> json) {
    currencyId = json["currency_id"];
    symbolLeft = json["symbol_left"];
    symbolRight = json["symbol_right"];
    decimalPlace = json["decimal_place"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["currency_id"] = currencyId;
    data["symbol_left"] = symbolLeft;
    data["symbol_right"] = symbolRight;
    data["decimal_place"] = decimalPlace;
    data["value"] = value;
    return data;
  }
}

class Totals {
  String? title;
  String? text;
  dynamic value;

  Totals({this.title, this.text, this.value});

  Totals.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    text = json["text"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["text"] = text;
    data["value"] = value;
    return data;
  }
}


class Reviews {
  String? reviewTotal;

  Reviews({this.reviewTotal});

  Reviews.fromJson(Map<String, dynamic> json) {
    reviewTotal = json["review_total"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["review_total"] = reviewTotal;
    return data;
  }
}