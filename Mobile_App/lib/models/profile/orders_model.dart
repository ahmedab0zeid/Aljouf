class OrdersModel {
  int? success;
  List<dynamic>? error;
  List<Data>? data;

  OrdersModel({
    this.success,
    this.error,
    this.data,
  });

  OrdersModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] as int?;
    error = json['error'] as List?;
    data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['success'] = success;
    json['error'] = error;
    json['data'] = data?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Data {
  String? orderId;
  String? name;
  String? status;
  String? dateAdded;
  int? productTotal;
  List<Products>? products;
  String? total;
  String? currencyCode;
  String? currencyValue;
  String? totalRaw;
  int? timestamp;
  Currency? currency;

  Data({
    this.orderId,
    this.name,
    this.status,
    this.dateAdded,
    this.productTotal,
    this.products,
    this.total,
    this.currencyCode,
    this.currencyValue,
    this.totalRaw,
    this.timestamp,
    this.currency,
  });

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'] as String?;
    name = json['name'] as String?;
    status = json['status'] as String?;
    dateAdded = json['date_added'] as String?;
    productTotal = json['product_total'] as int?;
    products = (json['products'] as List?)?.map((dynamic e) => Products.fromJson(e as Map<String,dynamic>)).toList();
    total = json['total'] as String?;
    currencyCode = json['currency_code'] as String?;
    currencyValue = json['currency_value'] as String?;
    totalRaw = json['total_raw'] as String?;
    timestamp = json['timestamp'] as int?;
    currency = (json['currency'] as Map<String,dynamic>?) != null ? Currency.fromJson(json['currency'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['order_id'] = orderId;
    json['name'] = name;
    json['status'] = status;
    json['date_added'] = dateAdded;
    json['product_total'] = productTotal;
    json['products'] = products?.map((e) => e.toJson()).toList();
    json['total'] = total;
    json['currency_code'] = currencyCode;
    json['currency_value'] = currencyValue;
    json['total_raw'] = totalRaw;
    json['timestamp'] = timestamp;
    json['currency'] = currency?.toJson();
    return json;
  }
}

class Products {
  String? productId;
  String? orderProductId;
  String? name;
  String? model;
  List<dynamic>? option;
  String? quantity;
  String? price;
  String? total;
  double? priceRaw;
  double? totalRaw;
  String? returnn;
  String? image;
  List<String>? images;
  String? originalImage;
  List<String>? originalImages;

  Products({
  this.productId,
  this.orderProductId,
  this.name,
  this.model,
  this.option,
  this.quantity,
  this.price,
  this.total,
  this.priceRaw,
  this.totalRaw,
  this.returnn,
  this.image,
  this.images,
  this.originalImage,
  this.originalImages,
  });

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'] as String?;
    orderProductId = json['order_product_id'] as String?;
    name = json['name'] as String?;
    model = json['model'] as String?;
    option = json['option'] as List?;
    quantity = json['quantity'] as String?;
    price = json['price'] as String?;
    total = json['total'] as String?;
    priceRaw = json['price_raw'] as double?;
    totalRaw = json['total_raw'] as double?;
    returnn = json['return'] as String?;
    image = json['image'] as String?;
    images = (json['images'] as List?)?.map((dynamic e) => e as String).toList();
    originalImage = json['original_image'] as String?;
    originalImages = (json['original_images'] as List?)?.map((dynamic e) => e as String).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['0'] = 0;
    json['product_id'] = productId;
    json['order_product_id'] = orderProductId;
    json['name'] = name;
    json['model'] = model;
    json['option'] = option;
    json['quantity'] = quantity;
    json['price'] = price;
    json['total'] = total;
    json['price_raw'] = priceRaw;
    json['total_raw'] = totalRaw;
    json['return'] = returnn;
    json['image'] = image;
    json['images'] = images;
    json['original_image'] = originalImage;
    json['original_images'] = originalImages;
    return json;
  }
}

class Currency {
  String? currencyId;
  String? symbolLeft;
  String? symbolRight;
  String? decimalPlace;
  String? value;

  Currency({
    this.currencyId,
    this.symbolLeft,
    this.symbolRight,
    this.decimalPlace,
    this.value,
  });

  Currency.fromJson(Map<String, dynamic> json) {
    currencyId = json['currency_id'] as String?;
    symbolLeft = json['symbol_left'] as String?;
    symbolRight = json['symbol_right'] as String?;
    decimalPlace = json['decimal_place'] as String?;
    value = json['value'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['currency_id'] = currencyId;
    json['symbol_left'] = symbolLeft;
    json['symbol_right'] = symbolRight;
    json['decimal_place'] = decimalPlace;
    json['value'] = value;
    return json;
  }
}