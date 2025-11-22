import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hrapp/Model/LoginModel.dart';
import 'package:hrapp/view/navbar.dart';

import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class Logincontroller extends GetxController {
  @override
  void onInit() {
    _requestPermissions();
    _requestmessage();
    // _requestaudoio();
    super.onInit();
  }

  RxBool login = false.obs;

  final box = GetStorage();
  Loginmodel loginmodel = Loginmodel();

  LoginmodelReponse loginmodelReponse = LoginmodelReponse();
  TextEditingController EmailController = TextEditingController();

  TextEditingController PasswordController = TextEditingController();

  UserData userData = UserData();

  Future<void> PostLogin() async {
    // showLoading("Loading.....");

    login.value = true;
    try {
      String url =
          "https://rshrmsapapi.redsecure.online/api/HRMSWEBAPI/Userlogin?authcode=${box.read('AppCode')}";

      Map newuser = {
        'Email_work': EmailController.text,
        'Password': PasswordController.text,
      };
      print(newuser);

      final Response = await http.post(Uri.parse(url),
          body: jsonEncode(
            newuser,
          ),
          headers: {"Content-Type": "application/json"});

      print(Response.body.toString());

      if (Response.statusCode == 200) {
        // login sucess
        login.value = true;
        final extractedData = jsonDecode(Response.body);

        loginmodelReponse.iserror = extractedData["isError"];
        loginmodelReponse.errormsg = extractedData["errorMsg"];

        if (loginmodelReponse.errormsg == null) {
          userData.id = extractedData["userData"]["ID"];

          userData.propic = extractedData["userData"]["profilePic"];
          userData.empName = extractedData["userData"]["EmpName"];
          userData.empCode = extractedData["userData"]["EmpCode"];
          userData.gender = extractedData["userData"]["Gender"];
          userData.department = extractedData["userData"]["Department"];
          userData.designation = extractedData["userData"]["Designation"];
          loginmodelReponse.userData = userData;

          box.write("UserId", userData.id!);

          // final Empid = box.read("UserId");
          Get.snackbar(
            "Login Successful", // Title of the snackbar
            "You have logged in successfully!", // Message of the snackbar
            snackPosition:
                SnackPosition.top, // Position of the snackbar (BOTTOM or TOP)
            backgroundColor: Colors.green, // Background color of the snackbar
            colorText: Colors.white, // Text color
            icon:
                Icon(Icons.check_circle, color: Colors.white), // Optional icon
            duration:
                Duration(seconds: 3), // Duration the snackbar will be displayed
          );

          Get.off(() => Navbar());
        } else {
          if (loginmodelReponse.errormsg != null) {
            Get.snackbar(
                "Failed", loginmodelReponse.errormsg ?? "Invalid credentials",
                backgroundColor: Colors.red, colorText: Colors.white);
          }
        }
      } else if (Response.statusCode == 404) {
        // Not found (wrong URL)
        Get.snackbar("Wrong URL",
            "The requested URL was not found. Please check the URL and try again.",
            backgroundColor: Colors.red, colorText: Colors.white);
      } else if (Response.statusCode == 400) {
        // Bad request
        Get.snackbar("Bad Request",
            "There was a problem with your request. Please try again.",
            backgroundColor: Colors.red, colorText: Colors.white);
      } else if (Response.statusCode == 500) {
        // Server error
        Get.snackbar("Server Error",
            "The server encountered an internal error. Please try again later.",
            backgroundColor: Colors.red, colorText: Colors.white);
      } else if (Response.statusCode == 503) {
        // Service unavailable
        Get.snackbar("Service Unavailable",
            "The server is currently unavailable. Please try again later.",
            backgroundColor: Colors.red, colorText: Colors.white);
      } else if (Response.statusCode == 504) {
        // Gateway timeout
        Get.snackbar("Timeout",
            "The server took too long to respond. Please try again later.",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (ex) {
      print(ex.toString());
      Get.snackbar("Error",
          'Unable to connect to the server. Please check your connection and try again.');
    } finally {
      login.value = false;
    }
  }

  Future<void> _requestPermissions() async {
    // Request location permission
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      print("Permission granted");
      // Do something if permission is granted (e.g., fetch user location)
    } else if (status.isDenied) {
      print("Permission denied");
      // Handle the case where the user denies permission
    } else if (status.isPermanentlyDenied) {
      print("Permission permanently denied. Open settings.");
      // Optionally, open the app settings to allow the user to grant permission
      openAppSettings();
    }
  }
}

Future<void> _requestmessage() async {
  PermissionStatus status = await Permission.notification.request();

  if (status.isGranted) {
    print("Permission granted");
  }

  if (status.isDenied) {
    print("Permission denied");
  } else if (status.isPermanentlyDenied) {
    print("Permission permanently denied. Open settings.");

    openAppSettings();
  }
}

// Future<void> _requestaudoio() async {
//   // Request location permission
//   PermissionStatus status = await Permission.microphone.request();

//   if (status.isGranted) {
//     print("Permission granted");
//     // Do something if permission is granted (e.g., fetch user location)
//   } else if (status.isDenied) {
//     print("Permission denied");
//     // Handle the case where the user denies permission
//   } else if (status.isPermanentlyDenied) {
//     print("Permission permanently denied. Open settings.");
//     // Optionally, open the app settings to allow the user to grant permission
//     openAppSettings();
//   }
// }

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void showLoading(String title) {
  Get.dialog(
    Dialog(
      insetPadding: EdgeInsets.all(15),
      // insetAnimationDuration: Duration(milliseconds: 2000),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: GestureDetector(
        onTap: () {
          Get.backLegacy();
        },
        child: Container(
          padding: const EdgeInsets.all(20.0),
          width: 200,
          child: Column(
            mainAxisSize: MainAxisSize.min, // Adjusts to content size
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator.adaptive(),
              const SizedBox(height: 20),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    ),
    barrierDismissible: false,
  );
}
