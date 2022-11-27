class CitiesModel {
  int? success;
  List<dynamic>? error;
  Data? data;

  CitiesModel({
    this.success,
    this.error,
    this.data,
  });

  CitiesModel.fromJson(Map<String, dynamic> json) {
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
  int? zoneId;
  String? name;
  String? nameAr;
  String? code;
  List<Cities>? cities;

  Data({
    this.zoneId,
    this.name,
    this.nameAr,
    this.code,
    this.cities,
  });

  Data.fromJson(Map<String, dynamic> json) {
    zoneId = json['zone_id'] as int?;
    name = json['name'] as String?;
    nameAr = json['name_ar'] as String?;
    code = json['code'] as String?;
    cities = (json['cities'] as List?)?.map((dynamic e) => Cities.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['zone_id'] = zoneId;
    json['name'] = name;
    json['name_ar'] = nameAr;
    json['code'] = code;
    json['cities'] = cities?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Cities {
  String? nameAr;
  String? name;
  String? code;

  Cities({
    this.nameAr,
    this.name,
    this.code,
  });

  Cities.fromJson(Map<String, dynamic> json) {
    nameAr = json['name_ar'] as String?;
    name = json['name'] as String?;
    code = json['code'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name_ar'] = nameAr;
    json['name'] = name;
    json['code'] = code;
    return json;
  }
}
