class TableModel {
  late final int id;
  late final String name;
  late final String placement;
  late final String status;
  late final String createdAt;
  late final String updatedAt;

  TableModel(
      {required this.id,
      required this.name,
      required this.placement,
      required this.status,
      required this.createdAt,
      required this.updatedAt});

  TableModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["name"] is String) this.name = json["name"];
    if (json["placement"] is String) this.placement = json["placement"];
    if (json["status"] is String) this.status = json["status"];
    if (json["created_at"] is String) this.createdAt = json["created_at"];
    if (json["updated_at"] is String) this.updatedAt = json["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["placement"] = this.placement;
    data["status"] = this.status;
    data["created_at"] = this.createdAt;
    data["updated_at"] = this.updatedAt;
    return data;
  }
}
