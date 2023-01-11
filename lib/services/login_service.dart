import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lanbook/common/common.dart';
import 'package:lanbook/db_helper/repository.dart';
import '../pages/loading_page.dart';

class LoginService {
  final Repository _repository = Repository();
  login(String email, String password) async {
    var url = Uri.parse('${kURL}login');

    Map<String, String> headers = kHeaderWithoutAuth;

    final body = jsonEncode({
      'email': email,
      'password': password,
    });

    http.Response response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);

      try {
        await _repository.saveUserInfo(
            json['token'], json['name'], json['admin'], 1, email, password);
      } catch (e) {
        return e.toString();
      }

      userName = json['name'];
      userToken = json['token'];
      isAdmin = json['admin'] == 1 ? true : false;

      return 'Logged In';
    } else {
      return 'Invalid credentials';
    }
  }

  logout() async {
    var url = Uri.parse('${kURL}logout');
    Map<String, String> headers = getHeaderWithAuth(userToken);
    http.Response response = await http.post(url, headers: headers);
    if (response.statusCode == 200) {
      userName = '';
      userToken = '';
      isAdmin = false;
      return 'Logged Out';
    } else {
      return response.reasonPhrase.toString();
    }
  }

  getUserId() async {
    var url = Uri.parse('${kURL}user');

    Map<String, String> headers = getHeaderWithAuth(userToken);

    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['id'];
    } else {
      return 1;
    }
  }
}
