import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lanbook/common/common.dart';
import 'package:lanbook/model/address.dart';
import 'package:lanbook/model/category.dart';
import 'package:lanbook/model/department.dart';
import 'package:lanbook/model/device.dart';
import 'package:lanbook/pages/loading_page.dart';

class LanbookService {
  getCategories() async {
    var url = Uri.parse('${kURL}categories');

    Map<String, String> headers = getHeaderWithAuth(userToken);

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

    Map<String, String> headers = getHeaderWithAuth(userToken);

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

    Map<String, String> headers = getHeaderWithAuth(userToken);

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
    Map<String, String> headers = getHeaderWithAuth(userToken);
    http.Response response = await http.delete(url, headers: headers);
    if (response.statusCode == 200) {
      return 'Deleted successfully';
    } else {
      return response.reasonPhrase.toString();
    }
  }

  getDepartments() async {
    var url = Uri.parse('${kURL}departments');

    Map<String, String> headers = getHeaderWithAuth(userToken);

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

    Map<String, String> headers = getHeaderWithAuth(userToken);

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

    Map<String, String> headers = getHeaderWithAuth(userToken);

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
    Map<String, String> headers = getHeaderWithAuth(userToken);
    http.Response response = await http.delete(url, headers: headers);
    if (response.statusCode == 200) {
      return 'Deleted successfully';
    } else {
      return response.reasonPhrase.toString();
    }
  }

  getDevices() async {
    var url = Uri.parse('${kURL}devices');
    Map<String, String> headers = getHeaderWithAuth(userToken);
    http.Response response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }

  saveDevice(Device device) async {
    var url = Uri.parse('${kURL}devices');
    Map<String, String> headers = getHeaderWithAuth(userToken);
    final body = jsonEncode({
      'name': device.name,
      'category_id': device.categoryId,
      'department_id': device.departmentId,
      'person': device.person,
      'domain': device.domain! ? 1 : 0,
      'internet': device.hasInternet! ? 1 : 0,
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
      return (jsonDecode(response.body));
    } else {
      return (response.reasonPhrase.toString());
    }
  }

  updateDevice(Device device) async {
    var url = Uri.parse('${kURL}devices/${device.id}');
    Map<String, String> headers = getHeaderWithAuth(userToken);
    final body = jsonEncode({
      'id': device.id,
      'name': device.name,
      'category_id': device.categoryId,
      'department_id': device.departmentId,
      'person': device.person,
      'domain': device.domain! ? 1 : 0,
      'internet': device.hasInternet! ? 1 : 0,
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
    Map<String, String> headers = getHeaderWithAuth(userToken);
    http.Response response = await http.delete(url, headers: headers);
    if (response.statusCode == 200) {
      return ('Deleted successfully');
    } else {
      return (response.reasonPhrase.toString());
    }
  }

  storeIpAddress(Address address) async {
    var url = Uri.parse('${kURL}addresses');
    Map<String, String> headers = getHeaderWithAuth(userToken);
    final body = jsonEncode({
      'device_id': address.deviceId,
      'ip_value': address.ipValue,
      'is_secondary': address.isSecondary! ? 1 : 0,
    });
    http.Response response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 201) {
      return 'Created successfully';
    } else {
      return response.reasonPhrase.toString();
    }
  }

  getIpAddress(int deviceId) async {
    var url = Uri.parse('${kURL}addresses/$deviceId');
    Map<String, String> headers = getHeaderWithAuth(userToken);
    http.Response response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return [];
    }
  }

  updateIpAddress(Address address) async {
    var url = Uri.parse('${kURL}addresses/${address.deviceId}');
    Map<String, String> headers = getHeaderWithAuth(userToken);
    final body = jsonEncode({
      'device_id': address.deviceId,
      'ip_value': address.ipValue,
      'is_secondary': address.isSecondary! ? 1 : 0,
    });
    http.Response response = await http.put(url, headers: headers, body: body);
    if (response.statusCode != 200) {
      return response.reasonPhrase;
    }
  }

  deleteIpAddress(int deviceID) async {
    var url = Uri.parse('${kURL}addresses/$deviceID');
    Map<String, String> headers = getHeaderWithAuth(userToken);
    http.Response response = await http.delete(url, headers: headers);
    if (response.statusCode != 200) {
      return response.reasonPhrase.toString();
    }
  }

  Future<List<Address>> getAllIpAddresses() async {
    var url = Uri.parse('${kURL}addresses');
    Map<String, String> headers = getHeaderWithAuth(userToken);
    http.Response response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      List<Address> savedIpList = [];
      List<dynamic> tempList = jsonDecode(response.body);
      for (var address in tempList) {
        var addressModel = Address();
        addressModel.deviceId = address['device_id'];
        addressModel.ipValue = getIp(address['ip_value']);
        addressModel.isSecondary = address['is_secondary'] == 1 ? true : false;
        savedIpList.add(addressModel);
      }
      return savedIpList;
    } else {
      return [];
    }
  }

  Future<bool> departmentDeleteConfirmation(int deptId) async {
    List<dynamic> devicesJson = await getDevices();
    List<Device> devices = [];
    if (devicesJson.isNotEmpty) {
      for (var device in devicesJson) {
        var deviceModel = Device();
        deviceModel.departmentId = device['department_id'];
        devices.add(deviceModel);
      }
    }
    var container = devices.where((element) => element.departmentId == deptId);
    if (container.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> categoryDeleteConfirmation(int catId) async {
    List<dynamic> devicesJson = await getDevices();
    List<Device> devices = [];
    if (devicesJson.isNotEmpty) {
      for (var device in devicesJson) {
        var deviceModel = Device();
        deviceModel.categoryId = device['category_id'];
        devices.add(deviceModel);
      }
    }
    var container = devices.where((element) => element.categoryId == catId);
    if (container.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
