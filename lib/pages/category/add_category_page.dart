// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lanbook/constants/constants.dart';
import 'package:lanbook/model/category.dart';
import 'package:lanbook/pages/loading_page.dart';
import 'package:lanbook/services/lanbook_service.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController categoryNameCtrl = TextEditingController();
  bool nameValidation = false;
  LanbookService service = LanbookService();
  Category category = Category();

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
          'Add Category',
          style: kFontAppBar,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
              height: 20.0,
            ),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    categoryNameCtrl.text.isEmpty
                        ? nameValidation = true
                        : nameValidation = false;
                  });

                  category.name = categoryNameCtrl.text;
                  category.userId = userId;
                  var result = await service.saveCategory(category);
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
