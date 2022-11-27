class BannerModel {
  int? success;
  List<dynamic>? error;
  List<Data>? data;

  BannerModel({
    this.success,
    this.error,
    this.data,
  });

  BannerModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? link;
  String? image;

  Data({
    this.title,
    this.link,
    this.image,
  });

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'] as String?;
    link = json['link'] as String?;
    image = json['image'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['title'] = title;
    json['link'] = link;
    json['image'] = image;
    return json;
  }
}