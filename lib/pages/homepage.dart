// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lanbook/common/common.dart';
import 'package:lanbook/db_helper/repository.dart';
import 'package:lanbook/pages/category/categories_list_page.dart';
import 'package:lanbook/pages/department/departments_list_page.dart';
import 'package:lanbook/pages/device/devices_list_page.dart';
import 'package:lanbook/pages/loading_page.dart';
import 'package:lanbook/pages/login_page.dart';
import 'package:lanbook/services/login_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Repository repository = Repository();
  LoginService service = LoginService();

  Future<void> showDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Log Out',
              style: kFontBold,
            ),
            content: const Text(
              'Are you sure ?',
              style: kFontBold,
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await repository.updateUserInfo();
                  var result = await service.logout();
                  userToken = '';
                  userName = '';
                  isAdmin = false;
                  userId = 0;
                  customSnackBar(context, result);
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return const LogIn();
                  })));
                },
                child: const Text(
                  'OK',
                  style: kFontBold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: kFontBold,
                ),
              ),
            ],
          );
        });
  }

  getUserInfo() async {
    userId = await service.getUserId();
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home Page',
            style: kFontAppBar,
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                showDialogBox(context);
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 120.0,
                        child: ElevatedButton(
                          onPressed: (() {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const CategoriesPage();
                            }));
                          }),
                          child: const Text(
                            'Categories',
                            style: kIconFont,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 120.0,
                        child: ElevatedButton(
                          onPressed: (() {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const DepartmentsPage();
                            }));
                          }),
                          child: const Text(
                            'Departments',
                            style: kIconFont,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 120.0,
                        child: ElevatedButton(
                          onPressed: (() {
                            Navigator.push(context,
                                MaterialPageRoute(builder: ((context) {
                              return const DevicesPage();
                            })));
                          }),
                          child: const Text(
                            'Devices',
                            style: kIconFont,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Container(
                        height: 120.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
