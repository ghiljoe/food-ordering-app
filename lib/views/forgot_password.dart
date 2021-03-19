import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordering_menu_app/controllers/login_controller.dart';

class ForgotPassword extends StatelessWidget {
  final loginController = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.pink),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'Forgot Password',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 70,
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
//                      loginController.login();
                    },
                    child: Obx(() => loginController.isLoading.isTrue
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text('Submit',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600))),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
//                Center(
//                  child: Wrap(
//                    children: [
//                      GestureDetector(
//                        onTap: () => Get.to(() => RegistrationPage()),
//                        child: Text(
//                          'Forgot Password?',
//                          style: TextStyle(
//                            fontSize: 17,
//                            fontWeight: FontWeight.w600,
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
