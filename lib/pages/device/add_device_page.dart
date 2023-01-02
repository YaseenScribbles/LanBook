// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lanbook/common/common.dart';
import 'package:lanbook/model/address.dart';
import 'package:lanbook/model/category.dart';
import 'package:lanbook/model/department.dart';
import 'package:lanbook/model/device.dart';
import 'package:lanbook/pages/loading_page.dart';
import 'package:lanbook/services/lanbook_service.dart';

class AddDevice extends StatefulWidget {
  const AddDevice({super.key});

  @override
  State<AddDevice> createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController personCtrl = TextEditingController();
  TextEditingController vncPasswordCtrl = TextEditingController();
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController wifiNameCtrl = TextEditingController();
  TextEditingController wifiPasswordCtrl = TextEditingController();
  TextEditingController wifiIpRangeCtrl = TextEditingController();
  TextEditingController ipAddress1Ctrl = TextEditingController();
  TextEditingController ipAddress2Ctrl = TextEditingController();
  TextEditingController ipAddress3Ctrl = TextEditingController();
  TextEditingController ipAddress4Ctrl = TextEditingController();
  TextEditingController ipAddress5Ctrl = TextEditingController();

  int categoryId = 0;
  int departmentId = 0;
  bool domain = true;
  bool ip1Secondary = false;
  bool ip2Secondary = true;
  bool ip3Secondary = true;
  bool ip4Secondary = true;
  bool ip5Secondary = true;
  bool nameValidation = false;
  bool categoryValidation = false;
  bool departmentValidation = false;
  bool ipValidation = false;
  LanbookService service = LanbookService();
  List<Category> categoryList = <Category>[];
  List<Department> departmentList = <Department>[];

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

  storeAddress(int deviceId, String ip, bool isSecondary) async {
    Address address = Address();
    address.deviceId = deviceId;
    address.ipValue = ip;
    address.isSecondary = isSecondary;
    var result = await service.storeIpAddress(address);
    return result;
  }

  @override
  void initState() {
    super.initState();
    getCategroiesAndDepartment();
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
    ipAddress1Ctrl.dispose();
    ipAddress2Ctrl.dispose();
    ipAddress3Ctrl.dispose();
    ipAddress4Ctrl.dispose();
    ipAddress5Ctrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Device',
          style: kFontAppBar,
        ),
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'Secondary',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: ipAddress1Ctrl,
                decoration: InputDecoration(
                  labelText: 'IP Address 1',
                  hintText: 'Enter ip address',
                  errorText: ipValidation ? 'Enter one ip address' : null,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        ip1Secondary = !ip1Secondary;
                      });
                    },
                    icon: Icon(ip1Secondary
                        ? Icons.check_box
                        : Icons.check_box_outline_blank_outlined),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: ipAddress2Ctrl,
                decoration: InputDecoration(
                  labelText: 'IP Address 2',
                  hintText: 'Enter ip address',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        ip2Secondary = !ip2Secondary;
                      });
                    },
                    icon: Icon(ip2Secondary
                        ? Icons.check_box
                        : Icons.check_box_outline_blank_outlined),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: ipAddress3Ctrl,
                decoration: InputDecoration(
                  labelText: 'IP Address 3',
                  hintText: 'Enter ip address',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        ip3Secondary = !ip3Secondary;
                      });
                    },
                    icon: Icon(ip3Secondary
                        ? Icons.check_box
                        : Icons.check_box_outline_blank_outlined),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: ipAddress4Ctrl,
                decoration: InputDecoration(
                  labelText: 'IP Address 4',
                  hintText: 'Enter ip address',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        ip4Secondary = !ip4Secondary;
                      });
                    },
                    icon: Icon(ip4Secondary
                        ? Icons.check_box
                        : Icons.check_box_outline_blank_outlined),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: ipAddress5Ctrl,
                decoration: InputDecoration(
                  labelText: 'IP Address 5',
                  hintText: 'Enter ip address',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        ip5Secondary = !ip5Secondary;
                      });
                    },
                    icon: Icon(ip5Secondary
                        ? Icons.check_box
                        : Icons.check_box_outline_blank_outlined),
                  ),
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

                    ipAddress1Ctrl.text.isEmpty
                        ? ipValidation = true
                        : ipValidation = false;
                  });

                  if (categoryValidation) {
                    customSnackBar(context, 'Select valid category');
                    return;
                  } else if (departmentValidation) {
                    customSnackBar(context, 'Select valid department');
                    return;
                  }

                  Device device = Device();
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
                  device.userId = userId;

                  var result = await service.saveDevice(device);
                  await storeAddress(
                      result['id'], ipAddress1Ctrl.text, ip1Secondary);

                  if (ipAddress2Ctrl.text.isNotEmpty) {
                    await storeAddress(
                        result['id'], ipAddress2Ctrl.text, ip2Secondary);
                  } else if (ipAddress3Ctrl.text.isNotEmpty) {
                    await storeAddress(
                        result['id'], ipAddress3Ctrl.text, ip3Secondary);
                  } else if (ipAddress4Ctrl.text.isNotEmpty) {
                    await storeAddress(
                        result['id'], ipAddress4Ctrl.text, ip4Secondary);
                  } else if (ipAddress5Ctrl.text.isNotEmpty) {
                    await storeAddress(
                        result['id'], ipAddress5Ctrl.text, ip5Secondary);
                  }

                  customSnackBar(context, 'Created successfully');
                  Navigator.pop(context, result);
                },
                child: const Text(
                  'Save',
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
