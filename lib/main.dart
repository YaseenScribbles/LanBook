import 'package:flutter/material.dart';
import 'package:lanbook/pages/loading_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LAN BOOK',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const LoadingPage(),
    );
  }
}
