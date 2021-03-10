import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toaster {
  static normal(String message) {
    Fluttertoast.showToast(
        msg: message,
        timeInSecForIosWeb: 3,
        textColor: Colors.black,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        fontSize: 16.0);
  }
}
