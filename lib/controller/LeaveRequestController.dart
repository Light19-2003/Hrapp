import 'dart:convert';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:hrapp/Model/DayCalmodel.dart';
import 'package:hrapp/Model/LeaveRequestModel.dart';
import 'package:hrapp/controller/LoginController.dart';

class Leaverequestcontroller extends GetxController {
  final logincon = Get.put(Logincontroller());

  GetStorage box = GetStorage();

  // Controllers
  TextEditingController fromdatecontroller = TextEditingController();
  TextEditingController todatecontroller = TextEditingController();
  TextEditingController WFStatuscontroller = TextEditingController();
  TextEditingController remarkcontroller = TextEditingController();
  TextEditingController Leavesdays = TextEditingController();

  int? Leavestype;

  RxBool isloading = false.obs;
  String? startdate;
  String? enddate;
  final SingleValueDropDownController cnt = SingleValueDropDownController();

  // Models and Variables
  DayCalresponse dayCalresponse = DayCalresponse();
  LeaverequestResponson leaverequestResponson = LeaverequestResponson();
  bool? ishalfday;
  bool? issubmit;

  // Leave Request API
  Future<void> Postleaverequest(Leaverequestmodel leaverequest) async {
    try {
      String url =
          "http://rshrmsapapi.redsecure.online/api/HRMSWEBAPI/ADDLeavesrequest?authcode=${logincon.box.read('AppCode')}";

      Map<String, dynamic> addleave = {
        'EmpID': logincon.box.read("UserId"),
        'FromDate': startdate,
        'ToDate': enddate,
        'Remarks': remarkcontroller.text,
        'WFStatus': 'P',
        'LeaveType': Leavestype!,
        'leaveDays': Leavesdays.text,
        if (ishalfday != null) 'ishalfday': ishalfday,
        if (issubmit != null) 'issubmit': issubmit,
      };

      print(addleave);

      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(addleave),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        leaverequestResponson.iserror = data["isError"];
        leaverequestResponson.errormsg = data["errorMsg"];
        leaverequestResponson.dataadded = data["DataAdded"];
        leaverequestResponson.id = data['ID'];

        box.write('leaveId', leaverequestResponson.id);

        if (leaverequestResponson.dataadded == true) {
          print("Data successfully added.");
        } else {
          print("Something went wrong: ${leaverequestResponson.errormsg}");
        }
      } else {
        print("Failed to send request: ${response.statusCode}");
      }
    } catch (ex) {
      print("Error in Postleaverequest: $ex");
    }
  }

  // Get Days Calculation API
  Future<void> Getdayscal() async {
    isloading.value = true;
    try {
      String url =
          "http://rshrmsapapi.redsecure.online/api/HRMSWEBAPI/Dayscal?authcode=${logincon.box.read('AppCode')}";

      Map<String, dynamic> dayscal = {
        'FromDate': startdate,
        'ToDate': enddate,
      };

      print(dayscal);

      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(dayscal),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        dayCalresponse.iserror = data["isError"];
        dayCalresponse.errormasg = data["errorMsg"];
        dayCalresponse.dayscalculate = data["Dayscalculate"];

        Leavesdays.text = dayCalresponse.dayscalculate.toString();

        print(Leavesdays.text);
        print("Days calculated: ${dayCalresponse.dayscalculate}");
      } else {
        print("Failed to get days: ${response.statusCode}");
      }
    } catch (ex) {
      print("Error in Getdayscal: $ex");
    }

    isloading.value = false;
  }
}
