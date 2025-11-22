import 'package:flutter/material.dart';
import 'package:hrapp/constants/uidata.dart';

class Textwid extends StatelessWidget {
  const Textwid({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: employeeList.length,
        itemBuilder: (context, index) {
          Text(" employee name", style: TextStyle(color: Colors.black));
        });
  }
}
