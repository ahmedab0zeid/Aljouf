class AllStaticPagesModel {
  int? success;
  List<dynamic>? error;
  List<Data>? data;

  AllStaticPagesModel({
    this.success,
    this.error,
    this.data,
  });

  AllStaticPagesModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? title;

  Data({
    this.id,
    this.title,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    title = json['title'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['title'] = title;
    return json;
  }
}