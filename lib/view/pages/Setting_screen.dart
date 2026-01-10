import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hrapp/Login/NewLoginScreen.dart';
import 'package:hrapp/controller/UserDeletecontoller.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final box = GetStorage();

  @override
  UserDeleteController userdeletecontoller = Get.put(UserDeleteController());
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),

          // ===== DANGER ZONE =====
          ListTile(
            leading: const Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
            title: const Text(
              "Delete Account",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: const Text(
              "This action is permanent",
              style: TextStyle(color: Colors.grey),
            ),
            onTap: _confirmDelete,
          ),
        ],
      ),
    );
  }

  void _confirmDelete() {
    Get.defaultDialog(
      title: "Delete Account",
      middleText: "Are you sure? This action cannot be undone.",
      textCancel: "Cancel",
      textConfirm: "Delete",
      confirmTextColor: Colors.white,
      onConfirm: () async {
        // ✅ close dialog first

        try {
          // 🔥 wait for API
          await userdeletecontoller.deleteUser();

         
        } catch (e) {
          Get.snackbar(
            "Delete Failed",
            "Something went wrong. Please try again.",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      },
    );
  }
}
