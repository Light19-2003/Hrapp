import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrapp/Login/NewLoginScreen.dart';
import 'package:hrapp/Widget/Profilewid.dart';
import 'package:hrapp/common/drawer.dart';

import 'package:hrapp/controller/LoginController.dart';

class Profile2 extends StatelessWidget {
  const Profile2({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Logincontroller());
    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // ✅ works
              },
            ),
          ),

          // backgroundColor: Colors.grey[100],
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         controller.box.remove("UserId");

          //         controller.box.remove("isauth");

          //         Get.off(() => Newloginscreen());
          //       },
          //       icon: Icon(
          //         Icons.logout_outlined,
          //         size: 25,
          //       ))
          // ],
          title: Text("Your Profile"),
          centerTitle: true,
        ),
        drawer: AppDrawer(),
        body: Profilewid());
  }
}
