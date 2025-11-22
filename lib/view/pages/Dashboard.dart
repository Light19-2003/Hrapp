import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hrapp/controller/ApprovalDetailsController.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:hrapp/Themecolor/Palette.dart';
import 'package:hrapp/bulider/actvities.dart';
import 'package:hrapp/bulider/brithdaywid.dart';

import 'package:hrapp/controller/Attendencecontroller.dart';
import 'package:hrapp/controller/DashboardController.dart';
import 'package:hrapp/controller/LocationController.dart';

import 'package:hrapp/controller/Profilecontroller.dart';
import 'package:hrapp/controller/checkoutcontroller.dart';
import 'package:hrapp/view/notifications/notificationsScreen.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    Approvaldetailscontroller approvaldetailscontroller =
        Get.put(Approvaldetailscontroller());

    approvaldetailscontroller.GetApprovaldetails();
    Profilecontroller profilecontroller = Get.put(Profilecontroller());

    // final Login = Get.put(Logincontroller());
    // final profile = Get.put(Profilecontroller());

    final controller = Get.put(Dashboardcontroller());

    // int? count = approvaldetailscontroller.approvalerlist.length;

    // final profile = Get.put(Profilecontroller());

    controller.getdashboardDetails();

    // final pos = locationController.currentPosition.value;
    // final LatLng officeLatLng = LatLng(
    //   locationController.officeLat,
    //   locationController.officeLng,
    // );
    // final LatLng initialTarget = pos != null
    //     ? LatLng(pos.latitude, pos.longitude)
    //     : officeLatLng; // Default to office if position is null

    Attendencecontroller attendencecontroller = Get.put(Attendencecontroller());

    Checkoutcontroller checkoutcontroller = Get.put(Checkoutcontroller());

    // String signIn = controller.getTime.signin ?? "2024-11-21T09:00:00";
    // String signOut = controller.getTime.signout ?? "2024-11-21T18:00:00";

    // DateTime signInTime = DateTime.parse(signIn);

    // print(signInTime);
    // DateTime signOutTime = DateTime.parse(signOut);

    // Duration duration = signOutTime.difference(signInTime);
    // print('Duration: ${duration.inHours} hours');

    // String? signin = controller.getTime.signin;

    // // Removed the '!' because the string could be null

    // print(signin);
    // Duration? difference1;

    // print(difference1);

    // if (signin != null) {
    //   DateFormat format = DateFormat(
    //       "hh:mm a"); // 'hh:mm a' is for the 12-hour format with AM/PM
    //   DateTime startTime = format.parse(signin);

    //   print("  starttime  $startTime");

    //   // Parse the time string into DateTime
    //   // DateTime startTime = DateTime.parse(signin);
    //   DateTime currentTime = DateTime.now();

    //   print('$currentTime');

    //   // Calculate the difference as a Duration
    //   Duration difference = currentTime.difference(startTime);

    //   print("$difference");

    //   difference1 = difference;

    //   print("$difference1");

    //   // Print the difference in hours, minutes, and seconds
    //   print(
    //       'Difference: ${difference.inHours} hours, ${difference.inMinutes % 60} minutes, ${difference.inSeconds % 60} seconds');
    // } else {
    //   print('Sign-in time is null');
    // }

    // Duration? output1;

    // print("$output1");

    // String? ckeckin = controller.getTime.signin;

    // print("$ckeckin");

    // String? ckeckout = controller.getTime.signout;

    // print("$ckeckout");

    // if (ckeckin != null && ckeckout != null) {
    //   DateFormat format = DateFormat("hh:mm a");

    //   DateTime startTime = format.parse(ckeckin); // Parse checkin time

    //   print("$startTime");
    //   DateTime endTime = format.parse(ckeckout); // Parse checkout time
    //   print("$endTime ");

    //   Duration difference =
    //       endTime.difference(startTime); // Calculate the difference

    //   print("$difference ");

    //   // Store the difference
    //   output1 = difference;

    //   print("$output1 ");
    // } else {
    //   print('both are empty');
    // }

    // Obx(() {
    //   // Calculate hours, minutes, and seconds from Rx<int>
    //   int hours = controller.differenceInSeconds.value ~/ 3600;
    //   int minutes = (controller.differenceInSeconds.value % 3600) ~/ 60;
    //   int seconds = controller.differenceInSeconds.value % 60;

    //   // Display the time difference
    //   return Text(
    //     '$hours hours, $minutes minutes, $seconds seconds',
    //     style: TextStyle(fontSize: 24),
    //   );
    // });

    // DateTime today = DateTime.now();

    // DateTime timer = StartTime - today.hour;

    // DateTime? checkInTime; // To store the check-in time
    // Timer? timer; // Timer to update the elapsed time
    // Duration elapsedTime = Duration.zero; // To track elapsed time

    // void startTimer(String signinTimeStr) {
    //   // Parse the signin string into a DateTime object
    //   checkInTime = DateTime.parse(signinTimeStr);

    //   // Cancel any existing timer
    //   timer?.cancel();

    //   // Start a new timer
    //   timer = Timer.periodic(Duration(seconds: 1), (_) {
    //     setState(() {
    //       elapsedTime = DateTime.now().difference(checkInTime!);
    //     });
    //   });
    // }

    // String getFormattedElapsedTime() {
    //   final hours = elapsedTime.inHours.toString().padLeft(2, '0');
    //   final minutes = (elapsedTime.inMinutes % 60).toString().padLeft(2, '0');
    //   final seconds = (elapsedTime.inSeconds % 60).toString().padLeft(2, '0');
    //   return "$hours:$minutes:$seconds";
    // }

    String formattedDate = DateFormat('dd MMM, yyyy').format(DateTime.now());

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: Obx(() {
            if (controller.isloading.value)
              return Column(
                children: List.generate(10, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Shimmer.fromColors(
                      direction: ShimmerDirection.ttb,
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  );
                }),
              );

            return Column(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Palette.Kmain,
                          Palette.Kmain,
                          Palette.Ksecondary,
                        ],
                        stops: [0.0, 0.8, 1.0], // ✅ Correct stops
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.only(top: 10),
                          child: controller.isloading.value
                              ? Column(
                                  children: List.generate(10, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          height: 100,
                                          width: double.infinity,
                                          color: Colors.white,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                        ),
                                      ),
                                    );
                                  }),
                                )
                              : Column(children: [
                                  ListTile(
                                    title: profilecontroller.isLoading.value
                                        ? Center(
                                            child: CircularProgressIndicator
                                                .adaptive(),
                                          )
                                        : Text(
                                            "${profilecontroller.profilemodel.empname!.contains(' ') ? profilecontroller.profilemodel.empname!.split(' ').take(2).join(' ') : profilecontroller.profilemodel.empname}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                    subtitle: profilecontroller.isLoading.value
                                        ? Center(
                                            child: CircularProgressIndicator
                                                .adaptive(),
                                          )
                                        : Text(
                                            "${profilecontroller.profilemodel.designation}",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                              fontFamily: 'Poppins-Medium',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.grey,
                                      radius: 30,
                                      child: profilecontroller.isLoading.value
                                          ? Center(
                                              child: CircularProgressIndicator
                                                  .adaptive(),
                                            )
                                          : CircleAvatar(
                                              radius:
                                                  28, // Make it slightly smaller to create a border effect
                                              backgroundImage: NetworkImage(
                                                  "https://rshrms.rs-apps.online/EmployeeDocument/${profilecontroller.profilemodel.userimage}")

                                              //  profilecontroller
                                              //                 .imageBytes !=
                                              //             null &&
                                              //         profilecontroller
                                              //             .imageBytes!
                                              //             .isNotEmpty
                                              //     ? MemoryImage(
                                              //         profilecontroller
                                              //             .imageBytes!)
                                              //     : AssetImage(
                                              //         "assets/images.png") // Use MemoryImage with imageBytes
                                              ),
                                    ),
                                    trailing: Badge(
                                      label: Obx(
                                        () => Text(
                                            "${approvaldetailscontroller.count!.value}"),
                                      ),
                                      child: InkWell(
                                          onTap: () {
                                            Get.to(() => NotificationsScreen());
                                          },
                                          child: Icon(
                                            Icons.notifications,
                                            color: Palette.Kwhite,
                                            size: 40.w,
                                          )),
                                    ),
                                  ),
                                ]),
                        ),
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(35),
                                topRight: Radius.circular(35),
                              ),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  //  height: 200,
                                  width: 300,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(formattedDate,
                                              style: TextStyle(
                                                color: Colors.black,
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 30,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10)),

                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                if (controller.getTime.signin ==
                                                        null &&
                                                    controller
                                                            .getTime.signout ==
                                                        null)
                                                  SizedBox.shrink()
                                                else if (controller
                                                        .getTime.signout ==
                                                    null)
                                                  Lottie.asset(
                                                      "assets/lottie/Animation - 1732192021112.json")
                                                else
                                                  Container(
                                                    width: 20,
                                                    height: 20,
                                                    child: Image.asset(
                                                      "assets/images/timer.webp",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),

                                                // controller.getTime.signout !=
                                                //             null &&
                                                //         controller.getTime
                                                //                 .signout ==
                                                //             null
                                                //     ? Lottie.asset(
                                                //         "assets/lottie/Animation - 1732192021112.json")
                                                //     : Container(
                                                //         width: 10,
                                                //         height: 20,
                                                //         child: Image.asset(
                                                //           "assets/images/timer.webp",
                                                //           fit: BoxFit.contain,
                                                //         ),
                                                //       ),
                                                if (controller.getTime.signin ==
                                                        null &&
                                                    controller
                                                            .getTime.signout ==
                                                        null)
                                                  Text("--:--")
                                                else if (controller
                                                        .getTime.signout ==
                                                    null)
                                                  Obx(() {
                                                    // Calculate hours, minutes, and seconds from Rx<int>
                                                    int totalSeconds =
                                                        controller
                                                            .differenceInSeconds
                                                            .value;

                                                    int hours =
                                                        totalSeconds ~/ 3600;
                                                    int minutes =
                                                        (totalSeconds % 3600) ~/
                                                            60;
                                                    int seconds =
                                                        totalSeconds % 60;

                                                    // Display the time difference
                                                    return Text(
                                                      ' $hours:$minutes:$seconds ',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Palette.Kmain,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    );
                                                  })
                                                else
                                                  Text(
                                                    "${controller.outputSeconds.value}:${controller.outputmin.value}  ",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Palette.Kmain,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                              ],
                                            ),
                                            // child: Center(
                                            //     // child: Text(
                                            //     //   // controller.getTime.signout ==
                                            //     //   //             null &&
                                            //     //   //         controller.getTime
                                            //     //   //                 .signin ==
                                            //     //   //             null
                                            //     //   //     ? "--:--"
                                            //     //   //     : output.toString(),
                                            //     //   timeOfDay.minute.toString(),
                                            //     //   style: TextStyle(
                                            //     //       color: Colors.black),
                                            //     // ),
                                            //     )
                                          ),
                                        ],
                                      ),
                                      Divider(),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "Start time",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          Text(
                                            "End time",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 21),
                                            child: controller.getTime.signin ==
                                                    null
                                                ? Text(
                                                    "--:--",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )
                                                : Text(
                                                    "${controller.dashboardmodel.getime!.signin}",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: controller.getTime.signout ==
                                                    null
                                                ? Text(
                                                    "--:--",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )
                                                : Text(
                                                    "${controller.dashboardmodel.getime!.signout}",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      controller.getTime.signin != null &&
                                              controller.getTime.signout != null
                                          ? Center(
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Text(
                                                  "Checked out! Your session has ended.",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10),
                                                ),
                                              ),
                                            )
                                          : Obx(() {
                                              if (attendencecontroller
                                                  .loading.value) {
                                                return CircularProgressIndicator
                                                    .adaptive(
                                                  backgroundColor: Colors.white,
                                                ); // Show loader if loading
                                              } else {
                                                // If attendance is not marked (markatt is false)
                                                if (controller.dashboardmodel
                                                        .markatt ==
                                                    false) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      // Check if attendance is already marked
                                                      if (controller
                                                              .dashboardmodel
                                                              .markatt ==
                                                          false) {
                                                        // Get.dialog(Container(
                                                        //   width: MediaQuery.of(
                                                        //           context)
                                                        //       .size
                                                        //       .width,
                                                        //   decoration:
                                                        //       BoxDecoration(
                                                        //           color: Colors
                                                        //               .white),
                                                        //   child: Stack(
                                                        //     children: [
                                                        //       Positioned.fill(
                                                        //         child: Obx(() => locationController
                                                        //                 .isLoading
                                                        //                 .value
                                                        //             ? Center(
                                                        //                 child:
                                                        //                     CircularProgressIndicator())
                                                        //             : GoogleMap(
                                                        //                 initialCameraPosition:
                                                        //                     CameraPosition(
                                                        //                   target:
                                                        //                       initialTarget,
                                                        //                   zoom:
                                                        //                       15,
                                                        //                 ),
                                                        //                 markers:
                                                        //                     locationController.markers,
                                                        //                 polygons:
                                                        //                     locationController.polygons,
                                                        //               )),
                                                        //       ),
                                                        //       Positioned(
                                                        //           bottom: 20.h,
                                                        //           left: 20.w,
                                                        //           right: 20.w,
                                                        //           child:
                                                        //               GestureDetector(
                                                        //             onTap: locationController
                                                        //                     .isHome
                                                        //                     .value
                                                        //                 ? () async {
                                                        //                     try {
                                                        //                       await attendencecontroller.GetMarkAttendence().then((_) {
                                                        //                         // After marking attendance, update the screen
                                                        //                         setState(() {}); // Refresh the widget after marking attendance
                                                        //                       });
                                                        //                       ;
                                                        //                       Get.snackbar(
                                                        //                         "Success",
                                                        //                         "Attendance marked successfully!",
                                                        //                         backgroundColor: Colors.green,
                                                        //                         colorText: Colors.white,
                                                        //                         snackPosition: SnackPosition.top,
                                                        //                         margin: EdgeInsets.all(10.w),
                                                        //                         borderRadius: 8,
                                                        //                       );
                                                        //                       Get.back(); // Close the dialog
                                                        //                       Get.backLegacy();
                                                        //                     } catch (e) {
                                                        //                       Get.snackbar(
                                                        //                         "Error",
                                                        //                         "Failed to mark attendance: $e",
                                                        //                         backgroundColor: Colors.red,
                                                        //                         colorText: Colors.white,
                                                        //                         snackPosition: SnackPosition.top,
                                                        //                         margin: EdgeInsets.all(10.w),
                                                        //                         borderRadius: 8,
                                                        //                       );
                                                        //                       Get.close();
                                                        //                       Get.back(); // Close the dialog
                                                        //                       Get.backLegacy();
                                                        //                     }
                                                        //                   }
                                                        //                 : () {
                                                        //                     Get.snackbar(
                                                        //                       "Denied",
                                                        //                       "You must be inside the office area to check in.",
                                                        //                       backgroundColor: Colors.red,
                                                        //                       colorText: Colors.white,
                                                        //                       snackPosition: SnackPosition.top,
                                                        //                       margin: EdgeInsets.all(10.w),
                                                        //                       borderRadius: 8,
                                                        //                     );
                                                        //                     Get.back(); // Close the dialog
                                                        //                   },
                                                        //             child:
                                                        //                 Container(
                                                        //               height:
                                                        //                   150.h,
                                                        //               width:
                                                        //                   150.w,
                                                        //               decoration:
                                                        //                   BoxDecoration(
                                                        //                 color: locationController.isHome.value
                                                        //                     ? Palette.Kmain
                                                        //                     : Colors.grey,
                                                        //                 shape: BoxShape
                                                        //                     .circle,
                                                        //                 boxShadow: [
                                                        //                   BoxShadow(
                                                        //                     color:
                                                        //                         Palette.Kmain,
                                                        //                     blurRadius:
                                                        //                         10,
                                                        //                     spreadRadius:
                                                        //                         3,
                                                        //                   ),
                                                        //                 ],
                                                        //               ),
                                                        //               child:
                                                        //                   Column(
                                                        //                 mainAxisAlignment:
                                                        //                     MainAxisAlignment.center,
                                                        //                 children: [
                                                        //                   Icon(
                                                        //                       Icons.fingerprint,
                                                        //                       size: 50.sp,
                                                        //                       color: Colors.white),
                                                        //                   SizedBox(
                                                        //                       height: 8.h),
                                                        //                   Text(
                                                        //                     "CHECK IN",
                                                        //                     style:
                                                        //                         TextStyle(
                                                        //                       fontSize: 16.sp,
                                                        //                       fontWeight: FontWeight.bold,
                                                        //                       color: Colors.white,
                                                        //                     ),
                                                        //                   ),
                                                        //                 ],
                                                        //               ),
                                                        //             ),
                                                        //           ))
                                                        //     ],
                                                        //   ),
                                                        // ));
                                                        attendencecontroller
                                                                .GetMarkAttendence()
                                                            .then((_) {
                                                          // After marking attendance, update the screen
                                                          setState(
                                                              () {}); // Refresh the widget after marking attendance
                                                        });
                                                      } else {
                                                        Get.snackbar(
                                                          "Attendance",
                                                          "Already marked attendance!",
                                                          snackPosition:
                                                              SnackPosition.top,
                                                          backgroundColor:
                                                              Colors.red,
                                                          colorText:
                                                              Colors.white,
                                                        );
                                                      }
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.3),
                                                            spreadRadius: 5,
                                                            blurRadius: 7,
                                                            offset:
                                                                Offset(0, 3),
                                                          ),
                                                        ],
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: Palette.Kmain,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Clock IN",
                                                          style: TextStyle(
                                                              color: Palette
                                                                  .Kwhite,
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  // If attendance is already marked, show "Clock Out" and the logout dialog
                                                  return GestureDetector(
                                                    onTap: () {
                                                      // Show the logout confirmation dialog

                                                      Get.defaultDialog(
                                                        title: "Logout",
                                                        middleText:
                                                            "Are you sure you want to logout?",
                                                        confirm:
                                                            checkoutcontroller
                                                                    .isloading
                                                                    .value
                                                                ? Center(
                                                                    child: CircularProgressIndicator
                                                                        .adaptive(),
                                                                  )
                                                                : ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Get.snackbar(
                                                                        "Processing Checkout", // Title
                                                                        "Please wait...", // Message
                                                                        icon: Icon(
                                                                            Icons
                                                                                .check_circle,
                                                                            color:
                                                                                Colors.white), // Success icon
                                                                        snackPosition:
                                                                            SnackPosition.top, // Display position
                                                                        backgroundColor:
                                                                            Colors.green, // Green indicates success
                                                                        colorText:
                                                                            Colors.white, // Text color for better contrast
                                                                        borderRadius:
                                                                            8, // Rounded corners
                                                                        margin:
                                                                            EdgeInsets.all(10), // Padding around the snackbar
                                                                        duration:
                                                                            Duration(seconds: 3), // Visibility duration
                                                                      );

                                                                      checkoutcontroller
                                                                              .Logout()
                                                                          .then(
                                                                              (_) {
                                                                        // Refresh after logout if needed
                                                                        setState(
                                                                            () {});
                                                                      });
                                                                      // : Get.snackbar(
                                                                      //     "Session",
                                                                      //     "You are already logged out!",
                                                                      //     snackPosition:
                                                                      //         SnackPosition
                                                                      //             .top,
                                                                      //     backgroundColor:
                                                                      //         Colors
                                                                      //             .red,
                                                                      //     colorText:
                                                                      //         Colors
                                                                      //             .white,
                                                                      //   );

                                                                      Get.backLegacy();

                                                                      Get.back(); // Close the dialog
                                                                    },
                                                                    child: Text(
                                                                        "Yes"),
                                                                  ),
                                                        cancel: TextButton(
                                                          onPressed: () {
                                                            Get.back(); // Close the dialog

                                                            Get.backLegacy();
                                                          },
                                                          child: Text("No"),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.3),
                                                            spreadRadius: 5,
                                                            blurRadius: 7,
                                                            offset:
                                                                Offset(0, 3),
                                                          ),
                                                        ],
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: Colors.white,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "Clock Out",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              }
                                            }),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Divider(
                                  endIndent: 22,
                                  indent: 22,
                                ),
                                controller.brithdayslist.isEmpty
                                    ? SizedBox.shrink()
                                    : Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start, // Align to the left

                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0,
                                                  top: 10.0,
                                                  right:
                                                      10.0), // Reduced padding
                                              child: Text(
                                                "Wish Them",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 22,
                                                  fontFamily: 'Poppins-Medium',
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 0.7,
                                                ),
                                              ),
                                            ),
                                          ),

                                          // Underline with reduced spacing
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0,
                                                top: 4.0,
                                                bottom:
                                                    8.0), // Reduced top padding
                                            child: Container(
                                              height:
                                                  1.5, // Slightly thicker line
                                              width: 120,
                                              color: Palette.Ksecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                controller.brithdayslist.isEmpty
                                    ? SizedBox.shrink()
                                    : SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 150,
                                        child: BirthdayWidget(),
                                      ),
                                controller.activitieslist.isEmpty
                                    ? SizedBox.shrink()
                                    : Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start, // Align to the left

                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0,
                                                  top: 10.0,
                                                  right:
                                                      10.0), // Reduced padding
                                              child: Text(
                                                "Upcoming Activities",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 22,
                                                  fontFamily: 'Poppins-Medium',
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 0.7,
                                                ),
                                              ),
                                            ),
                                          ),

                                          // Underline with reduced spacing
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0,
                                                top: 4.0,
                                                bottom:
                                                    8.0), // Reduced top padding
                                            child: Container(
                                              height:
                                                  1.5, // Slightly thicker line
                                              width: 220,
                                              color: Palette.Ksecondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                SizedBox(
                                  height: 10,
                                ),
                                controller.activitieslist.isEmpty
                                    ? SizedBox.shrink()
                                    : SizedBox(
                                        height: 100,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Activities(),
                                      )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 60,
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
