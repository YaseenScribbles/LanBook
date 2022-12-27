import 'package:flutter/material.dart';
import 'package:lanbook/common/common.dart';
import 'package:lanbook/db_helper/repository.dart';
import 'package:lanbook/pages/category/categories_list_page.dart';
import 'package:lanbook/pages/department/departments_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Repository repository = Repository();

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
                onPressed: () {},
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

  @override
  void initState() {
    super.initState();
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
                          onPressed: (() {}),
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
