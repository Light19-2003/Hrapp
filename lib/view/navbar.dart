import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:hrapp/Themecolor/Palette.dart';
import 'package:hrapp/controller/Local_AuthController.dart';
import 'package:hrapp/controller/Tabcontroller.dart';

import 'package:hrapp/view/pages/Dashboard.dart';
import 'package:hrapp/view/pages/Profile2.dart';

import 'package:hrapp/view/pages/services.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  void initState() {
    super.initState();
    LocalLogin authController = Get.put(LocalLogin());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isauth = authController.box.read("isauth");

      // Show dialog only if fingerprint has not been asked yet
      if (isauth == null) {
        Get.dialog(
          Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.fingerprint, size: 48, color: Colors.blue),
                  const SizedBox(height: 16),
                  const Text(
                    "Do you want to add the Fingerprint?",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          authController.box.write("isauth", false);
                          Get.close();
                        },
                        child: const Text("No"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          authController.box.write("isauth", true);
                          Get.close();
                        },
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }

  Widget build(BuildContext context) {
    List<Widget> pages = [
      // MyHomePage(),
      DashboardPage(),
      ServicesPage(),
      // ProfilePage(),
      Profile2()
    ];
    final indexcontroller = Get.put(Tabcontroller());
    return Obx(() => Scaffold(
          body: Stack(
            children: [
              pages[indexcontroller.tabindex],
              Align(
                alignment: Alignment.bottomCenter,
                child: CurvedNavigationBar(
                    color: Palette.Kmain,

                    // mouseCursor: MouseCursor.uncontrolled,
                    index: indexcontroller.tabindex,
                    onTap: (Value) {
                      indexcontroller.indexchange(Value);
                    },
                    backgroundColor: Colors.transparent,
                    items: [
                      CurvedNavigationBarItem(
                          labelStyle: TextStyle(color: Palette.Kwhite),
                          label: "Home",
                          child: Icon(
                            Icons.home,
                            color: Palette.Kwhite,
                          )),
                      CurvedNavigationBarItem(
                          label: "Service",
                          labelStyle: TextStyle(color: Palette.Kwhite),
                          child: Icon(Icons.menu, color: Palette.Kwhite)),
                      CurvedNavigationBarItem(
                          labelStyle: TextStyle(color: Palette.Kwhite),
                          label: "Profile",
                          child: Icon(Icons.person_2, color: Palette.Kwhite)),
                    ]),
              )
              // Padding(
              //   padding: const EdgeInsets.all(12.0),
              //   child: Align(
              //     alignment: Alignment.bottomCenter,
              //     child: Theme(
              //       data: Theme.of(context).copyWith(
              //         canvasColor: Color(0xFF0A1D48),
              //       ),
              //       child: ClipRRect(
              //         clipBehavior: Clip.antiAlias,
              //         borderRadius: BorderRadius.circular(25),
              //         child: BottomNavigationBar(
              //           showUnselectedLabels: false,
              //           onTap: (val) {
              //             indexcontroller.indexchange(val);
              //           },
              //           currentIndex: indexcontroller.tabindex,

              //           // shape: CircularNotchedRectangle(),
              //           unselectedIconTheme: const IconThemeData(
              //             color: Colors.grey,
              //           ),
              //           selectedIconTheme: IconThemeData(color: Colors.white),
              //           selectedItemColor: Colors.white,
              //           items: const [
              //             BottomNavigationBarItem(
              //                 activeIcon: Icon(Icons.home_filled),
              //                 label: "HOME",
              //                 icon: Icon(Icons.home)),
              //             BottomNavigationBarItem(
              //                 label: "SERVICE",
              //                 activeIcon: Icon(Icons.auto_awesome_sharp),
              //                 icon: Icon(Icons.auto_awesome_sharp)),
              //             BottomNavigationBarItem(
              //                 label: "PROFILE",
              //                 activeIcon: Icon(Icons.person_2),
              //                 icon: Icon(Icons.person_2)),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ));
  }
}
