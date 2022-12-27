import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lanbook/constants/constants.dart';
import 'package:lanbook/db_helper/repository.dart';

import '../pages/loading_page.dart';

class LoginService {
  final Repository _repository = Repository();
  login(String email, String password) async {
    var url = Uri.parse('${kURL}login');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    http.Response response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);

      _repository.saveUserInfo(json['token'], json['name'], json['admin'], 1);

      return 'Logged In';
    } else {
      return 'Invalid credentials';
    }
  }

  userId() async {
    var url = Uri.parse('${kURL}user');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };

    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['id'];
    }
  }
}
