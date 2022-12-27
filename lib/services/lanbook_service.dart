import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lanbook/constants/constants.dart';
import 'package:lanbook/model/category.dart';
import 'package:lanbook/model/department.dart';
import '../pages/loading_page.dart';

class LanbookService {
  getCategories() async {
    var url = Uri.parse('${kURL}categories');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };

    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      return [];
    }
  }

  saveCategory(Category category) async {
    var url = Uri.parse('${kURL}categories');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken'
    };

    final body = jsonEncode({
      'name': category.name,
      'user_id': category.userId,
    });

    http.Response response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 201) {
      return 'Created Successfully';
    } else {
      return 'Status : ${response.reasonPhrase}';
    }
  }

  updateCategory(Category category) async {
    var url = Uri.parse('${kURL}categories/${category.id}');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken'
    };

    final body = jsonEncode({
      'id': category.id,
      'name': category.name,
      'is_active': category.isactive! ? 1 : 0,
      'user_id': category.userId,
    });

    try {
      http.Response response =
          await http.put(url, headers: headers, body: body);
      return response.reasonPhrase.toString();
    } catch (e) {
      return e.toString();
    }
  }

  getDepartments() async {
    var url = Uri.parse('${kURL}departments');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken',
    };

    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      return [];
    }
  }

  saveDepartment(Department department) async {
    var url = Uri.parse('${kURL}departments');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken'
    };

    final body = jsonEncode({
      'name': department.name,
      'user_id': department.userId,
    });

    http.Response response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 201) {
      return 'Created Successfully';
    } else {
      return 'Status : ${response.reasonPhrase}';
    }
  }
}
