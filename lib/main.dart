import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ordering_menu_app/controllers/login_controller.dart';
import 'package:ordering_menu_app/views/login_page.dart';
import 'package:ordering_menu_app/views/menu_category_list_page.dart';

void main() async {
  await GetStorage.init();
  runApp(Main());
}

class Main extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Food Ordering App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: Obx(() => loginController.isAuthenticated.isTrue
          ? MenuCategoryListPage()
          : LoginPage()),
    );
  }
}
