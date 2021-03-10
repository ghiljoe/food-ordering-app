// To parse this JSON data, do
//
//     final menuCategory = menuCategoryFromJson(jsonString);

import 'dart:convert';

List<MenuCategory> menuCategoryFromJson(String str) => List<MenuCategory>.from(
    json.decode(str).map((x) => MenuCategory.fromJson(x)));

String menuCategoryToJson(List<MenuCategory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MenuCategory {
  MenuCategory({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  String image;

  factory MenuCategory.fromJson(Map<String, dynamic> json) => MenuCategory(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "image": image,
      };
}
