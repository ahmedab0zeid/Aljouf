class PaymentMethodesModel {
  int? success;
  List<dynamic>? error;
  Data? data;

  PaymentMethodesModel({
    this.success,
    this.error,
    this.data,
  });

  PaymentMethodesModel.fromJson(Map<String, dynamic> json) {
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
  List<PaymentMethods>? paymentMethods;

  Data({
    this.paymentMethods,
  });

  Data.fromJson(Map<String, dynamic> json) {
    paymentMethods = (json['payment_methods'] as List?)?.map((dynamic e) => PaymentMethods.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['payment_methods'] = paymentMethods?.map((e) => e.toJson()).toList();
    return json;
  }
}

class PaymentMethods {
  String? code;
  String? title;
  dynamic sortOrder;
  String? terms;

  PaymentMethods({
    this.code,
    this.title,
    this.sortOrder,
    this.terms,
  });

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    code = json['code'] as String?;
    title = json['title'] as String?;
    sortOrder = json['sort_order'];
    terms = json['terms'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['code'] = code;
    json['title'] = title;
    json['sort_order'] = sortOrder;
    json['terms'] = terms;
    return json;
  }
}