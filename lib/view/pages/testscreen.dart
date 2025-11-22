import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrapp/controller/ApprovalDetailsController.dart';
import 'package:hrapp/controller/Attendencedetails%20controller.dart';
import 'package:hrapp/controller/DashboardController.dart';
import 'package:hrapp/controller/Halfdaycontroller.dart';
import 'package:hrapp/controller/LeavehistroyController.dart';

class Testscreen extends StatelessWidget {
  const Testscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Approvaldetailscontroller approvaldetailscontroller =
        Approvaldetailscontroller();

    return Scaffold(
        body: Center(
      child: ElevatedButton(
          onPressed: () {
            // controller.gethalfdaylist();
            // attendencedetailscontroller.GetAttendencedetails();

            approvaldetailscontroller.GetApprovaldetails();
          },
          child: Text("Test")),
    ));
  }
}
