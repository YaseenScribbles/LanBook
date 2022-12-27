import 'package:flutter/material.dart';
import 'package:lanbook/model/department.dart';

class EditDepartment extends StatefulWidget {
  const EditDepartment({super.key, required this.department});
  final Department department;
  @override
  State<EditDepartment> createState() => _EditDepartmentState();
}

class _EditDepartmentState extends State<EditDepartment> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
