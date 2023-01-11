import 'package:flutter/material.dart';
import 'package:lanbook/common/common.dart';
import 'package:lanbook/model/device.dart';
import 'package:lanbook/pages/device/add_device_page.dart';
import 'package:lanbook/pages/device/edit_device_page.dart';
import 'package:lanbook/services/lanbook_service.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage(
      {super.key, required this.categoryId, required this.departmentId});
  final int categoryId;
  final int departmentId;
  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  int deviceCount = 0;
  List<Device> deviceList = <Device>[];
  List<Device> tempList = <Device>[];
  LanbookService service = LanbookService();
  TextEditingController searchCtrl = TextEditingController();
  bool isLoading = true;

  Future getDevices() async {
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
      model.hasInternet = device['internet'] == 1 ? true : false;
      deviceList.add(model);
    }
    deviceList.sort((a, b) => a.id!.compareTo(b.id!));
    if (widget.departmentId != 0) {
      deviceList = deviceList
          .where((device) => device.departmentId == widget.departmentId)
          .toList();
    } else if (widget.categoryId != 0) {
      deviceList = deviceList
          .where((device) => device.categoryId == widget.categoryId)
          .toList();
    }
    setState(() {
      deviceCount = deviceList.length;
      isLoading = false;
    });
    tempList = deviceList;
  }

  Widget loadingScreen() {
    return const Center(
      child: CircularProgressIndicator(),
    );
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
          itemCount: tempList.length + 1,
          itemBuilder: ((context, index) {
            if (index == 0) {
              return searchBar();
            } else {
              return listView(index - 1);
            }
          })),
    );
  }

  listView(index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
        elevation: 10.0,
        child: ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: ((context) {
              return EditDevice(device: tempList[index]);
            }))).then((value) {
              if (value != null) {
                getDevices();
              }
            });
          },
          title: Text(
            tempList[index].name.toString(),
            style: kFontBold,
          ),
        ),
      ),
    );
  }

  searchBar() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        controller: searchCtrl,
        decoration: const InputDecoration(
          hintText: 'Enter search term',
          border: OutlineInputBorder(),
        ),
        onChanged: ((value) {
          String searchTerm = value.toLowerCase();
          setState(() {
            tempList = deviceList.where((device) {
              String deviceName = device.name!.toLowerCase();
              return deviceName.contains(searchTerm);
            }).toList();
          });
        }),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getDevices();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? loadingScreen()
        : RefreshIndicator(
            onRefresh: getDevices,
            child: Scaffold(
              drawer: SafeArea(
                child: kGetDrawer(context),
              ),
              appBar: AppBar(
                  title: const Text(
                    'Devices',
                    style: kFontAppBar,
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
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
            ),
          );
  }
}
