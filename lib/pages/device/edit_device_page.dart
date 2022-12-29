// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lanbook/common/common.dart';
import 'package:lanbook/model/category.dart';
import 'package:lanbook/model/department.dart';
import 'package:lanbook/model/device.dart';
import 'package:lanbook/pages/loading_page.dart';
import 'package:lanbook/services/lanbook_service.dart';

class EditDevice extends StatefulWidget {
  const EditDevice({super.key, required this.device});
  final Device device;

  @override
  State<EditDevice> createState() => _EditDeviceState();
}

class _EditDeviceState extends State<EditDevice> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController personCtrl = TextEditingController();
  TextEditingController vncPasswordCtrl = TextEditingController();
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController wifiNameCtrl = TextEditingController();
  TextEditingController wifiPasswordCtrl = TextEditingController();
  TextEditingController wifiIpRangeCtrl = TextEditingController();
  int categoryId = 0;
  int departmentId = 0;
  bool domain = true;
  bool isActive = true;
  bool nameValidation = false;
  var categoryValidation = false;
  bool departmentValidation = false;
  LanbookService service = LanbookService();
  List<Category> categoryList = <Category>[];
  List<Department> departmentList = <Department>[];
  String result = '';
  Device device = Device();

  getCategroiesAndDepartment() async {
    var categories = await service.getCategories();
    var departments = await service.getDepartments();
    for (var category in categories) {
      setState(() {
        Category categoryModel = Category();
        categoryModel.id = category['id'];
        categoryModel.name = category['name'];
        categoryList.add(categoryModel);
      });
    }
    categoryList.sort(((a, b) => a.name
        .toString()
        .toLowerCase()
        .compareTo(b.name.toString().toLowerCase())));
    for (var department in departments) {
      setState(() {
        Department departmentModel = Department();
        departmentModel.id = department['id'];
        departmentModel.name = department['name'];
        departmentList.add(departmentModel);
      });
    }
    departmentList.sort(((a, b) => a.name
        .toString()
        .toLowerCase()
        .compareTo(b.name.toString().toLowerCase())));
  }

  deleteDevice(BuildContext context) async {
    device.id = widget.device.id;
    result = await service.deleteDevice(device);
    if (result == 'Deleted successfully') {
      customSnackBar(context, result);
      Navigator.pop(context, result);
      Navigator.pop(context, result);
    }
  }

  @override
  void initState() {
    super.initState();
    getCategroiesAndDepartment();
    nameCtrl.text = widget.device.name.toString();
    categoryId = widget.device.categoryId!;
    departmentId = widget.device.departmentId!;
    personCtrl.text = widget.device.person.toString();
    domain = widget.device.domain! ? true : false;
    vncPasswordCtrl.text = widget.device.vncPassword.toString();
    usernameCtrl.text = widget.device.userName.toString();
    passwordCtrl.text = widget.device.password.toString();
    wifiNameCtrl.text = widget.device.wifiName.toString();
    wifiPasswordCtrl.text = widget.device.wifiPassword.toString();
    wifiIpRangeCtrl.text = widget.device.wifiIpRange.toString();
    isActive = widget.device.isActive! ? true : false;
  }

  @override
  void dispose() {
    super.dispose();
    nameCtrl.dispose();
    personCtrl.dispose();
    vncPasswordCtrl.dispose();
    usernameCtrl.dispose();
    passwordCtrl.dispose();
    wifiNameCtrl.dispose();
    wifiPasswordCtrl.dispose();
    wifiIpRangeCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Device',
          style: kFontAppBar,
        ),
        actions: [
          IconButton(
              onPressed: () async {
                showDialogBox(context, 'Delete', 'Are you sure', 'Ok', 'Cancel',
                    deleteDevice);
              },
              icon: const Icon(Icons.delete)),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter device name',
                  errorText: nameValidation ? 'Enter valid name' : null,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              DropdownButton(
                isExpanded: true,
                value: categoryId == 0 ? null : categoryId,
                hint: const Text('Select a category'),
                items: categoryList.map((category) {
                  return DropdownMenuItem(
                    value: category.id,
                    child: Text(category.name.toString()),
                  );
                }).toList(),
                onChanged: ((value) {
                  setState(() {
                    categoryId = value!;
                  });
                }),
              ),
              const SizedBox(
                height: 20.0,
              ),
              DropdownButton(
                isExpanded: true,
                value: departmentId == 0 ? null : departmentId,
                hint: const Text('Select a department'),
                items: departmentList.map((department) {
                  return DropdownMenuItem(
                    value: department.id,
                    child: Text(department.name.toString()),
                  );
                }).toList(),
                onChanged: ((value) {
                  setState(() {
                    departmentId = value!;
                  });
                }),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: personCtrl,
                decoration: const InputDecoration(
                  labelText: 'Person',
                  hintText: 'Enter person name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: vncPasswordCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'VNC Password',
                  hintText: 'Enter vnc password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: usernameCtrl,
                decoration: const InputDecoration(
                  labelText: 'User Name',
                  hintText: 'Enter username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: passwordCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: wifiNameCtrl,
                decoration: const InputDecoration(
                  labelText: 'WIFI Name',
                  hintText: 'Enter wifi name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: wifiPasswordCtrl,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'WIFI Password',
                  hintText: 'Enter wifi password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: wifiIpRangeCtrl,
                decoration: const InputDecoration(
                  labelText: 'WIFI IP Range',
                  hintText: 'Enter wifi ip range',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                      value: domain,
                      onChanged: ((value) {
                        setState(() {
                          domain = value!;
                        });
                      })),
                  const Text(
                    'Domain',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 17.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                      value: isActive,
                      onChanged: ((value) {
                        setState(() {
                          isActive = value!;
                        });
                      })),
                  const Text(
                    'Is Active',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 17.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    nameCtrl.text.isEmpty
                        ? nameValidation = true
                        : nameValidation = false;

                    categoryId <= 0
                        ? categoryValidation = true
                        : categoryValidation = false;

                    departmentId <= 0
                        ? departmentValidation = true
                        : departmentValidation = false;
                  });

                  if (categoryValidation) {
                    customSnackBar(context, 'Select valid category');
                    return;
                  } else if (departmentValidation) {
                    customSnackBar(context, 'Select valid department');
                    return;
                  }

                  Device device = Device();
                  device.id = widget.device.id;
                  device.name = nameCtrl.text;
                  device.categoryId = categoryId;
                  device.departmentId = departmentId;
                  device.person = personCtrl.text;
                  device.vncPassword = vncPasswordCtrl.text;
                  device.userName = usernameCtrl.text;
                  device.password = passwordCtrl.text;
                  device.wifiName = wifiNameCtrl.text;
                  device.wifiPassword = wifiPasswordCtrl.text;
                  device.wifiIpRange = wifiIpRangeCtrl.text;
                  device.domain = domain;
                  device.isActive = isActive;
                  device.userId = userId;

                  var result = await service.updateDevice(device);
                  customSnackBar(context, result);
                  Navigator.pop(context, result);
                },
                child: const Text(
                  'Update',
                  style: kFontBold,
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
