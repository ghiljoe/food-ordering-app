import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ordering_menu_app/config/config.dart';
import 'package:ordering_menu_app/models/menu_category.dart';
import 'package:ordering_menu_app/models/menu_category_item.dart';
import 'package:ordering_menu_app/models/order.dart';
import 'package:ordering_menu_app/models/order_item.dart';

class MenuServices {
  static Future getMenuCategories() async {
    var response = await http.get(Config.API_URL + '/get-menu-categories');
    if (response.statusCode == 200) {
      return menuCategoryFromJson(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static Future saveOrder(Map order) async {
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(Config.API_URL + '/save-order',
        headers: headers, body: jsonEncode(order));
    if (response.statusCode == 200) {
      return orderFromJson(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static Future getMenuCategoryItems(int menuCategoryId) async {
    var response = await http
        .get(Config.API_URL + '/get-menu-category-items/$menuCategoryId');
    if (response.statusCode == 200) {
      return menuCategoryItemFromJson(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }

  static Future getOrderItems(int orderId) async {
    var response = await http.get(Config.API_URL + '/get-order-items/$orderId');
    if (response.statusCode == 200) {
      return orderItemFromJson(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }
}
