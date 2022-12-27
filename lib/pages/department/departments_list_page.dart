import 'package:flutter/material.dart';
import 'package:lanbook/constants/constants.dart';
import 'package:lanbook/model/department.dart';
import 'package:lanbook/pages/department/add_department_page.dart';
import 'package:lanbook/pages/department/edit_department_page.dart';
import 'package:lanbook/services/lanbook_service.dart';

class DepartmentsPage extends StatefulWidget {
  const DepartmentsPage({super.key});

  @override
  State<DepartmentsPage> createState() => _DepartmentsPageState();
}

class _DepartmentsPageState extends State<DepartmentsPage> {
  int departmentCount = 0;
  List<Department> departmentList = <Department>[];
  LanbookService service = LanbookService();

  getDepartments() async {
    departmentList = [];
    var departments = await service.getDepartments();
    for (var department in departments) {
      var model = Department();
      model.id = department['id'];
      model.name = department['name'];
      model.isactive = department['is_active'] == 1 ? true : false;
      departmentList.add(model);
    }
    setState(() {
      departmentCount = departmentList.length;
    });
  }

  noDepartments() {
    return const Center(
      child: Text(
        'No departments available',
        style: kIconFont,
      ),
    );
  }

  departmentsList() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: ListView.builder(
          itemCount: departmentCount,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                elevation: 10.0,
                child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) {
                      return EditDepartment(department: departmentList[index]);
                    }))).then((value) {
                      if (value != null) {
                        getDepartments();
                      }
                    });
                  },
                  title: Text(
                    departmentList[index].name.toString(),
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
    getDepartments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Departments',
            style: kFontAppBar,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AddDepartment();
                })).then((value) {
                  if (value != null) {
                    getDepartments();
                  }
                });
              },
              icon: const Icon(Icons.add),
            ),
          ]),
      body: departmentCount == 0 ? noDepartments() : departmentsList(),
    );
  }
}
