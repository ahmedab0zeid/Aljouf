class UserModel {
  int? success;
  List<dynamic>? error;
  User? data;

  UserModel({this.success, this.error, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    error = json["error"] ?? [];
    data = json["data"] == null || json["data"] is List<dynamic>? null : User.fromJson(json["data"]);
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

class User {
  dynamic customerId;
  String? customerGroupId;
  String? storeId;
  String? languageId;
  String? firstname;
  String? lastname;
  String? email;
  String? countryCode;
  String? telephone;
  String? fax;
  List<String>? wishlist;
  String? newsletter;
  String? addressId;
  String? ip;
  String? status;
  String? approved;
  String? safe;
  String? code;
  String? dateAdded;
  List<CustomFields>? customFields;
  String? wishlistTotal;
  int? cartCountProducts;
  String? accessToken;

  User({this.customerId, this.customerGroupId, this.storeId, this.languageId, this.firstname, this.lastname, this.email, this.countryCode, this.telephone, this.fax, this.wishlist, this.newsletter, this.addressId, this.ip, this.status, this.approved, this.safe, this.code, this.dateAdded, this.customFields, this.wishlistTotal, this.cartCountProducts, this.accessToken});

  User.fromJson(Map<String, dynamic> json) {
    customerId = json["customer_id"];
    customerGroupId = json["customer_group_id"];
    storeId = json["store_id"];
    languageId = json["language_id"];
    firstname = json["firstname"];
    lastname = json["lastname"];
    email = json["email"];
    countryCode = json["country_code"];
    telephone = json["telephone"];
    fax = json["fax"];
    wishlist = json["wishlist"]==null ? null : List<String>.from(json["wishlist"]);
    newsletter = json["newsletter"];
    addressId = json["address_id"];
    ip = json["ip"];
    status = json["status"];
    approved = json["approved"];
    safe = json["safe"];
    code = json["code"];
    dateAdded = json["date_added"];
    customFields = json["custom_fields"]==null ? null : (json["custom_fields"] as List).map((e)=>CustomFields.fromJson(e)).toList();
    wishlistTotal = json["wishlist_total"];
    cartCountProducts = json["cart_count_products"];
    accessToken = json["access_token"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["customer_id"] = customerId;
    data["customer_group_id"] = customerGroupId;
    data["store_id"] = storeId;
    data["language_id"] = languageId;
    data["firstname"] = firstname;
    data["lastname"] = lastname;
    data["email"] = email;
    data["country_code"] = countryCode;
    data["telephone"] = telephone;
    data["fax"] = fax;
    if(wishlist != null) {
      data["wishlist"] = wishlist;
    }
    data["newsletter"] = newsletter;
    data["address_id"] = addressId;
    data["ip"] = ip;
    data["status"] = status;
    data["approved"] = approved;
    data["safe"] = safe;
    data["code"] = code;
    data["date_added"] = dateAdded;
    if(customFields != null) {
      data["custom_fields"] = customFields?.map((e)=>e.toJson()).toList();
    }
    data["wishlist_total"] = wishlistTotal;
    data["cart_count_products"] = cartCountProducts;
    data["access_token"] = accessToken;
    return data;
  }
}


class CustomFields {
  String? customFieldId;
  List<dynamic>? customFieldValue;
  String? name;
  String? type;
  String? value;
  String? validation;
  String? location;
  bool? required;
  String? sortOrder;

  CustomFields({this.customFieldId, this.customFieldValue, this.name, this.type, this.value, this.validation, this.location, this.required, this.sortOrder});

  CustomFields.fromJson(Map<String, dynamic> json) {
    customFieldId = json["custom_field_id"];
    customFieldValue = json["custom_field_value"] ?? [];
    name = json["name"];
    type = json["type"];
    value = json["value"];
    validation = json["validation"];
    location = json["location"];
    required = json["required"];
    sortOrder = json["sort_order"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["custom_field_id"] = customFieldId;
    if(customFieldValue != null) {
      data["custom_field_value"] = customFieldValue;
    }
    data["name"] = name;
    data["type"] = type;
    data["value"] = value;
    data["validation"] = validation;
    data["location"] = location;
    data["required"] = required;
    data["sort_order"] = sortOrder;
    return data;
  }
}
