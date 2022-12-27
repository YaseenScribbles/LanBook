import 'package:flutter/material.dart';
import 'package:lanbook/common/common.dart';
import 'package:lanbook/model/category.dart';
import 'package:lanbook/pages/category/add_category_page.dart';
import 'package:lanbook/pages/category/edit_category_page.dart';
import 'package:lanbook/services/lanbook_service.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  int categoryCount = 0;
  List<Category> categoryList = <Category>[];
  LanbookService service = LanbookService();

  getCategories() async {
    categoryList = [];
    var categories = await service.getCategories();
    for (var category in categories) {
      var model = Category();
      model.id = category['id'];
      model.name = category['name'];
      model.isactive = category['is_active'] == 1 ? true : false;
      categoryList.add(model);
      categoryList.sort(((a, b) => a.id!.compareTo(b.id!)));
    }
    setState(() {
      categoryCount = categoryList.length;
    });
  }

  noCategories() {
    return const Center(
      child: Text(
        'No categories available',
        style: kIconFont,
      ),
    );
  }

  categoriesList() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: ListView.builder(
          itemCount: categoryCount,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                elevation: 10.0,
                child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) {
                      return EditCategory(category: categoryList[index]);
                    }))).then((value) {
                      if (value != null) {
                        getCategories();
                      }
                    });
                  },
                  title: Text(
                    categoryList[index].name.toString(),
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
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Categories',
            style: kFontAppBar,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AddCategory();
                })).then((value) {
                  if (value != null) {
                    getCategories();
                  }
                });
              },
              icon: const Icon(Icons.add),
            ),
          ]),
      body: categoryCount == 0 ? noCategories() : categoriesList(),
    );
  }
}
