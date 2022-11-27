class StaticPageModel {
  int? success;
  List<dynamic>? error;
  List<Data>? data;

  StaticPageModel({
    this.success,
    this.error,
    this.data,
  });

  StaticPageModel.fromJson(Map<String, dynamic> json) {
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
  String? informationId;
  String? bottom;
  String? sortOrder;
  String? status;
  String? languageId;
  String? title;
  String? description;
  String? metaTitle;
  String? metaDescription;
  String? metaKeyword;
  String? storeId;

  Data({
    this.informationId,
    this.bottom,
    this.sortOrder,
    this.status,
    this.languageId,
    this.title,
    this.description,
    this.metaTitle,
    this.metaDescription,
    this.metaKeyword,
    this.storeId,
  });

  Data.fromJson(Map<String, dynamic> json) {
    informationId = json['information_id'] as String?;
    bottom = json['bottom'] as String?;
    sortOrder = json['sort_order'] as String?;
    status = json['status'] as String?;
    languageId = json['language_id'] as String?;
    title = json['title'] as String?;
    description = json['description'] as String?;
    metaTitle = json['meta_title'] as String?;
    metaDescription = json['meta_description'] as String?;
    metaKeyword = json['meta_keyword'] as String?;
    storeId = json['store_id'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['information_id'] = informationId;
    json['bottom'] = bottom;
    json['sort_order'] = sortOrder;
    json['status'] = status;
    json['language_id'] = languageId;
    json['title'] = title;
    json['description'] = description;
    json['meta_title'] = metaTitle;
    json['meta_description'] = metaDescription;
    json['meta_keyword'] = metaKeyword;
    json['store_id'] = storeId;
    return json;
  }
}