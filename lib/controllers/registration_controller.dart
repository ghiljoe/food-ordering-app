import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ordering_menu_app/controllers/login_controller.dart';
import 'package:ordering_menu_app/models/user.dart';
import 'package:ordering_menu_app/services/authentication_services.dart';
import 'package:ordering_menu_app/views/menu_category_list_page.dart';
import 'package:ordering_menu_app/views/widgets/Toaster.dart';

class RegistrationController extends GetxController {
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  var isLoading = false.obs;
  final LoginController loginController = Get.put(LoginController());

  void createAccount() async {
    if (firstName.text.isEmpty ||
        lastName.text.isEmpty ||
        email.text.isEmpty ||
        password.text.isEmpty) {
      Toaster.normal('All fields are required!');
      return;
    }

    Map userDetails = {
      "email": email.text,
      "password": password.text,
      "first_name": firstName.text,
      "last_name": lastName.text,
    };
    try {
      isLoading(true);
      var user = await AuthenticationServices.createUser(userDetails);
      if (user is User) {
        loginController.localStorage.write('user', user);
        loginController.localStorage.write('userId', user.id);
        loginController.isAuthenticated(true);
        firstName.text = '';
        lastName.text = '';
        email.text = '';
        password.text = '';
        loginController.fullName('${user.firstName} ${user.lastName}');
        loginController.initials('${user.firstName[0]}${user.lastName[0]}');
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
}
