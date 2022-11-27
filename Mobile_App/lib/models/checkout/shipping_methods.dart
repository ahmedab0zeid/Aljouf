class ShippingMethodesModel {
  int? success;
  List<dynamic>? error;
  Data? data;

  ShippingMethodesModel({
    this.success,
    this.error,
    this.data,
  });

  ShippingMethodesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] as int?;
    error = json['error'] as List?;
    data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['success'] = success;
    json['error'] = error;
    json['data'] = data?.toJson();
    return json;
  }
}

class Data {
  List<ShippingMethods>? shippingMethods;
  String? code;
  String? comment;

  Data({
    this.shippingMethods,
    this.code,
    this.comment,
  });

  Data.fromJson(Map<String, dynamic> json) {
    shippingMethods = (json['shipping_methods'] as List?)?.map((dynamic e) => ShippingMethods.fromJson(e as Map<String,dynamic>)).toList();
    code = json['code'] as String?;
    comment = json['comment'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['shipping_methods'] = shippingMethods?.map((e) => e.toJson()).toList();
    json['code'] = code;
    json['comment'] = comment;
    return json;
  }
}

class ShippingMethods {
  String? title;
  List<Quote>? quote;
  dynamic sortOrder;
  String? error;

  ShippingMethods({
    this.title,
    this.quote,
    this.sortOrder,
    this.error,
  });

  ShippingMethods.fromJson(Map<String, dynamic> json) {
    title = json['title'] as String?;
    quote = (json['quote'] as List?)?.map((dynamic e) => Quote.fromJson(e as Map<String,dynamic>)).toList();
    sortOrder = json['sort_order'];
    error = json['error'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['title'] = title;
    json['quote'] = quote?.map((e) => e.toJson()).toList();
    json['sort_order'] = sortOrder;
    json['error'] = error;
    return json;
  }
}

class Quote {
  String? code;
  String? title;
  int? cost;
  String? taxClassId;
  String? text;

  Quote({
    this.code,
    this.title,
    this.cost,
    this.taxClassId,
    this.text,
  });

  Quote.fromJson(Map<String, dynamic> json) {
    code = json['code'] as String?;
    title = json['title'] as String?;
    cost = json['cost'] as int?;
    taxClassId = json['tax_class_id'] as String?;
    text = json['text'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['code'] = code;
    json['title'] = title;
    json['cost'] = cost;
    json['tax_class_id'] = taxClassId;
    json['text'] = text;
    return json;
  }
}