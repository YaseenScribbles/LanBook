// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lanbook/common/common.dart';
import 'package:lanbook/model/category.dart';
import 'package:lanbook/pages/loading_page.dart';
import 'package:lanbook/services/lanbook_service.dart';

class EditCategory extends StatefulWidget {
  const EditCategory({super.key, required this.category});
  final Category category;
  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  TextEditingController categoryNameCtrl = TextEditingController();
  bool nameValidation = false;
  bool isActive = true;
  LanbookService service = LanbookService();
  Category category = Category();
  String result = '';

  deleteCategory(BuildContext context) async {
    category.id = widget.category.id;
    result = await service.deleteCategory(category);
    if (result == 'Deleted successfully') {
      customSnackBar(context, result);
      Navigator.pop(context, result);
      Navigator.pop(context, result);
    }
  }

  @override
  void initState() {
    super.initState();
    categoryNameCtrl.text = widget.category.name.toString();
    isActive = widget.category.isactive! ? true : false;
  }

  @override
  void dispose() {
    super.dispose();
    categoryNameCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Category',
          style: kFontAppBar,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await showDialogBox(context, 'Delete', 'Are you sure', 'Ok',
                  'Cancel', deleteCategory);
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
              controller: categoryNameCtrl,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Category',
                hintText: 'Enter a category',
                errorText: nameValidation ? 'Enter a valid category' : null,
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
                    categoryNameCtrl.text.isEmpty
                        ? nameValidation = true
                        : nameValidation = false;
                  });
                  category.id = widget.category.id;
                  category.name = categoryNameCtrl.text;
                  category.userId = userId;
                  category.isactive = isActive;
                  var result = await service.updateCategory(category);
                  customSnackBar(context, result);
                  Navigator.pop(context, 2);
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
