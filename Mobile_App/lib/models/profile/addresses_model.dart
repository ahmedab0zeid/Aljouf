class AddressesModel {
  int? success;
  List<dynamic>? error;
  Data? data;

  AddressesModel({
    this.success,
    this.error,
    this.data,
  });

  AddressesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] as int?;
    error = json['error'] as List?;
    if(json['data'] is List) {
      data = (json['data'] as List?) != null ? Data.fromJson(
          json['data'] as List?) : null;
    }else{
      data = (json['data'] as Map<String, dynamic>?) != null ? Data.fromJson(
          json['data'] as Map<String, dynamic>) : null;
    }
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
  List<Addresses>? addresses;
  List<CustomFields>? customFields;

  Data({
    this.addresses,
    this.customFields,
  });

  Data.fromJson(json) {
    if(json is !List) {
      addresses = (json['addresses'] as List?)?.map((dynamic e) =>
          Addresses.fromJson(e as Map<String, dynamic>)).toList();
      customFields = (json['custom_fields'] as List?)?.map((dynamic e) => CustomFields.fromJson(e as Map<String,dynamic>)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['addresses'] = addresses?.map((e) => e.toJson()).toList();
    json['custom_fields'] = customFields?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Addresses {
  String? addressId;
  String? firstname;
  String? lastname;
  String? email;
  String? company;
  String? address1;
  String? address2;
  String? postcode;
  String? city;
  String? zoneId;
  String? zone;
  String? zoneCode;
  String? countryId;
  String? country;
  String? isoCode2;
  String? isoCode3;
  String? addressFormat;
  dynamic customField;
  bool? defaultt;

  Addresses({
  this.addressId,
  this.firstname,
  this.lastname,
  this.email,
  this.company,
  this.address1,
  this.address2,
  this.postcode,
  this.city,
  this.zoneId,
  this.zone,
  this.zoneCode,
  this.countryId,
  this.country,
  this.isoCode2,
  this.isoCode3,
  this.addressFormat,
  this.customField,
  this.defaultt,
});

Addresses.fromJson(Map<String, dynamic> json) {
addressId = json['address_id'] as String?;
firstname = json['firstname'] as String?;
lastname = json['lastname'] as String?;
email = json['email'] as String?;
company = json['company'] as String?;
address1 = json['address_1'] as String?;
address2 = json['address_2'] as String?;
postcode = json['postcode'] as String?;
city = json['city'] as String?;
zoneId = json['zone_id'] as String?;
zone = json['zone'] as String?;
zoneCode = json['zone_code'] as String?;
countryId = json['country_id'] as String?;
country = json['country'] as String?;
isoCode2 = json['iso_code_2'] as String?;
isoCode3 = json['iso_code_3'] as String?;
addressFormat = json['address_format'] as String?;
customField = json['custom_field'];
defaultt = json['default'] as bool?;
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> json = <String, dynamic>{};
  json['address_id'] = addressId;
  json['firstname'] = firstname;
  json['lastname'] = lastname;
  json['email'] = email;
  json['company'] = company;
  json['address_1'] = address1;
  json['address_2'] = address2;
  json['postcode'] = postcode;
  json['city'] = city;
  json['zone_id'] = zoneId;
  json['zone'] = zone;
  json['zone_code'] = zoneCode;
  json['country_id'] = countryId;
  json['country'] = country;
  json['iso_code_2'] = isoCode2;
  json['iso_code_3'] = isoCode3;
  json['address_format'] = addressFormat;
  json['custom_field'] = customField;
  json['default'] = defaultt;
  return json;
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

  CustomFields({
    this.customFieldId,
    this.customFieldValue,
    this.name,
    this.type,
    this.value,
    this.validation,
    this.location,
    this.required,
    this.sortOrder,
  });

  CustomFields.fromJson(Map<String, dynamic> json) {
    customFieldId = json['custom_field_id'] as String?;
    customFieldValue = json['custom_field_value'] as List?;
    name = json['name'] as String?;
    type = json['type'] as String?;
    value = json['value'] as String?;
    validation = json['validation'] as String?;
    location = json['location'] as String?;
    required = json['required'] as bool?;
    sortOrder = json['sort_order'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['custom_field_id'] = customFieldId;
    json['custom_field_value'] = customFieldValue;
    json['name'] = name;
    json['type'] = type;
    json['value'] = value;
    json['validation'] = validation;
    json['location'] = location;
    json['required'] = required;
    json['sort_order'] = sortOrder;
    return json;
  }
}