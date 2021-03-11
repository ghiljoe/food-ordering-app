// To parse this JSON data, do
//
//     final orderItem = orderItemFromJson(jsonString);

import 'dart:convert';

List<OrderItem> orderItemFromJson(String str) =>
    List<OrderItem>.from(json.decode(str).map((x) => OrderItem.fromJson(x)));

String orderItemToJson(List<OrderItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderItem {
  OrderItem({
    this.id,
    this.orderId,
    this.menuCategoryItemId,
    this.quantity,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.tax,
  });

  int id;
  int orderId;
  int menuCategoryItemId;
  int quantity;
  String totalPrice;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  double tax;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        orderId: json["order_id"],
        menuCategoryItemId: json["menu_category_item_id"],
        quantity: json["quantity"],
        totalPrice: json["total_price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        name: json["name"],
        tax: json["tax"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "menu_category_item_id": menuCategoryItemId,
        "quantity": quantity,
        "total_price": totalPrice,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "name": name,
        "tax": tax,
      };
}
