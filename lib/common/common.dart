import 'package:flutter/material.dart';
import 'package:lanbook/pages/category/categories_list_page.dart';
import 'package:lanbook/pages/department/departments_list_page.dart';
import 'package:lanbook/pages/device/devices_list_page.dart';

const kURL = 'http://192.168.0.220:81/lanbook/api/';
// const kURL = 'https://essagarments.ddns.me/lanbook/api/';

RegExp ipRegEx = RegExp(
    '^(\\d|[1-9]\\d|1\\d\\d|2([0-4]\\d|5[0-5]))\\.(\\d|[1-9]\\d|1\\d\\d|2([0-4]\\d|5[0-5]))\\.(\\d|[1-9]\\d|1\\d\\d|2([0-4]\\d|5[0-5]))\\.(\\d|[1-9]\\d|1\\d\\d|2([0-4]\\d|5[0-5]))\$');

getHeaderWithAuth(String token) {
  Map<String, String> kHeaderWithAuth = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };

  return kHeaderWithAuth;
}

Map<String, String> kHeaderWithoutAuth = {
  'Content-Type': 'application/json',
};

customSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.black,
    duration: const Duration(seconds: 2),
    content: Text(
      message,
      style: const TextStyle(
        fontSize: 15.0,
        fontFamily: 'Poppins',
        color: Colors.white,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    ),
  ));
}

const kFontAppBar = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.bold,
  letterSpacing: 0.5,
);

const kFontBold = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.bold,
);

const kIconFont = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 15.0,
  fontWeight: FontWeight.bold,
);

Future<void> showDialogBox(BuildContext context, String titleText,
    String contentText, String btnText1, String btnText2, Function function1) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            titleText,
            style: kFontBold,
          ),
          content: Text(
            contentText,
            style: kFontBold,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await function1(context);
              },
              child: Text(
                btnText1,
                style: kFontBold,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                btnText2,
                style: kFontBold,
              ),
            ),
          ],
        );
      });
}

getIp(int ip) {
  var strData = StringBuffer();
  for (int i = 0; i < 4; i++) {
    strData.write(ip >> 24 & 0xff);
    if (i < 3) {
      strData.write(".");
    }
    ip = ip << 8;
  }
  return strData.toString();
}

List<String> listOfIpAddresses(String ip1, String ip2) {
  List<String> list = [];
  if (ip1.isEmpty || ip2.isEmpty) {
    return list;
  }
  var startNum = ip1.split('.')[3];
  String partialIp = ip1.substring(0, ip1.length - startNum.length);
  var endNum = ip2.split('.')[3];

  for (int i = int.parse(startNum); i <= int.parse(endNum); i++) {
    list.add(partialIp + i.toString());
  }
  return list;
}

Drawer kGetDrawer(BuildContext context) {
  return Drawer(
    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(
        height: 200.0,
        color: Colors.blue,
        child: const Text(
          ' LAN BOOK',
          style: TextStyle(fontSize: 30.0, fontFamily: 'Poppins'),
        ),
      ),
      ListTile(
          title: const Text(
            'Categories',
            style: kIconFont,
          ),
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) {
              return const CategoriesPage();
            })));
          }),
      const Divider(
        color: Colors.white,
      ),
      ListTile(
          title: const Text(
            'Departments',
            style: kIconFont,
          ),
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) {
              return const DepartmentsPage();
            })));
          }),
      const Divider(
        color: Colors.white,
      ),
      ListTile(
          title: const Text(
            'Devices',
            style: kIconFont,
          ),
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: ((context) {
              return const DevicesPage(
                categoryId: 0,
                departmentId: 0,
              );
            })));
          }),
      const Divider(
        color: Colors.white,
      ),
    ]),
  );
}

// DropdownButton(
//                 isExpanded: true,
//                 value: categoryId == 0 ? null : categoryId,
//                 hint: const Text('Select a category'),
//                 items: categoryList.map((category) {
//                   return DropdownMenuItem(
//                     value: category.id,
//                     child: Text(category.name.toString()),
//                   );
//                 }).toList(),
//                 onChanged: ((value) {
//                   setState(() {
//                     categoryId = value!;
//                   });
//                 }),
//               ),
