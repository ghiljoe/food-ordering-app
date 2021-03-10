import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordering_menu_app/controllers/location_controller.dart';
import 'package:ordering_menu_app/controllers/login_controller.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Food Ordering',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 80,
            ),
            TextField(
                autocorrect: true,
                controller: loginController.username,
                decoration: InputDecoration(
                  hintText: 'Username',
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
              height: 80,
            ),
            Container(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink,
                  elevation: 0,
                ),
                onPressed: () {
                  loginController.login();
                },
                child: Obx(() => loginController.isLoading.isTrue
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Text('Login', style: TextStyle(fontSize: 14))),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
