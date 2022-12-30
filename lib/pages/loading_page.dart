// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lanbook/db_helper/repository.dart';
import 'package:lanbook/pages/homepage.dart';
import 'package:lanbook/pages/login_page.dart';
import 'package:lanbook/services/login_service.dart';

String userToken = '';
String userName = '';
bool isAdmin = false;
int userId = 0;

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  bool isLoading = true;
  Repository repository = Repository();
  LoginService service = LoginService();

  getUserInfo() async {
    List<dynamic> userInfo = await repository.readUserInfo();
    if (userInfo.isNotEmpty) {
      Navigator.push(context, MaterialPageRoute(builder: ((context) {
        userName = userInfo[0]['name'];
        userToken = userInfo[0]['token'];
        isAdmin = userInfo[0]['admin'] == 1 ? true : false;
        return const HomePage();
      })));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: ((context) {
        return const LogIn();
      })));
    }
    setState(() {
      isLoading = false;
    });
  }

  loadingSpinner() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading ? loadingSpinner() : null,
    );
  }
}
