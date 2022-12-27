import 'package:flutter/material.dart';
import 'package:lanbook/pages/loading_page.dart';

const kURL = 'http://192.168.0.220/lanbook/api/';

Map<String, String> kHeaderWithAuth = {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer $userToken'
};

Map<String, String> kHeaderWithoutAuth = {
  'Content-Type': 'application/json',
};

customSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.black,
    duration: const Duration(seconds: 1),
    content: Text(
      message,
      style: const TextStyle(
        fontSize: 15.0,
        fontFamily: 'Poppins',
        color: Colors.white,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    ),
  ));
}

const kFontAppBar = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.bold,
  letterSpacing: 0.5,
);

const kFontBold = TextStyle(
  fontFamily: 'Poppins',
  fontWeight: FontWeight.bold,
);

const kIconFont = TextStyle(
  fontFamily: 'Poppins',
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
);
