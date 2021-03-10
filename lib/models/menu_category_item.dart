// To parse this JSON data, do
//
//     final menuCategoryItem = menuCategoryItemFromJson(jsonString);

import 'dart:convert';

List<MenuCategoryItem> menuCategoryItemFromJson(String str) =>
    List<MenuCategoryItem>.from(
        json.decode(str).map((x) => MenuCategoryItem.fromJson(x)));

String menuCategoryItemToJson(List<MenuCategoryItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MenuCategoryItem {
  MenuCategoryItem({
    this.id,
    this.menuCategoryId,
    this.name,
    this.price,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.itemCount,
    this.tax,
  });

  int id;
  int menuCategoryId;
  String name;
  String price;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  int itemCount;
  double tax;

  factory MenuCategoryItem.fromJson(Map<String, dynamic> json) =>
      MenuCategoryItem(
        id: json["id"],
        menuCategoryId: json["menu_category_id"],
        name: json["name"],
        price: json["price"],
        image: json["image"],
        itemCount: json["item_count"],
        tax: json["tax"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "menu_category_id": menuCategoryId,
        "name": name,
        "price": price,
        "image": image,
        "item_count": itemCount,
        "tax": tax,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
