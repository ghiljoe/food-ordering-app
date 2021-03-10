import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ordering_menu_app/controllers/menu_controller.dart';
import 'package:ordering_menu_app/models/user.dart';
import 'package:ordering_menu_app/services/authentication_services.dart';
import 'package:ordering_menu_app/views/login_page.dart';
import 'package:ordering_menu_app/views/menu_category_list_page.dart';
import 'package:ordering_menu_app/views/widgets/Toaster.dart';

class LoginController extends GetxController {
  final MenuController menuController = Get.put(MenuController());

  final username = TextEditingController();
  final password = TextEditingController();
  var isLoading = false.obs;
  final localStorage = GetStorage();
  var isAuthenticated = false.obs;
  var fullName = ''.obs;
  var initials = ''.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (localStorage.read('user') != null) {
      var user = localStorage.read('user');
      fullName('${user['first_name']} ${user['last_name']}');
      initials('${user['first_name'][0]}${user['last_name'][0]}');
      isAuthenticated(true);
    } else {
      isAuthenticated(false);
    }
  }

  void login() async {
    Map credentials = {"email": username.text, "password": password.text};
    try {
      isLoading(true);
      var user = await AuthenticationServices.authenticate(credentials);
      if (user is User) {
        localStorage.write('user', user);
        localStorage.write('userId', user.id);
        isAuthenticated(true);
        username.text = '';
        password.text = '';
        fullName('${user.firstName} ${user.lastName}');
        initials('${user.firstName[0]}${user.lastName[0]}');
        Get.offAll(() => MenuCategoryListPage());
      } else {
        Toaster.normal(user['message']);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  void logout() {
    localStorage.remove('user');
    localStorage.remove('userId');
    isAuthenticated(false);
    menuController.cart.clear();
    menuController.isValidVoucher(false);
    Get.offAll(() => LoginPage());
  }
}
