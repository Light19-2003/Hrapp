import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrapp/Model/DashboardModel.dart';
import 'package:hrapp/controller/LoginController.dart';
import 'package:hrapp/controller/Profilecontroller.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Profilecontroller profilecontroller = Get.put(Profilecontroller());

class Dashboardcontroller extends GetxController {
  final controller = Get.put(Logincontroller());

  final leavedatalist = <LeaveDataModel>[].obs;
  final activitieslist = <UpcomingActivites>[].obs;
  final brithdayslist = <UpcomingBrithday>[].obs;
  final gettimes =
      <GetTime>[].obs; // Make sure this is the correct naming convention
  Rx<TimeOfDay> timeOfDay = TimeOfDay.now().obs;

  Dashboardmodel dashboardmodel = Dashboardmodel();
  RxBool isloading = false.obs;
  RxBool loading = false.obs;

  GetTime getTime = GetTime();

  // Rx<Duration> output1 = Duration().obs;

  Rx<Duration> difference = Duration().obs;

  Rx<int> outputSeconds = Rx<int>(0);

  Rx<int> outputmin = Rx<int>(0);

  Rx<int> outputSeconds1 = Rx<int>(0);

  @override
  void onInit() {
    getdashboardDetails();
    updateTime();
    profilecontroller.GetProfile();
    super.onInit();
  }

  void updateTime() {
    timeOfDay.value = TimeOfDay.now();
  }

  Future<void> getdashboardDetails() async {
    isloading.value = true;
    loading.value = true;
    try {
      final empid = controller.box.read("UserId");
      String url =
          "http://rshrmsapapi.redsecure.online/api/HRMSWEBAPI/LeaveDetalis?empid=$empid&authcode=${controller.box.read("AppCode")}";
      final Response = await http.get(Uri.parse(url));
      print(Response.body.toString());

      if (Response.statusCode == 200) {
        leavedatalist.clear();
        activitieslist.clear();
        brithdayslist.clear();
        gettimes.clear();

        final extractedData = jsonDecode(Response.body);

        dashboardmodel.isError = extractedData["isError"];
        dashboardmodel.errorMsg = extractedData['errorMsg'];
        dashboardmodel.markatt = extractedData["markatt"];

        final leavedata = extractedData["LeaveData"];
        final brithdaysdata = extractedData["employeeBrithdaysList"];
        final Activitiesdata = extractedData['ActivitiesList'];

        // Handle LeaveData parsing
        for (var element in leavedata) {
          LeaveDataModel leaveDataModel = LeaveDataModel();
          leaveDataModel.id = element['ID'];
          leaveDataModel.empname = element['EmpName'];
          leaveDataModel.leavetypes = element["LeaveType"];
          leaveDataModel.leavebf = element["LeaveBf"];
          leaveDataModel.daystaken = element["DaysTaken"];
          leaveDataModel.balance = element["Balance"];
          leavedatalist.add(leaveDataModel);
        }

        // Handle Brithdays parsing
        for (int i = 0; i < brithdaysdata.length; i++) {
          UpcomingBrithday upcomingBrithday = UpcomingBrithday();
          upcomingBrithday.empcode = brithdaysdata[i]["EmpCode"];
          upcomingBrithday.empname = brithdaysdata[i]["EmpName"];
          upcomingBrithday.emailwork = brithdaysdata[i]["Email_Work"];
          upcomingBrithday.dob = brithdaysdata[i]["DOB"];
          upcomingBrithday.userimage = brithdaysdata[i]["profilePic"];
          // if (brithdaysdata[i]["profilePic"] != null) {
          //   upcomingBrithday.imageBytes =
          //       base64Decode(brithdaysdata[i]["profilePic"].toString());
          // }
          brithdayslist.add(upcomingBrithday);
        }

        // Handle Activities parsing
        for (int i = 0; i < Activitiesdata.length; i++) {
          UpcomingActivites upcomingActivites = UpcomingActivites();
          upcomingActivites.id = Activitiesdata[i]["ID"];
          upcomingActivites.meassage = Activitiesdata[i]["Message"];
          activitieslist.add(upcomingActivites);
        }

        // profilemodel.id = extractedData["UserProFileData"]["ID"];
        getTime.AttendenceId = extractedData["gettimes"]["AttendenceID"];
        getTime.signin = extractedData["gettimes"]["singin"];
        getTime.signout = extractedData["gettimes"]["singout"];

        dashboardmodel.getime = getTime;

        print(dashboardmodel.getime!.signin);

        // Handle Gettime parsing

        // Ensure the list is not empty before accessing it
        // if (gettimes.isNotEmpty) {
        //   String? fullDateTime =
        //       gettimes[0].signin; // e.g., "2024-11-12 09:00:00"
        //   if (fullDateTime != null && fullDateTime.isNotEmpty) {
        //     timeOnly = fullDateTime.substring(11, 16);
        //     print("Signin Time: $timeOnly"); // Output the time part only
        //   } else {
        //     print("Signin Time is unavailable");
        //   }
        // }
      }

      timer();
      timecal();
    } catch (ex) {
      print(ex.toString());
    }
    isloading.value = false;
    loading.value = true;
  }

  Rx<int> differenceInSeconds = Rx<int>(0);

  int? hours;

  RxInt min = 0.obs;
  RxInt sec = 0.obs;

  var differenceInSeconds1 = 0.obs;

  // Initialize to 0 seconds

  void timer() {
    // Example signin time in string format
    String? signin = dashboardmodel.getime!.signin;

    if (signin != null) {
      try {
        // Add the current date to the signin time to create a complete datetime string
        String todayDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
        String fullSignin = "$todayDate $signin";

        // Parse the signin time with the date
        DateFormat format = DateFormat("yyyy-MM-dd hh:mm a");
        DateTime startTime = format.parse(fullSignin);

        print("Parsed Start Time: $startTime");

        // Set up a timer to calculate the difference every second
        Timer.periodic(Duration(seconds: 1), (timer) {
          DateTime currentTime = DateTime.now();
          Duration difference = currentTime.difference(startTime);

          differenceInSeconds.value = difference.inSeconds;

          // Calculate hours, minutes, and seconds
          hours = difference.inSeconds ~/ 3600;
          int minutes = (difference.inSeconds % 3600) ~/ 60;
          int seconds = difference.inSeconds % 60;

          // Print the difference
          // print('Difference: $hours hours, $minutes minutes, $seconds seconds');
        });
      } catch (e) {
        print("Error parsing time: $e");
      }
    } else {
      print('Sign-in time is null');
    }
  }

  void timecal() {
    // Get the signin and signout values
    String? ckeckin = dashboardmodel.getime!.signin;
    print("Check-in: $ckeckin");

    String? ckeckout = dashboardmodel.getime!.signout; // Corrected this line
    print("Check-out: $ckeckout");

    // Check if both values are not null
    if (ckeckin != null && ckeckout != null) {
      // Initialize the DateFormat for parsing the time
      DateFormat format = DateFormat("hh:mm a");

      // Parse the check-in and check-out times into DateTime objects
      DateTime startTime = format.parse(ckeckin); // Parse check-in time
      print("Start time: $startTime");

      DateTime endTime = format.parse(ckeckout); // Parse check-out time
      print("End time: $endTime");

      // Calculate the time difference
      Duration difference1 = endTime.difference(startTime);
      print("Time differences: $difference");

      outputSeconds.value = difference1.inHours;
      outputmin.value = difference1.inMinutes % 60;
      outputSeconds1.value = difference1.inSeconds % 60;

      // difference = difference1;

      // Store the difference
      // Assuming output1 is a variable to store the difference
    } else {
      print('Both check-in and check-out are empty');
    }
  }
}
