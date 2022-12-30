// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lanbook/common/common.dart';
import 'package:lanbook/db_helper/repository.dart';
import 'package:lanbook/pages/homepage.dart';
import 'package:lanbook/services/login_service.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  bool _nameValidation = false;
  bool _passwordValidation = false;
  final LoginService _service = LoginService();
  Repository repository = Repository();

  getLastLoggedUserInfo() async {
    List<Map<String, dynamic>> results = await repository.lastLoggedUserInfo();
    if (results.isNotEmpty) {
      _emailCtrl.text = results[0]['email'];
      _passwordCtrl.text = results[0]['password'];
    }
  }

  @override
  void initState() {
    super.initState();
    getLastLoggedUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Log In',
            style: kFontAppBar,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: _emailCtrl,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    errorText: _nameValidation ? 'Enter a valid name' : null,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: _passwordCtrl,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    errorText:
                        _passwordValidation ? 'Enter a valid password' : null,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _emailCtrl.text.isEmpty
                              ? _nameValidation = true
                              : _nameValidation = false;

                          _passwordCtrl.text.isEmpty
                              ? _passwordValidation = true
                              : _passwordValidation = false;
                        });
                        var result = await _service.login(
                            _emailCtrl.text, _passwordCtrl.text);
                        customSnackBar(context, result);
                        if (result != 'Invalid credentials') {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const HomePage();
                          }));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                      ),
                      child: const Text(
                        'Log In',
                        style: kFontBold,
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
