class ProductsModel {
  int? success;
  List<dynamic>? error;
  List<Products>? data;

  ProductsModel({this.success, this.error, this.data});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    error = json["error"] ?? [];
    print('hbhjbhj ${json}');
    data = json["data"]==null ? null : (json["data"] as List).map((e)=>Products.fromJson(e)).toList();
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

class Products {
  dynamic id;
  dynamic productId;
  String? name;
  String? url;
  String? manufacturer;
  String? sku;
  dynamic totalRaw;
  bool? fav;
  String? model;
  String? image;
  List<String>? images;
  String? originalImage;
  List<String>? originalImages;
  dynamic priceExcludingTax;
  String? priceExcludingTaxFormated;
  dynamic price;
  dynamic originPrice;
  String? priceFormated;
  int? rating;
  String? description;
  List<dynamic>? attributeGroups;
  dynamic special;
  dynamic specialExcludingTax;
  String? specialExcludingTaxFormated;
  String? specialFormated;
  String? specialStartDate;
  String? specialEndDate;
  List<dynamic>? discounts;
  List<dynamic>? options;
  String? minimum;
  String? metaTitle;
  String? metaDescription;
  String? metaKeyword;
  String? seoUrl;
  String? tag;
  String? upc;
  String? ean;
  String? jan;
  String? isbn;
  String? mpn;
  String? location;
  String? stockStatus;
  dynamic? stockStatusId;
  int? manufacturerId;
  int? taxClassId;
  String? dateAvailable;
  dynamic weight;
  int? weightClassId;
  String? length;
  String? width;
  String? height;
  int? lengthClassId;
  String? subtract;
  String? sortOrder;
  String? status;
  String? dateAdded;
  String? dateModified;
  String? viewed;
  String? weightClass;
  String? lengthClass;
  String? shipping;
  dynamic reward;
  dynamic points;
  List<Category>? category;
  dynamic quantity;
  dynamic qty;
  Reviews? reviews;
  Customtabs? customTabs;
  List<dynamic>? recurrings;

  Products({this.id, this.productId, this.name,this.customTabs, this.url, this.manufacturer,this.originPrice, this.qty,this.fav, this.sku, this.totalRaw, this.model, this.image, this.images, this.originalImage, this.originalImages, this.priceExcludingTax, this.priceExcludingTaxFormated, this.price, this.priceFormated, this.rating, this.description, this.attributeGroups, this.special, this.specialExcludingTax, this.specialExcludingTaxFormated, this.specialFormated, this.specialStartDate, this.specialEndDate, this.discounts, this.options, this.minimum, this.metaTitle, this.metaDescription, this.metaKeyword, this.seoUrl, this.tag, this.upc, this.ean, this.jan, this.isbn, this.mpn, this.location, this.stockStatus, this.stockStatusId, this.manufacturerId, this.taxClassId, this.dateAvailable, this.weight, this.weightClassId, this.length, this.width, this.height, this.lengthClassId, this.subtract, this.sortOrder, this.status, this.dateAdded, this.dateModified, this.viewed, this.weightClass, this.lengthClass, this.shipping, this.reward, this.points, this.category, this.quantity, this.reviews, this.recurrings});

  Products.fromJson(Map<String, dynamic> json) {
    id = json["id"]??json['key']??json['product_id'];
    productId = json["product_id"];
    name = json["name"];
    fav = false;
    manufacturer = json["manufacturer"];
    sku = json["sku"];
    model = json["model"];
    url = json["url"];
    image = json["image"];
    images = json["images"]==null ? null : List<String>.from(json["images"]);
    originalImage = json["original_image"];
    originalImages = json["original_images"]==null ? null : List<String>.from(json["original_images"]);
    priceExcludingTax = json["price_excluding_tax"];
    priceExcludingTaxFormated = json["price_excluding_tax_formated"];
    price = json["price"];
    originPrice = json["origin_price"];
    totalRaw = json["total_raw"];
    priceFormated = json["price_formated"];
    rating = json["rating"];
    description = json["description"];
    attributeGroups = json["attribute_groups"] ?? [];
    special = json["special"];
    specialExcludingTax = json["special_excluding_tax"];
    specialExcludingTaxFormated = json["special_excluding_tax_formated"];
    specialFormated = json["special_formated"];
    specialStartDate = json["special_start_date"];
    specialEndDate = json["special_end_date"];
    discounts = json["discounts"] ?? [];
    options = json["options"] ?? [];
    minimum = json["minimum"];
    metaTitle = json["meta_title"];
    metaDescription = json["meta_description"];
    metaKeyword = json["meta_keyword"];
    seoUrl = json["seo_url"];
    tag = json["tag"];
    upc = json["upc"];
    ean = json["ean"];
    jan = json["jan"];
    isbn = json["isbn"];
    mpn = json["mpn"];
    location = json["location"];
    stockStatus = json["stock_status"];
    stockStatusId = json["stock_status_id"];
    manufacturerId = json["manufacturer_id"];
    taxClassId = json["tax_class_id"];
    dateAvailable = json["date_available"];
    weight = json["weight"];
    weightClassId = json["weight_class_id"];
    length = json["length"];
    width = json["width"];
    height = json["height"];
    lengthClassId = json["length_class_id"];
    subtract = json["subtract"];
    sortOrder = json["sort_order"];
    status = json["status"];
    dateAdded = json["date_added"];
    dateModified = json["date_modified"];
    viewed = json["viewed"];
    weightClass = json["weight_class"];
    lengthClass = json["length_class"];
    shipping = json["shipping"];
    reward = json["reward"];
    points = json["points"];
    category = json["category"]==null ? null : (json["category"] as List).map((e)=>Category.fromJson(e)).toList();
    quantity = json["quantity"];
    qty = json["qty"];
    reviews = json["reviews"] == null ? null : Reviews.fromJson(json["reviews"]);
    customTabs = (json['customtabs'] as Map<String,dynamic>?) != null ? Customtabs.fromJson(json['customtabs'] as Map<String,dynamic>) : null;
    recurrings = json["recurrings"] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["product_id"] = productId;
    data["name"] = name;
    data["manufacturer"] = manufacturer;
    data["sku"] = sku;
    data["model"] = model;
    data["url"] = url;
    data["image"] = image;
    if(images != null) {
      data["images"] = images;
    }
    data["original_image"] = originalImage;
    if(originalImages != null) {
      data["original_images"] = originalImages;
    }
    data["price_excluding_tax"] = priceExcludingTax;
    data["price_excluding_tax_formated"] = priceExcludingTaxFormated;
    data["price"] = price;
    data["origin_price"] = originPrice;
    data["price_formated"] = priceFormated;
    data["rating"] = rating;
    data["description"] = description;
    if(attributeGroups != null) {
      data["attribute_groups"] = attributeGroups;
    }
    data["special"] = special;
    data["special_excluding_tax"] = specialExcludingTax;
    data["special_excluding_tax_formated"] = specialExcludingTaxFormated;
    data["special_formated"] = specialFormated;
    data["special_start_date"] = specialStartDate;
    data["special_end_date"] = specialEndDate;
    if(discounts != null) {
      data["discounts"] = discounts;
    }
    if(options != null) {
      data["options"] = options;
    }
    data["minimum"] = minimum;
    data["meta_title"] = metaTitle;
    data["meta_description"] = metaDescription;
    data["meta_keyword"] = metaKeyword;
    data["seo_url"] = seoUrl;
    data["tag"] = tag;
    data["upc"] = upc;
    data["ean"] = ean;
    data["jan"] = jan;
    data["isbn"] = isbn;
    data["mpn"] = mpn;
    data["location"] = location;
    data["stock_status"] = stockStatus;
    data["stock_status_id"] = stockStatusId;
    data["manufacturer_id"] = manufacturerId;
    data["tax_class_id"] = taxClassId;
    data["date_available"] = dateAvailable;
    data["weight"] = weight;
    data["weight_class_id"] = weightClassId;
    data["length"] = length;
    data["width"] = width;
    data["height"] = height;
    data["length_class_id"] = lengthClassId;
    data["subtract"] = subtract;
    data["sort_order"] = sortOrder;
    data["status"] = status;
    data["date_added"] = dateAdded;
    data["date_modified"] = dateModified;
    data["viewed"] = viewed;
    data["weight_class"] = weightClass;
    data["length_class"] = lengthClass;
    data["shipping"] = shipping;
    data["reward"] = reward;
    data["points"] = points;
    if(category != null) {
      data["category"] = category?.map((e)=>e.toJson()).toList();
    }
    data["quantity"] = quantity;
    data["qty"] = qty;
    if(reviews != null) {
      data["reviews"] = reviews?.toJson();
    }
    if(customTabs != null) {
      data["customtabs"] = customTabs?.toJson();
    }

    if(recurrings != null) {
      data["recurrings"] = recurrings;
    }
    return data;
  }
}

class Customtabs {
  List<CustomtabsData>? customtabs;

  Customtabs({
    this.customtabs,
  });

  Customtabs.fromJson(Map<String, dynamic> json) {
    customtabs = (json['customtabs'] as List?)?.map((dynamic e) => CustomtabsData.fromJson(e as Map<String,dynamic>)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['customtabs'] = customtabs?.map((e) => e.toJson()).toList();
    return json;
  }
}

class CustomtabsData {
  String? title;
  String? description;

  CustomtabsData({
    this.title,
    this.description,
  });

  CustomtabsData.fromJson(Map<String, dynamic> json) {
    title = json['title'] as String?;
    description = json['description'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['title'] = title;
    json['description'] = description;
    return json;
  }
}


class Reviews {
  String? reviewTotal;
  List<Reviews1>? reviews;

  Reviews({this.reviewTotal, this.reviews});

  Reviews.fromJson(Map<String, dynamic> json) {
    reviewTotal = json["review_total"];
    reviews = json["reviews"]==null ? null : (json["reviews"] as List).map((e)=>Reviews1.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["review_total"] = reviewTotal;
    if(reviews != null) {
      data["reviews"] = reviews?.map((e)=>e.toJson()).toList();
    }
    return data;
  }
}

class Reviews1 {
  String? author;
  String? text;
  dynamic rating;
  String? dateAdded;

  Reviews1({this.author, this.text, this.rating, this.dateAdded});

  Reviews1.fromJson(Map<String, dynamic> json) {
    author = json["author"];
    text = json["text"];
    rating = json["rating"];
    dateAdded = json["date_added"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["author"] = author;
    data["text"] = text;
    data["rating"] = rating;
    data["date_added"] = dateAdded;
    return data;
  }
}

class Category {
  String? name;
  int? id;

  Category({this.name, this.id});

  Category.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["id"] = id;
    return data;
  }
}