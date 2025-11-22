import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrapp/bulider/ApproverDetailsBulider.dart';
import 'package:hrapp/controller/ApprovalDetailsController.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Approvaldetailscontroller approvaldetailscontroller =
        Get.put(Approvaldetailscontroller());

    approvaldetailscontroller.GetApprovaldetails();

    return Scaffold(
        appBar: AppBar(
          title: Text("Notifications"),
        ),
        body: Obx(() {
          if (approvaldetailscontroller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Approverdetailsbulider();
          }
        }));
  }
}
