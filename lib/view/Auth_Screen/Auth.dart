import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:hrapp/controller/Local_AuthController.dart';
import 'package:hrapp/view/navbar.dart';
import 'package:lottie/lottie.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LocalLogin localLogin = Get.put(LocalLogin());
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                padding: EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, 4),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Fingerprint animation
                    Lottie.asset(
                      "assets/lottie/Animation - 1747201510561.json",
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),

                    SizedBox(height: 20),

                    Text(
                      "Scan Your Fingerprint",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Place your finger on the sensor to proceed",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),

                    SizedBox(height: 30),

                    GestureDetector(
                      onTap: () async {
                        final bool isSuccess = await localLogin.localAuth();
                        if (isSuccess) {
                          Get.off(() => Navbar());
                        } else {
                          Get.snackbar("Error", "Authentication failed",
                              snackPosition: SnackPosition.bottom);
                        }
                      },
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.blueAccent,
                        child: Icon(
                          Icons.fingerprint,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
