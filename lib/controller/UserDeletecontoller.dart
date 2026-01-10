import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hrapp/Login/NewLoginScreen.dart';
import 'package:http/http.dart' as http;

class UserDeleteController extends GetxController {
  final isLoading = false.obs; // optional for loading state
  final box = GetStorage();

  Future<bool> deleteUser() async {
    isLoading.value = true;

    try {
      final empId = box.read('UserId');
      final authCode = box.read('AppCode');
      final url =
          "https://rshrmsapapi.redsecure.online/api/HRMSWEBAPI/UserDelete?empid=$empId&authcode=$authCode";

      final res = await http.post(Uri.parse(url));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final isDelete = data['IsDelete'] ?? false;

        if (isDelete) {
          Get.snackbar('Success', 'User deleted successfully',
              backgroundColor: Colors.green, colorText: Colors.white);
          final box = GetStorage();
          box.remove("UserId");
          box.remove("isauth");

          Get.offAll(() => Newloginscreen());
          return true;
        } else {
          Get.snackbar('Failed', 'Could not delete user',
              backgroundColor: Colors.red, colorText: Colors.white);
          return false;
        }
      } else {
        Get.snackbar('Error', 'Server error: ${res.statusCode}',
            backgroundColor: Colors.red, colorText: Colors.white);
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
