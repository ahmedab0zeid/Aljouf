class SubCategoriesModel {
  int? success;
  List<dynamic>? error;
  Data? data;

  SubCategoriesModel({this.success, this.error, this.data});

  SubCategoriesModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    error = json["error"] ?? [];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
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

class Data {
  int? id;
  String? name;
  String? description;
  String? image;
  String? originalImage;
  Filters? filters;
  String? seoUrl;
  List<SubCategories>? subCategories;

  Data({this.id, this.name, this.description, this.image, this.originalImage, this.filters, this.seoUrl, this.subCategories});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    image = json["image"];
    originalImage = json["original_image"];
    filters = json["filters"] == null ? null : Filters.fromJson(json["filters"]);
    seoUrl = json["seo_url"];
    subCategories = json["sub_categories"]==null ? null : (json["sub_categories"] as List).map((e)=>SubCategories.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["description"] = description;
    data["image"] = image;
    data["original_image"] = originalImage;
    if(filters != null) {
      data["filters"] = filters?.toJson();
    }
    data["seo_url"] = seoUrl;
    if(subCategories != null) {
      data["sub_categories"] = subCategories?.map((e)=>e.toJson()).toList();
    }
    return data;
  }
}

class SubCategories {
  int? categoryId;
  int? parentId;
  String? name;
  String? seoUrl;
  String? image;
  String? mobileImage;
  String? originalImage;
  Filters1? filters;
  List<dynamic>? categories;

  SubCategories({this.categoryId, this.parentId, this.name, this.mobileImage, this.seoUrl, this.image, this.originalImage, this.filters, this.categories});

  SubCategories.fromJson(Map<String, dynamic> json) {
    categoryId = json["category_id"];
    parentId = json["parent_id"];
    name = json["name"];
    seoUrl = json["seo_url"];
    image = json["image"];
    mobileImage = json["mobile_image"];
    originalImage = json["original_image"];
    filters = json["filters"] == null ? null : Filters1.fromJson(json["filters"]);
    categories = json["categories"] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["category_id"] = categoryId;
    data["parent_id"] = parentId;
    data["name"] = name;
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

class Filters1 {
  List<dynamic>? filterGroups;

  Filters1({this.filterGroups});

  Filters1.fromJson(Map<String, dynamic> json) {
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