import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordering_menu_app/controllers/location_controller.dart';
import 'package:ordering_menu_app/controllers/login_controller.dart';
import 'package:ordering_menu_app/views/forgot_password.dart';
import 'package:ordering_menu_app/views/registration_page.dart';

class LoginPage extends StatelessWidget {
  final loginController = Get.find<LoginController>();
  final LocationController locationController = Get.put(LocationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'Food Ordering',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                TextField(
                    autocorrect: true,
                    controller: loginController.username,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    )),
                SizedBox(
                  height: 25,
                ),
                TextField(
                    autocorrect: true,
                    obscureText: true,
                    controller: loginController.password,
                    decoration: InputDecoration(
                      hintText: 'Password',
                    )),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                      elevation: 5,
                    ),
                    onPressed: () {
                      loginController.login();
                    },
                    child: Obx(() => loginController.isLoading.isTrue
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text('Login',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600))),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Wrap(
                    children: [
                      GestureDetector(
                        onTap: () => Get.to(() => ForgotPassword()),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () => Get.offAll(() => RegistrationPage()),
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
