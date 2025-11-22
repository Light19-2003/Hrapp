import 'dart:convert';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:hrapp/Model/DayCalmodel.dart';
import 'package:hrapp/Model/Leaveupdatedmodel.dart';
import 'package:hrapp/controller/LoginController.dart';

class Updatedleavecontroller extends GetxController {
  TextEditingController fromdatecontroller = TextEditingController();
  TextEditingController todatecontroller = TextEditingController();
  TextEditingController WFStatuscontroller = TextEditingController();
  TextEditingController remarkcontroller = TextEditingController();
  TextEditingController Leavesdays = TextEditingController();
  bool? ishalfday = false;
  bool? issubmit = true;
  final SingleValueDropDownController cnt =
      SingleValueDropDownController(); // Use this
  LeaveUpdatedResponse leaveUpdatedResponse = LeaveUpdatedResponse();
  DayCalresponse dayCalresponse = DayCalresponse();
  int? selectedLeaveType;
  int? Leavestype; // Note: This seems unused; consider removing if not needed
  String? startdate;
  String? enddate;
  RxBool isloading = false.obs;

  final logincontrol = Get.put(Logincontroller());

  Future<void> Updatedleave(int? newleaveid) async {
    try {
      isloading.value = true;
      int? empId = logincontrol.box.read("UserId");
      String url =
          "http://rshrmsapapi.redsecure.online/api/HRMSWEBAPI/LeaveUpdated?id=$newleaveid&empid=$empId&authcode=${logincontrol.box.read('AppCode')}";

      Map<String, dynamic> addleave = {
        'EmpID': empId,
        'FromDate': startdate,
        'ToDate': enddate,
        'Remarks': remarkcontroller.text,
        'WFStatus': 'P',
        'LeaveType': selectedLeaveType,
        'leaveDays': Leavesdays.text,
        if (ishalfday != null) 'ishalfday': ishalfday,
        if (issubmit != null) 'isSubmit': issubmit,
      };

      print("Payload: $addleave");

      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(addleave),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        leaveUpdatedResponse.isError = data["isError"];
        leaveUpdatedResponse.errorMsg = data["errorMsg"];
        leaveUpdatedResponse.updatedscucessfully = data["updatedscucessfully"];
      } else {
        throw Exception(
            "API request failed with status: ${response.statusCode}");
      }
    } catch (ex) {
      print("Error updating leave: $ex");
      throw ex;
    } finally {
      isloading.value = false;
    }
  }

  Future<void> Getdayscal() async {
    isloading.value = true;
    try {
      String url = "http://rshrmsapapi.redsecure.online/api/HRMSWEBAPI/Dayscal";

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
    } finally {
      isloading.value = false;
    }
  }

  @override
  void onClose() {
    fromdatecontroller.dispose();
    todatecontroller.dispose();
    WFStatuscontroller.dispose();
    remarkcontroller.dispose();
    Leavesdays.dispose();
    cnt.dispose();
    super.onClose();
  }
}
