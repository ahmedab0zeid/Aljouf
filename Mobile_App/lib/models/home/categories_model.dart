class CategoriesModel {
  int? success;
  List<dynamic>? error;
  List<Data>? data;

  CategoriesModel({this.success, this.error, this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    error = json["error"] ?? [];
    data = json["data"]==null ? null : (json["data"] as List).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["success"] = success;
    if(error != null) {
      data["error"] = error;
    }
    if(this.data != null) {
      data["data"] = this.data?.map((e)=>e.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? categoryId;
  int? parentId;
  String? name;
  String? status;
  String? seoUrl;
  String? image;
  String? mobileImage;
  String? originalImage;
  Filters? filters;
  List<dynamic>? categories;

  Data({this.categoryId, this.parentId, this.name,this.mobileImage, this.seoUrl, this.image, this.originalImage, this.filters, this.categories});

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json["category_id"];
    parentId = json["parent_id"];
    name = json["name"];
    status = json["status"];
    seoUrl = json["seo_url"];
    image = json["image"];
    mobileImage = json["mobile_image"];
    originalImage = json["original_image"];
    filters = json["filters"] == null ? null : Filters.fromJson(json["filters"]);
    categories = json["categories"] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["category_id"] = categoryId;
    data["parent_id"] = parentId;
    data["name"] = name;
    data["status"] = status;
    data["seo_url"] = seoUrl;
    data["image"] = image;
    data["mobile_image"] = mobileImage;
    data["original_image"] = originalImage;
    if(filters != null) {
      data["filters"] = filters?.toJson();
    }
    if(categories != null) {
      data["categories"] = categories;
    }
    return data;
  }
}

class Filters {
  List<dynamic>? filterGroups;

  Filters({this.filterGroups});

  Filters.fromJson(Map<String, dynamic> json) {
    filterGroups = json["filter_groups"] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(filterGroups != null) {
      data["filter_groups"] = filterGroups;
    }
    return data;
  }
}