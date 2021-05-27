import 'package:cowinbooking/Screens/OTPScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("OTP Authentication"),
          ),
          body: OTPScreen(),
        ),
      ),
    );
  }
}
