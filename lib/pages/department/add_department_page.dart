// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lanbook/common/common.dart';
import 'package:lanbook/model/department.dart';
import 'package:lanbook/pages/loading_page.dart';
import 'package:lanbook/services/lanbook_service.dart';

class AddDepartment extends StatefulWidget {
  const AddDepartment({super.key});

  @override
  State<AddDepartment> createState() => _AddDepartmentState();
}

class _AddDepartmentState extends State<AddDepartment> {
  TextEditingController departmentNameCtrl = TextEditingController();
  bool nameValidation = false;
  LanbookService service = LanbookService();
  Department department = Department();

  @override
  void dispose() {
    super.dispose();
    departmentNameCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Department',
          style: kFontAppBar,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
              height: 20.0,
            ),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    departmentNameCtrl.text.isEmpty
                        ? nameValidation = true
                        : nameValidation = false;
                  });

                  department.name = departmentNameCtrl.text;
                  department.userId = userId;
                  var result = await service.saveDepartment(department);
                  customSnackBar(context, result);
                  Navigator.pop(context, 1);
                },
                child: const Text(
                  'Save',
                  style: kFontBold,
                ))
          ],
        ),
      )),
    );
  }
}
