class Notifications {
  late int id;
  late String tableName;
  late String productName;
  late int quantity;

  Notifications(
      {required this.id,
      required this.tableName,
      required this.productName,
      required this.quantity});

  Notifications.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["table_name"] is String) this.tableName = json["table_name"];
    if (json["product_name"] is String) this.productName = json["product_name"];
    if (json["quantity"] is int) this.quantity = json["quantity"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["table_name"] = this.tableName;
    data["product_name"] = this.productName;
    data["quantity"] = this.quantity;

    return data;
  }
}
