import 'package:flutter/material.dart';
import 'package:flutter_database/ui/employee_list.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Database',
      home: EmployeeList(),
    );
  }
}
