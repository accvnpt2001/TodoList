import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/pages/auth/sign_in_view.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init("Account");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignIn(),
    );
  }
}
