import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX correctly
import 'package:hrapp/controller/Tabcontroller.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Drawer(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: [
            SizedBox(height: 50),
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.logout_rounded)),
                Text(
                  "Logout",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.bottomSheet(
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.blue,
                        padding: EdgeInsets.all(
                            16.0), // Add padding for better spacing
                        child: Column(
                          mainAxisSize: MainAxisSize
                              .min, // Ensure it takes only necessary height
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Old Password',
                                fillColor: Colors.white,
                                filled: true,
                              ),
                              obscureText: true, // Hide the password input
                            ),
                            SizedBox(height: 10), // Space between fields
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'New Password',
                                fillColor: Colors.white,
                                filled: true,
                              ),
                              obscureText: true, // Hide the password input
                            ),
                            SizedBox(height: 10), // Space between fields
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Confirm New Password',
                                fillColor: Colors.white,
                                filled: true,
                              ),
                              obscureText: true, // Hide the password input
                            ),
                            SizedBox(height: 20), // Space before button

                            TextButton(
                                onPressed: () {
                                  Get.snackbar(
                                    'SUCCESS',
                                    "Password successfully changed",
                                    backgroundColor: Colors.green,
                                    colorText: Colors.white,
                                  );
                                },
                                child: Text("test"))
                          ],
                        ),
                      ),
                      isDismissible: true, // Allows dismissing the bottom sheet
                      enableDrag: true, // Allows dragging to dismiss
                    );
                  },
                  icon: Icon(Icons.password),
                ),
                Text(
                  "Password Change",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Get.changeTheme(ThemeData.dark());
              },
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.dark_mode),
                  ),
                  Text(
                    "Dark Mode",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.changeTheme(ThemeData.light());
                  },
                  icon: Icon(Icons.light_mode),
                ),
                Text(
                  "Light Mode",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
