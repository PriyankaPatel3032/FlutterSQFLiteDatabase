import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_database/comman/commanwidget.dart';
import 'package:flutter_database/model/employee.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../db/databasehelper.dart';
import '../controller/employee_controller.dart';
import 'emplyee_add.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({Key? key}) : super(key: key);

  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  final EmployeeController _employeeController = Get.put(EmployeeController());
  final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    _employeeController.isRefresh.value = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SQFLite Database"),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Obx(() => _employeeController.isRefresh.value != null
                ? FutureBuilder<List<Employee>>(
                    future: dbHelper.queryAllRows(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Employee>> snapshot) {
                      if (snapshot.data?.length == 0) {
                        return Center(
                            child: CommanWidget.textviewLayout(
                                "No Data Found", 15, FontWeight.bold));
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (BuildContext context, int index) {
                            Employee item = snapshot.data![index];
                            return listLayout(item);
                          },
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  )
                : Container()),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Get.to(EmployeeAdd());
          },
        ));
  }

  Widget listLayout(Employee item) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card(
        elevation: 2,
        child: Slidable(
          startActionPane: ActionPane(
            motion: const DrawerMotion(),
            extentRatio: 0.25,
            children: [
              SlidableAction(
                label: 'Edit',
                backgroundColor: Colors.blue,
                icon: Icons.edit,
                onPressed: (context) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmployeeAdd(
                        employee: item,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            extentRatio: 0.25,
            children: [
              SlidableAction(
                label: 'Delete',
                backgroundColor: Colors.red,
                icon: Icons.delete,
                onPressed: (context) {
                  dbHelper.delete(item.id);
                  _employeeController.isRefresh.value =
                      !_employeeController.isRefresh.value;
                },
              ),
            ],
          ),
          child: ListTile(
            title: CommanWidget.textviewLayout(
                '${item.name}', 14, FontWeight.bold),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommanWidget.textviewLayout(
                    '${item.city}', 13, FontWeight.normal),
                CommanWidget.textviewLayout(
                    '${item.designation}', 13, FontWeight.normal),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
