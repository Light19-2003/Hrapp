import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hrapp/Model/SetworkFlow.dart';
import 'package:hrapp/controller/ApprovalDetailsController.dart';
import 'package:hrapp/controller/Payrollcontroller.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

class Setworkflow extends GetxController {
  SetworkResponse setworkResponse = SetworkResponse();

  Approvaldetailscontroller approvaldetailscontroller =
      Get.put(Approvaldetailscontroller());

  TextEditingController Comment = TextEditingController();
  SetworkflowApprover setworkflowApprover = SetworkflowApprover();
  Future<void> SetWorkFlow(
    int workflow,
    int RecordId,
    String action,
  ) async {
    Map<String, dynamic> WorkFlow = {
      "Workflow": workflow,
      "RecordId": RecordId,
      "Action": action,
      "Comment": Comment.text
    };

    // const url =
    //     "https://rshrmsapapi.redsecure.online/api/HRMSWEBAPI/Setworkflow";

    // final response = await http.post(Uri.parse(url),
    //     headers: {"Content-Type": "application/json"},
    //     body: jsonEncode(WorkFlow));
    final box = GetStorage();
    try {
      final code = box.read('AppCode');
      final url =
          'https://rshrmsapapi.redsecure.online/api/HRMSWEBAPI/Setworkflow?authcode=$code';

      final response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(WorkFlow));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setworkResponse.isError = data["isError"];
        setworkResponse.errorMsg = data["errorMsg"];
        final result = setworkResponse.result = data["result"];
        print(result);
        setworkflowApprover.result = result;

        print(setworkflowApprover.result);

        if (setworkResponse.isError == false) {
          print("Workflow Set Successfully");
          approvaldetailscontroller.GetApprovaldetails();
        } else {
          print("Error: ${response.statusCode}");
        }
      }
    } catch (ex) {
      print(ex.toString());
    }
  }
}
