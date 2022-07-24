import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_database/comman/commanwidget.dart';
import 'package:flutter_database/model/employee.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../db/databasehelper.dart';
import '../controller/employee_controller.dart';

class EmployeeAdd extends StatefulWidget {

  final Employee? employee;

  EmployeeAdd({Key? key, this.employee}) : super(key: key);

  @override
  _EmployeeAddState createState() => _EmployeeAddState();
}

class _EmployeeAddState extends State<EmployeeAdd> {

  final dbHelper = DatabaseHelper.instance;
  final EmployeeController _employeeController = Get.find();

  TextEditingController nameController = new TextEditingController();
  TextEditingController designationController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.employee ==null ? "Add Employee" : "Update Employee"
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            CommanWidget.textfieldLayout(
                nameController,
                "Enter Employee Name",
                Icons.person,
                widget.employee == null ? "" : widget.employee!.name),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: CommanWidget.textfieldLayout(
                  designationController,
                  "Enter Employee Designation",
                  Icons.work_outlined,
                  widget.employee == null ? "" : widget.employee!.designation),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: CommanWidget.textfieldLayout(
                  cityController,
                  "Enter Employee City",
                  Icons.location_city,
                  widget.employee == null ? "" : widget.employee!.city),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (widget.employee == null) {
                      dbHelper.insert(toJson(nameController.text,
                          designationController.text, cityController.text));
                    } else {
                      dbHelper.querySelctedRows(
                          toJson(nameController.text,
                              designationController.text, cityController.text),
                          widget.employee?.id);
                    }
                    _employeeController.isRefresh.value = !_employeeController.isRefresh.value;
                    Get.back(result: "Patel");
                  },
                  child: Text(widget.employee == null ? 'ADD' : 'UPDATE'),
                  style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> toJson(String name, String designation, String city) {
    final map = <String, dynamic>{};
    map['Name'] = name;
    map['Designation'] = designation;
    map['City'] = city;

    return map;
  }

}
