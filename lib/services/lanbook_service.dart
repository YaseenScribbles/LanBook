import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lanbook/common/common.dart';
import 'package:lanbook/model/category.dart';
import 'package:lanbook/model/department.dart';
import 'package:lanbook/model/device.dart';
import 'package:lanbook/pages/loading_page.dart';

class LanbookService {
  getCategories() async {
    var url = Uri.parse('${kURL}categories');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken'
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

    http.Response response = await http.put(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      return 'Updated successfully';
    } else {
      return response.reasonPhrase.toString();
    }
  }

  deleteCategory(Category category) async {
    var url = Uri.parse('${kURL}categories/${category.id}');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken'
    };
    http.Response response = await http.delete(url, headers: headers);
    if (response.statusCode == 200) {
      return 'Deleted successfully';
    } else {
      return response.reasonPhrase.toString();
    }
  }

  getDepartments() async {
    var url = Uri.parse('${kURL}departments');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken'
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

  updateDepartment(Department department) async {
    var url = Uri.parse('${kURL}departments/${department.id}');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken'
    };

    final body = jsonEncode({
      'id': department.id,
      'name': department.name,
      'is_active': department.isactive! ? 1 : 0,
      'user_id': department.userId,
    });

    http.Response response = await http.put(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      return 'Updated successfully';
    } else {
      return response.reasonPhrase.toString();
    }
  }

  deleteDepartment(Department department) async {
    var url = Uri.parse('${kURL}departments/${department.id}');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken'
    };
    http.Response response = await http.delete(url, headers: headers);
    if (response.statusCode == 200) {
      return 'Deleted successfully';
    } else {
      return response.reasonPhrase.toString();
    }
  }

  getDevices() async {
    var url = Uri.parse('${kURL}devices');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken'
    };
    http.Response response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }

  saveDevice(Device device) async {
    var url = Uri.parse('${kURL}devices');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken'
    };
    final body = jsonEncode({
      'name': device.name,
      'category_id': device.categoryId,
      'department_id': device.departmentId,
      'person': device.person,
      'domain': device.domain! ? 1 : 0,
      'vnc_password': device.vncPassword,
      'username': device.userName,
      'password': device.password,
      'wifi_name': device.wifiName,
      'wifi_password': device.wifiPassword,
      'wifi_ip_range': device.wifiIpRange,
      'user_id': device.userId,
    });

    http.Response response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      return ('Created successfully');
    } else {
      return (response.reasonPhrase.toString());
    }
  }

  updateDevice(Device device) async {
    var url = Uri.parse('${kURL}devices/${device.id}');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken'
    };
    final body = jsonEncode({
      'id': device.id,
      'name': device.name,
      'category_id': device.categoryId,
      'department_id': device.departmentId,
      'person': device.person,
      'domain': device.domain! ? 1 : 0,
      'vnc_password': device.vncPassword,
      'username': device.userName,
      'password': device.password,
      'wifi_name': device.wifiName,
      'wifi_password': device.wifiPassword,
      'wifi_ip_range': device.wifiIpRange,
      'user_id': device.userId,
      'is_active': device.isActive! ? 1 : 0,
    });

    http.Response response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return ('Updated successfully');
    } else {
      return (response.reasonPhrase.toString());
    }
  }

  deleteDevice(Device device) async {
    var url = Uri.parse('${kURL}devices/${device.id}');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $userToken'
    };
    http.Response response = await http.delete(url, headers: headers);
    if (response.statusCode == 200) {
      return ('Deleted successfully');
    } else {
      return (response.reasonPhrase.toString());
    }
  }
}
