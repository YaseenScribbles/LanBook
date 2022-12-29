import 'package:flutter/material.dart';
import 'package:lanbook/common/common.dart';
import 'package:lanbook/model/device.dart';
import 'package:lanbook/pages/device/add_device_page.dart';
import 'package:lanbook/pages/device/edit_device_page.dart';
import 'package:lanbook/services/lanbook_service.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  int deviceCount = 0;
  List<Device> deviceList = <Device>[];
  LanbookService service = LanbookService();

  getDevices() async {
    deviceList = [];
    var devices = await service.getDevices();
    for (var device in devices) {
      var model = Device();
      model.id = device['id'];
      model.name = device['name'];
      model.categoryId = device['category_id'];
      model.departmentId = device['department_id'];
      model.person = device['person'] ?? '';
      model.domain = device['domain'] == 1 ? true : false;
      model.vncPassword = device['vnc_password'] ?? '';
      model.userName = device['username'] ?? '';
      model.password = device['password'] ?? '';
      model.wifiName = device['wifi_name'] ?? '';
      model.wifiPassword = device['wifi_password'] ?? '';
      model.wifiIpRange = device['wifi_ip_range'] ?? '';
      model.isActive = device['is_active'] == 1 ? true : false;
      model.userId = device['user_id'];
      deviceList.add(model);
    }
    deviceList.sort((a, b) => a.id!.compareTo(b.id!));
    setState(() {
      deviceCount = deviceList.length;
    });
  }

  noDevices() {
    return const Center(
      child: Text(
        'No devices available',
        style: kIconFont,
      ),
    );
  }

  devicesList() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: ListView.builder(
          itemCount: deviceCount,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                elevation: 10.0,
                child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) {
                      return EditDevice(device: deviceList[index]);
                    }))).then((value) {
                      if (value != null) {
                        getDevices();
                      }
                    });
                  },
                  title: Text(
                    deviceList[index].name.toString(),
                    style: kFontBold,
                  ),
                ),
              ),
            );
          })),
    );
  }

  @override
  void initState() {
    super.initState();
    getDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Devices',
            style: kFontAppBar,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AddDevice();
                })).then((value) {
                  if (value != null) {
                    getDevices();
                  }
                });
              },
              icon: const Icon(Icons.add),
            ),
          ]),
      body: deviceCount == 0 ? noDevices() : devicesList(),
    );
  }
}
