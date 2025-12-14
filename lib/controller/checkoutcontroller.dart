import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:hrapp/Model/Logoutmodel.dart';
import 'package:hrapp/controller/Attendencecontroller.dart';
import 'package:hrapp/controller/LoginController.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

final Logincontroller logincontroller = Get.put(Logincontroller());

Attendencecontroller attendencecontroller = Get.put(Attendencecontroller());

class Checkoutcontroller extends GetxController {
  RxBool isloading = false.obs;

  LogoutReponse logoutReponse = LogoutReponse();
  Future<void> Logout() async {
    isloading.value = true;

    String url =
        "http://rshrmsapapi.redsecure.online/api/HRMSWEBAPI/Signouts?authcode=${logincontroller.box.read('AppCode')}";
    Position currentLatLong = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    DateTime today = DateTime.now();

    // final box = GetStorage();

    DateTime currentDateTime = DateTime.now();
    int empid = logincontroller.box.read("UserId");
    final  id = attendencecontroller.box.read('Id');

    // To display only the time in "hh:mm a" format (e.g., "08:30 PM")
    String timeOnly = DateFormat('hh:mm a').format(DateTime.now());

    print(id);
    Map<String, dynamic> attendence = {
      'empId': empid,
      'id': id,
      // 'loginTime': "${DateFormat('dd MMM yyyy').format(today)} 08:00:00",
      'logoutTime': timeOnly,
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
        print("somethingthen wrong");
      }
    }
    isloading.value = false;
  }
}
