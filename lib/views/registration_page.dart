import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordering_menu_app/controllers/registration_controller.dart';
import 'package:ordering_menu_app/views/login_page.dart';

class RegistrationPage extends StatelessWidget {
  final RegistrationController registrationController =
      Get.put(RegistrationController());
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
              'Create Account',
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
                    controller: registrationController.firstName,
                    decoration: InputDecoration(
                      hintText: 'First name',
                    )),
                SizedBox(
                  height: 25,
                ),
                TextField(
                    autocorrect: true,
                    controller: registrationController.lastName,
                    decoration: InputDecoration(
                      hintText: 'Last name',
                    )),
                SizedBox(
                  height: 25,
                ),
                TextField(
                    autocorrect: true,
                    controller: registrationController.email,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    )),
                SizedBox(
                  height: 25,
                ),
                TextField(
                    autocorrect: true,
                    obscureText: true,
                    controller: registrationController.password,
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
                      registrationController.createAccount();
                    },
                    child: Obx(() => registrationController.isLoading.isTrue
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text('Create Account',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600))),
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
                    'Already have an account? ',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () => Get.offAll(() => LoginPage()),
                    child: Text(
                      'Login',
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
