class CountriesModel {
  int? success;
  List<dynamic>? error;
  List<Country>? data;

  CountriesModel({
    this.success,
    this.error,
    this.data,
  });

  CountriesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'] as int?;
    error = json['error'] as List?;
    data = (json['data'] as List?)?.map((dynamic e) => Country.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['success'] = success;
    json['error'] = error;
    json['data'] = data?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Country {
  int? countryId;
  String? name;
  String? nameAr;
  String? isoCode2;
  String? isoCode3;
  String? addressFormat;
  String? postcodeRequired;
  dynamic status;

  Country({
    this.countryId,
    this.name,
    this.nameAr,
    this.isoCode2,
    this.isoCode3,
    this.addressFormat,
    this.postcodeRequired,
    this.status,
  });

  Country.fromJson(Map<String, dynamic> json) {
    countryId = json['country_id'] as int?;
    name = json['name'] as String?;
    nameAr = json['name_ar'] as String?;
    isoCode2 = json['iso_code_2'] as String?;
    isoCode3 = json['iso_code_3'] as String?;
    addressFormat = json['address_format'] as String?;
    postcodeRequired = json['postcode_required'] as String?;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['country_id'] = countryId;
    json['name'] = name;
    json['name_ar'] = nameAr;
    json['iso_code_2'] = isoCode2;
    json['iso_code_3'] = isoCode3;
    json['address_format'] = addressFormat;
    json['postcode_required'] = postcodeRequired;
    json['status'] = status?.toJson();
    return json;
  }
}
