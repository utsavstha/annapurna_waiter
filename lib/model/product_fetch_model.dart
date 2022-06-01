class ProductFetchModel {
  late String categoryName;
  late int categoryId;
  late List<Items> items;

  ProductFetchModel(
      {required this.categoryName,
      required this.categoryId,
      required this.items});

  ProductFetchModel.fromJson(Map<String, dynamic> json) {
    if (json["category_name"] is String) {
      categoryName = json["category_name"];
    }
    if (json["category_id"] is int) {
      categoryId = json["category_id"];
    }
    if (json["items"] is List) {
      items = (json["items"] == null
          ? null
          : (json["items"] as List).map((e) => Items.fromJson(e)).toList())!;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["category_name"] = categoryName;
    data["category_id"] = categoryId;
    data["items"] = items.map((e) => e.toJson()).toList();
    return data;
  }
}

class Items {
  late int id;
  late String name;
  late num price;
  late String description;
  late int categoryId;
  late String createdAt;
  late String updatedAt;

  Items(
      {required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.categoryId,
      required this.createdAt,
      required this.updatedAt});

  Items.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["price"] is num) {
      price = json["price"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["category_id"] is int) {
      categoryId = json["category_id"];
    }
    if (json["created_at"] is String) {
      createdAt = json["created_at"];
    }
    if (json["updated_at"] is String) {
      updatedAt = json["updated_at"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["price"] = price;
    data["description"] = description;
    data["category_id"] = categoryId;
    data["created_at"] = createdAt;
    data["updated_at"] = updatedAt;
    return data;
  }
}
