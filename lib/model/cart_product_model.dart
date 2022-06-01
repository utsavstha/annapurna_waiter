class CartProductModel {
  late final int id;
  late final String name;
  late num quantity = 0;
  late final num price;
  CartProductModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.quantity});

  CartProductModel.fromJson(Map<String, dynamic> json) {
    if (json["food_item_id"] is int) id = json["food_item_id"];
    if (json["name"] is String) name = json["name"];
    if (json["quantity"] is num) quantity = json["quantity"];
    if (json["price"] is num) price = json["price"];
  }
}
