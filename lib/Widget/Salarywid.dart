import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hrapp/Model/PayrollModel.dart';
import 'package:hrapp/Themecolor/Palette.dart';

class Salarywid extends StatelessWidget {
  const Salarywid({super.key, required this.payrollmodel});

  final Payrollmodel payrollmodel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Employee Code :",
                style: TextStyle(fontSize: 12, color: Palette.Kgrey),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "${payrollmodel.Empid}",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Text(
                "Employee Name :",
                style: TextStyle(fontSize: 12, color: Palette.Kgrey),
              ),
              SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 150.w,
                child: Text(
                  "${payrollmodel.empname}",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100),
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Text(
                "NetSalary :",
                style: TextStyle(fontSize: 12, color: Palette.Kgrey),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "${payrollmodel.netSalary}.000",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Text(
                "Date of Joining :",
                style: TextStyle(fontSize: 12, color: Palette.Kgrey),
              ),
              SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 150.w,
                child: Text(
                  "${payrollmodel.processingYear}",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100),
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  softWrap: true,
                ),
              ),
            ],
          ),
          Divider(),
          Row(
            children: [
              Text(
                "Month :",
                style: TextStyle(fontSize: 12, color: Palette.Kgrey),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "${payrollmodel.dmonth}",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
