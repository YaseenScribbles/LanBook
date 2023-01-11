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
  TextEditingController wifiIpRangeStartCtrl = TextEditingController();
  TextEditingController wifiIpRangeEndCtrl = TextEditingController();
  TextEditingController ipAddress1Ctrl = TextEditingController();
  TextEditingController ipAddress2Ctrl = TextEditingController();
  TextEditingController ipAddress3Ctrl = TextEditingController();
  TextEditingController ipAddress4Ctrl = TextEditingController();
  TextEditingController ipAddress5Ctrl = TextEditingController();

  int categoryId = 0;
  int departmentId = 0;
  bool domain = true;
  bool internet = false;
  bool nameValidation = false;
  bool categoryValidation = false;
  bool departmentValidation = false;
  bool ipValidation = false;
  bool ip1Validation = false;
  bool ip2Validation = false;
  bool ip3Validation = false;
  bool ip4Validation = false;
  bool ip5Validation = false;
  bool rangeIp1Validation = false;
  bool rangeIp2Validation = false;
  LanbookService service = LanbookService();
  List<Category> categoryList = <Category>[];
  List<Department> departmentList = <Department>[];
  bool isLoading = false;

  getCategroiesAndDepartment() async {
    List<dynamic> categories = await service.getCategories();
    List<dynamic> departments = await service.getDepartments();
    if (categories.isNotEmpty) {
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
    }
    if (departments.isNotEmpty) {
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
  }

  storeAddress(int deviceId, String ip, bool isSecondary) async {
    Address address = Address();
    address.deviceId = deviceId;
    address.ipValue = ip;
    address.isSecondary = isSecondary;
    var result = await service.storeIpAddress(address);
    return result;
  }

  ipListValidation(
      List<String> tempList, List<Address> ipList, List<String> addingList) {
    // ipList = ipList.where((ip) => ip.isSecondary == true).toList();
    for (var i = 0; i < tempList.length; i++) {
      for (var j = 0; j < ipList.length; j++) {
        if (tempList[i] == ipList[j].ipValue.toString()) {
          addingList.add(ipList[j].ipValue.toString());
        }
      }
    }
    setState(() {
      addingList.isNotEmpty ? ipValidation = true : ipValidation = false;
    });
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
    wifiIpRangeStartCtrl.dispose();
    wifiIpRangeEndCtrl.dispose();
    ipAddress1Ctrl.dispose();
    ipAddress2Ctrl.dispose();
    ipAddress3Ctrl.dispose();
    ipAddress4Ctrl.dispose();
    ipAddress5Ctrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: kGetDrawer(context),
      ),
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
                  labelText: 'Name / SSID',
                  hintText: 'Enter device name',
                  errorText: nameValidation ? 'Enter valid name' : null,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Category',
                    hintText: 'Select device category',
                    errorText:
                        categoryValidation ? 'Select valid category' : null,
                    border: const OutlineInputBorder(),
                  ),
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
                  })),
              const SizedBox(
                height: 20.0,
              ),
              DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Department',
                    hintText: 'Select device department',
                    errorText:
                        departmentValidation ? 'Select valid department' : null,
                    border: const OutlineInputBorder(),
                  ),
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
                  })),
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
                decoration: const InputDecoration(
                  labelText: 'WIFI Password',
                  hintText: 'Enter wifi password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: wifiIpRangeStartCtrl,
                      decoration: InputDecoration(
                        labelText: 'WIFI IP Range Start',
                        hintText: 'Enter wifi starting ip',
                        errorText: rangeIp1Validation ? 'Enter valid ip' : null,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: TextField(
                      controller: wifiIpRangeEndCtrl,
                      decoration: InputDecoration(
                        labelText: 'WIFI IP Range End',
                        hintText: 'Enter wifi ending ip',
                        errorText: rangeIp2Validation ? 'Enter valid ip' : null,
                        border: const OutlineInputBorder(),
                      ),
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
                  errorText: ip1Validation ? 'Enter valid ip' : null,
                  border: const OutlineInputBorder(),
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
                  errorText: ip2Validation ? 'Enter valid ip' : null,
                  border: const OutlineInputBorder(),
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
                  errorText: ip3Validation ? 'Enter valid ip' : null,
                  border: const OutlineInputBorder(),
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
                  errorText: ip4Validation ? 'Enter valid ip' : null,
                  border: const OutlineInputBorder(),
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
                  errorText: ip5Validation ? 'Enter valid ip' : null,
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
                  const SizedBox(
                    width: 15.0,
                  ),
                  Checkbox(
                      value: internet,
                      onChanged: ((value) {
                        setState(() {
                          internet = value!;
                        });
                      })),
                  const Text(
                    'Internet',
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
                    isLoading = true;
                  });
                  List<Address> ipList = await service.getAllIpAddresses();
                  // List<Address> ipListPrimary =
                  //     ipList.where((ip) => ip.isSecondary == false).toList();
                  List<String> tempList = [];
                  List<String> alreadyExists = [];

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

                    if (ipAddress1Ctrl.text.isNotEmpty) {
                      ip1Validation =
                          ipRegEx.hasMatch(ipAddress1Ctrl.text) ? false : true;
                      if (!ip1Validation) {
                        for (var ip in ipList) {
                          if (ipAddress1Ctrl.text == ip.ipValue) {
                            ipValidation = true;
                            alreadyExists.add(ip.ipValue!);
                          }
                        }
                      }
                    } else if (ipAddress1Ctrl.text.isEmpty) {
                      ip1Validation = false;
                    }
                    if (ipAddress2Ctrl.text.isNotEmpty) {
                      ip2Validation =
                          ipRegEx.hasMatch(ipAddress2Ctrl.text) ? false : true;
                      if (!ip2Validation) {
                        for (var ip in ipList) {
                          if (ipAddress2Ctrl.text == ip.ipValue) {
                            ipValidation = true;
                            alreadyExists.add(ip.ipValue!);
                          }
                        }
                      }
                    } else if (ipAddress2Ctrl.text.isEmpty) {
                      ip2Validation = false;
                    }
                    if (ipAddress3Ctrl.text.isNotEmpty) {
                      ip3Validation =
                          ipRegEx.hasMatch(ipAddress3Ctrl.text) ? false : true;
                      if (!ip3Validation) {
                        for (var ip in ipList) {
                          if (ipAddress3Ctrl.text == ip.ipValue) {
                            ipValidation = true;
                            alreadyExists.add(ip.ipValue!);
                          }
                        }
                      }
                    } else if (ipAddress3Ctrl.text.isEmpty) {
                      ip3Validation = false;
                    }
                    if (ipAddress4Ctrl.text.isNotEmpty) {
                      ip4Validation =
                          ipRegEx.hasMatch(ipAddress4Ctrl.text) ? false : true;
                      if (!ip4Validation) {
                        for (var ip in ipList) {
                          if (ipAddress4Ctrl.text == ip.ipValue) {
                            ipValidation = true;
                            alreadyExists.add(ip.ipValue!);
                          }
                        }
                      }
                    } else if (ipAddress4Ctrl.text.isEmpty) {
                      ip4Validation = false;
                    }
                    if (ipAddress5Ctrl.text.isNotEmpty) {
                      ip5Validation =
                          ipRegEx.hasMatch(ipAddress5Ctrl.text) ? false : true;
                      if (!ip5Validation) {
                        for (var ip in ipList) {
                          if (ipAddress5Ctrl.text == ip.ipValue) {
                            ipValidation = true;
                            alreadyExists.add(ip.ipValue!);
                          }
                        }
                      }
                    } else if (ipAddress5Ctrl.text.isEmpty) {
                      ip5Validation = false;
                    }
                    if (wifiIpRangeStartCtrl.text.isNotEmpty) {
                      rangeIp1Validation =
                          ipRegEx.hasMatch(wifiIpRangeStartCtrl.text)
                              ? false
                              : true;
                    } else if (wifiIpRangeStartCtrl.text.isEmpty) {
                      rangeIp1Validation = false;
                    }
                    if (wifiIpRangeEndCtrl.text.isNotEmpty) {
                      rangeIp2Validation =
                          ipRegEx.hasMatch(wifiIpRangeEndCtrl.text)
                              ? false
                              : true;
                    } else if (wifiIpRangeEndCtrl.text.isEmpty) {
                      rangeIp2Validation = false;
                    }
                  });

                  if (wifiIpRangeStartCtrl.text.isNotEmpty &&
                          wifiIpRangeEndCtrl.text.isEmpty ||
                      wifiIpRangeStartCtrl.text.isEmpty &&
                          wifiIpRangeEndCtrl.text.isNotEmpty) {
                    customSnackBar(
                        context, 'Please provide start and end ip range');
                    setState(() {
                      isLoading = false;
                    });
                    return;
                  }

                  if (rangeIp1Validation == false &&
                      rangeIp2Validation == false) {
                    tempList = listOfIpAddresses(
                        wifiIpRangeStartCtrl.text, wifiIpRangeEndCtrl.text);
                    ipListValidation(tempList, ipList, alreadyExists);
                  }

                  if (ipValidation) {
                    String message = '';
                    for (var ip in alreadyExists) {
                      message += '$ip\n';
                    }
                    customSnackBar(context, 'Already exists\n$message');
                  }

                  if (!nameValidation &&
                      !categoryValidation &&
                      !departmentValidation &&
                      !ip1Validation &&
                      !ip2Validation &&
                      !ip3Validation &&
                      !ip4Validation &&
                      !ip5Validation &&
                      !rangeIp1Validation &&
                      !rangeIp2Validation &&
                      !ipValidation) {
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
                    device.wifiIpRange =
                        '${wifiIpRangeStartCtrl.text}-${wifiIpRangeEndCtrl.text}';
                    device.domain = domain;
                    device.hasInternet = internet;
                    device.userId = userId;

                    var result = await service.saveDevice(device);

                    if (tempList.isNotEmpty) {
                      for (String ip in tempList) {
                        await storeAddress(result['id'], ip, true);
                      }
                    }

                    if (ipAddress1Ctrl.text.isNotEmpty) {
                      await storeAddress(
                          result['id'], ipAddress1Ctrl.text, false);
                    }
                    if (ipAddress2Ctrl.text.isNotEmpty) {
                      await storeAddress(
                          result['id'], ipAddress2Ctrl.text, false);
                    }
                    if (ipAddress3Ctrl.text.isNotEmpty) {
                      await storeAddress(
                          result['id'], ipAddress3Ctrl.text, false);
                    }
                    if (ipAddress4Ctrl.text.isNotEmpty) {
                      await storeAddress(
                          result['id'], ipAddress4Ctrl.text, false);
                    }
                    if (ipAddress5Ctrl.text.isNotEmpty) {
                      await storeAddress(
                          result['id'], ipAddress5Ctrl.text, false);
                    }

                    customSnackBar(context, 'Created successfully');
                    Navigator.pop(context, result);
                  } else {
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                child: const Text(
                  'Save',
                  style: kFontBold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 20.0,
                  width: double.infinity,
                  child: isLoading ? const LinearProgressIndicator() : null,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
