import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hrapp/Model/AttendenceModel.dart';
import 'package:hrapp/Model/Attendencedetails.dart';
import 'package:hrapp/Model/Logoutmodel.dart';
import 'package:hrapp/controller/LoginController.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

final Logincontroller logincontroller = Get.put(Logincontroller());

class Attendencecontroller extends GetxController {
  bool mark = true;
  final box = GetStorage();

  LogoutReponse logoutReponse = LogoutReponse();
  AttendenceRes attendenceReponse = AttendenceRes();

  RxBool loading = false.obs;

  Future<void> GetMarkAttendence() async {
    loading.value = true;
    DateTime today = DateTime.now();

    String? lastMarkedDateStr = box.read('lastMarkedDate');
    if (lastMarkedDateStr == null ||
        DateTime.parse(lastMarkedDateStr).day != today.day) {
      mark = true;
    }

    if (mark) {
      try {
        Position currentLatLong = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        int empid = logincontroller.box.read("UserId");
        String url =
            "http://rshrmsapapi.redsecure.online/api/HRMSWEBAPI/Attendance?authcode=${logincontroller.box.read('AppCode')}";

        // Use ISO datetime format (SQL-friendly)
        final loginDateTime =
            DateTime(today.year, today.month, today.day, 8, 0);
        final logoutDateTime =
            DateTime(today.year, today.month, today.day, 16, 0);

        final loginTime = loginDateTime.toIso8601String();
        final logoutTime = logoutDateTime.toIso8601String();

        print("Sending loginTime: $loginTime");
        print("Sending logoutTime: $logoutTime");
        DateTime now = DateTime.now();
        String sqlDateTime = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);
        print(now);

        Map<String, dynamic> attendence = {
          'empId': empid,
          'loginTime': sqlDateTime,
          'logoutTime': logoutTime,
          'chkinlat': "${currentLatLong.latitude}",
          'chkinlong': "${currentLatLong.longitude}",
        };
        print(attendence);

        final response = await http.post(Uri.parse(url),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(attendence));

        if (response.statusCode == 200) {
          final extractedData = jsonDecode(response.body);

          // attendenceReponse.id = extractedData["id"];
          attendenceReponse.errorMsg = extractedData["errorMsg"];

          if (attendenceReponse.errorMsg == null) {
            // box.write("Id", attendenceReponse.id);
          }

          box.write('lastMarkedDate', today.toIso8601String());
          mark = false;

          // Get.snackbar("Attendance", "Attendance marked successfully!",
          //     snackPosition: SnackPosition.top,
          //     backgroundColor: Colors.green,
          //     colorText: Colors.white);
        }
        loading.value = false;
      } catch (ex) {
        print("Error: ${ex.toString()}");
        loading.value = false;
      }
    } else {
      // Get.snackbar("Attendance", "Already marked attendance!",
      //     snackPosition: SnackPosition.top,
      //     backgroundColor: Colors.red,
      //     colorText: Colors.white);
      loading.value = false;
    }
  }

  Future<void> Logout() async {
    String url =
        "https://hrms-api.rs-apps.online/api/HRMSWEBAPI/Signouts?authcode=${logincontroller.box.read('AppCode')}";
    Position currentLatLong = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    DateTime today = DateTime.now();

    int empid = logincontroller.box.read("UserId");
    int? id = box.read('Id');

    Map<String, dynamic> attendence = {
      'empId': empid,
      'id': id,
      'logoutTime': today.toIso8601String(),
      'chkinlat': "${currentLatLong.latitude}",
      'chkinlong': "${currentLatLong.longitude}",
    };

    print(attendence);

    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(attendence));

    if (response.statusCode == 200) {
      final extractedData = jsonDecode(response.body);

      logoutReponse.isError = extractedData["isError"];
      logoutReponse.errorMsg = extractedData["errorMsg"];
      logoutReponse.attendancemark = extractedData["Attendancemark"];

      if (logoutReponse.attendancemark == true) {
        Get.snackbar(
          "Session",
          "Logged out successfully!",
          snackPosition: SnackPosition.top,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        print("Something went wrong");
      }
    } 
  }
}
