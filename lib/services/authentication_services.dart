import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ordering_menu_app/config/config.dart';
import 'package:ordering_menu_app/models/user.dart';

class AuthenticationServices {
  static Future authenticate(Map credentials) async {
    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(Config.API_URL + '/authenticate-user',
        headers: headers, body: json.encode(credentials));
    var responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      return userFromJson(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return responseData;
    }
  }
}
