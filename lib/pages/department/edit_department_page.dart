// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lanbook/common/common.dart';
import 'package:lanbook/model/department.dart';
import 'package:lanbook/pages/loading_page.dart';
import 'package:lanbook/services/lanbook_service.dart';

class EditDepartment extends StatefulWidget {
  const EditDepartment({super.key, required this.department});
  final Department department;
  @override
  State<EditDepartment> createState() => _EditDepartmentState();
}

class _EditDepartmentState extends State<EditDepartment> {
  TextEditingController departmentNameCtrl = TextEditingController();
  bool nameValidation = false;
  bool isActive = true;
  LanbookService service = LanbookService();
  Department department = Department();
  String result = '';

  deleteDepartment(BuildContext context) async {
    department.id = widget.department.id;
    bool ifExists = await service.departmentDeleteConfirmation(department.id!);
    if (ifExists) {
      customSnackBar(context, 'Device available with this department');
      Navigator.pop(context, result);
    } else {
      result = await service.deleteDepartment(department);
      if (result == 'Deleted successfully') {
        customSnackBar(context, result);
        Navigator.pop(context, result);
        Navigator.pop(context, result);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    departmentNameCtrl.text = widget.department.name.toString();
    isActive = widget.department.isactive! ? true : false;
  }

  @override
  void dispose() {
    super.dispose();
    departmentNameCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: kGetDrawer(context),
      ),
      appBar: AppBar(
        title: const Text(
          'Edit Department',
          style: kFontAppBar,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await showDialogBox(context, 'Delete', 'Are you sure', 'Ok',
                  'Cancel', deleteDepartment);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: departmentNameCtrl,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Department',
                hintText: 'Enter a department',
                errorText: nameValidation ? 'Enter a valid department' : null,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Checkbox(
                    value: isActive,
                    onChanged: ((value) {
                      setState(() {
                        isActive = value!;
                      });
                    })),
                const Text(
                  'Is Active ?',
                  style: kFontBold,
                )
              ],
            ),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    departmentNameCtrl.text.isEmpty
                        ? nameValidation = true
                        : nameValidation = false;
                  });
                  department.id = widget.department.id;
                  department.name = departmentNameCtrl.text;
                  department.userId = userId;
                  department.isactive = isActive;
                  var result = await service.updateDepartment(department);
                  customSnackBar(context, result);
                  Navigator.pop(context, result);
                },
                child: const Text(
                  'Update',
                  style: kFontBold,
                ))
          ],
        ),
      )),
    );
  }
}
