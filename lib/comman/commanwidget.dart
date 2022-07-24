import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommanWidget {

  static Widget textfieldLayout(TextEditingController dataController,
      String name, IconData icondata, String? employee) {
    dataController.text = employee!;
    return TextField(
        controller: dataController,
        style: TextStyle(color: Colors.black45, fontSize: 14),
        decoration: InputDecoration(
            hintText: name,
            prefixIcon: Icon(
              icondata,
              color: Color(0xFF6CB0E3),
            ),
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: Color(0xFFE4F2FD),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Color(0xFF6CB0E3), width: 1),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Color(0xFF6CB0E3), width: 2),
            )));
  }

  static Widget textviewLayout(String text, double fontsize,FontWeight fontWeight) {
    return Text(
        text,
        style:  TextStyle(
            fontSize: fontsize,
            fontWeight: fontWeight,
            color: Colors.black));
  }
}
