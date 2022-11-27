class StatesModel {
  int? success;
  List<dynamic>? error;
  Data? data;

  StatesModel({
    this.success,
    this.error,
    this.data,
  });

  StatesModel.fromJson(Map<String, dynamic> json) {
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
  int? countryId;
  String? name;
  String? isoCode2;
  String? isoCode3;
  String? addressFormat;
  String? postcodeRequired;
  dynamic status;
  List<Zone>? zone;

  Data({
    this.countryId,
    this.name,
    this.isoCode2,
    this.isoCode3,
    this.addressFormat,
    this.postcodeRequired,
    this.status,
    this.zone,
  });

  Data.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'] as int?;
    name = json['name'] as String?;
    isoCode2 = json['iso_code_2'] as String?;
    isoCode3 = json['iso_code_3'] as String?;
    addressFormat = json['address_format'] as String?;
    postcodeRequired = json['postcode_required'] as String?;
    status = json['status'];
    zone = (json['zone'] as List?)?.map((dynamic e) => Zone.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['country_id'] = countryId;
    json['name'] = name;
    json['iso_code_2'] = isoCode2;
    json['iso_code_3'] = isoCode3;
    json['address_format'] = addressFormat;
    json['postcode_required'] = postcodeRequired;
    json['status'] = status?.toJson();
    json['zone'] = zone?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Zone {
  dynamic zoneId;
  dynamic countryId;
  String? name;
  String? nameAr;
  String? code;
  dynamic status;

  Zone({
    this.zoneId,
    this.countryId,
    this.name,
    this.nameAr,
    this.code,
    this.status,
  });

  Zone.fromJson(Map<String, dynamic> json) {
    zoneId = json['zone_id'];
    countryId = json['country_id'];
    name = json['name'] as String?;
    nameAr = json['name_ar'] as String?;
    code = json['code'] as String?;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['zone_id'] = zoneId?.toJson();
    json['country_id'] = countryId?.toJson();
    json['name'] = name;
    json['name_ar'] = nameAr;
    json['code'] = code;
    json['status'] = status?.toJson();
    return json;
  }
}

