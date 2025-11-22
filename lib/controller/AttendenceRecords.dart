import 'dart:convert';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrapp/Model/AttendenceRecords.dart';
import 'package:hrapp/controller/LoginController.dart';
import 'package:http/http.dart' as http;

class Attendencerecordscontroller extends GetxController {
  final Logincontroller _logincontroller = Get.put(Logincontroller());

  TextEditingController Mothcon = TextEditingController();

  final SingleValueDropDownController cnt = SingleValueDropDownController();
  int? monthTypeId;
  int? yearid;

  bool showCalender = false;

  RxBool loading = false.obs;

  DateTime selectedDate =
      DateTime.now(); // Selected date for filtering attendance
  var attendence = <AttendanceRecord>[].obs; // Observable attendance list

  Attendencerecordsresponse attendencerecordsresponse =
      Attendencerecordsresponse();

  Future<void> getAttendenceRecords() async {
    loading.value = true;
    try {
      int? empid = _logincontroller.box.read<int?>("UserId");
      final url =
          'https://rshrmsapapi.redsecure.online/api/HRMSWEBAPI/AttendenceRecords?empid=$empid&authcode=${_logincontroller.box.read('AppCode')}';

      Map<String, dynamic> attendenceDetails = {
        'AtnMode': "M",
        'AtnYear': yearid,
        'AtnMonth': monthTypeId!,
      };

      print("Request payload: $attendenceDetails");

      print("Request payload: $attendenceDetails");

      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(attendenceDetails),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        attendence.clear();

        attendencerecordsresponse.iserror = data["isError"];
        attendencerecordsresponse.iserrormsg = data["errorMsg"];

        final attendencelist = data["attendanceRecords"];

        for (var collection in attendencelist) {
          AttendanceRecord attendanceRecord = AttendanceRecord(
            id: collection["ID"],
            atnYear: collection["AtnYear"],
            atnMonth: collection["AtnMonth"],
            atnDate: collection["AtnDate"] != null
                ? DateTime.tryParse(collection["AtnDate"])
                : null,
            atnDay: collection["AtnDay"],
            isWeekendLeave: collection["IsWeekendLeave"],
            weekNumber: collection["WeekNumber"],
            empCode: collection["EmpCode"],
            department: collection["Department"],
            designation: collection["Designation"],
            empName: collection["EmpName"],
            empID: collection["EMPID"],
            startTime: collection["StartTime"] != null
                ? DateTime.tryParse(collection["StartTime"])
                : null,
            empShortName: collection["EmpShortName"],
            attnD: collection["AttnD"],
            sMonth: collection["SMonth"],
            atnDateDay: collection["AtnDateDay"],
            wkOrder: collection["WKOrder"],
          );
          attendence.add(attendanceRecord);
        }

        print(attendence.length);

        print("Attendance data loaded successfully.");
      } else {
        print("Failed to fetch data. Status: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception occurred: ${e.toString()}");
    }
  }
}
