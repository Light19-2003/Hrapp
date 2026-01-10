import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hrapp/Login/NewLoginScreen.dart';
import 'package:hrapp/controller/LoginController.dart';
import 'package:hrapp/view/pages/Setting_screen.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});

  final controller = Get.put(Logincontroller());

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // ===== HEADER =====
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            accountName: Text(""),
            accountEmail: Text(""),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40),
            ),
          ),

          // ===== SETTINGS =====
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () {
              Get.to(() => SettingsPage());
              Get.snackbar("Settings", "Open settings page");
              // Get.to(() => SettingsPage());
            },
          ),

          // ===== ABOUT =====
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About"),
            onTap: () {
              Get.back();
              Get.snackbar("About", "App version 1.0.0");
              // Get.to(() => AboutPage());
            },
          ),

          // ===== LOGOUT =====
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              controller.box.remove("UserId");

              controller.box.remove("isauth");

              Get.off(() => Newloginscreen());
            },
          ),
        ],
      ),
    );
  }
}
