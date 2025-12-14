import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hrapp/Model/TimeSheetModel.dart';
import 'package:hrapp/common/Help_function.dart';
import 'package:hrapp/controller/LoginController.dart';
import 'package:hrapp/view/TimeSheet/DarftTimeSheet.dart';
import 'package:hrapp/view/navbar.dart';
import 'package:http/http.dart' as http;

class Gettimesheetcontroller extends GetxController {
  void onInit() {
    super.onInit();
    GetTimeSheet();
  }

  RxList<Timesheetmodel> timesheetlist = <Timesheetmodel>[].obs;

  RxList<TimeSheetList> FeatchtimeSheetList = <TimeSheetList>[].obs;

  RxBool isLoading = false.obs;

  RxBool isFetchLoading = false.obs;

  TextEditingController taskcontroller = TextEditingController();

  TextEditingController totalhourcontroller = TextEditingController();

  TextEditingController projectcodecontroller = TextEditingController();

  TextEditingController notescontroller = TextEditingController();

  GetStorage box = GetStorage();

  Future<void> GetTimeSheet() async {
    isLoading.value = true;

    final empId = box.read("UserId");
    final appcode = box.read("AppCode");
    try {
      final url =
          "https://rshrmsapapi.redsecure.online/api/HRMSWEBAPI/GetTimeSheetView?Empid=$empId&authcode=$appcode";

      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        timesheetlist.clear();
        final data = jsonDecode(res.body);
        print(data);
        final timeSheetList = data["getTimeSheetDataModels"];
        print(timeSheetList);

        for (var element in timeSheetList) {
          Timesheetmodel timesheetmodel = Timesheetmodel();

          timesheetmodel.timesheetid = element["TimesheetId"];
          timesheetmodel.EmpId = element["EmpId"];
          timesheetmodel.EmployeeName = element["EmployeeName"];
          timesheetmodel.workDate = element["workDate"];
          timesheetmodel.clockIn = element["ClockIn"];
          timesheetmodel.projectCode = element["projectCode"];
          timesheetmodel.issumbit = element["issumbit"];
          timesheetlist.add(timesheetmodel);
        }
        print(timesheetlist.length.toString());
      }
      print(res.body);
    } catch (ex) {
      print(ex.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> FetchTimeSheet(int TimeId) async {
    isFetchLoading.value = true;
    final controller = Get.put(Logincontroller());

    final empId = controller.box.read("UserId");
    final appcode = controller.box.read("AppCode");
    try {
      final url =
          "https://rshrmsapapi.redsecure.online/api/HRMSWEBAPI/GetTimeSheetData?timeid=$TimeId&authcode=$appcode";

      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        FeatchtimeSheetList.clear();
        final data = jsonDecode(res.body);
        final timeSheetList = data["getTimeSheetDataModels"];

        for (var element in timeSheetList) {
          TimeSheetList timeSheetList = TimeSheetList();
          timeSheetList.id = element['ID'];

          timeSheetList.TimesheetId = element["TimesheetId"];
          timeSheetList.task = element["task"];
          timeSheetList.workDate = element["workDate"];
          timeSheetList.projectCode = element["projectCode"];
          timeSheetList.Notes = element["Notes"];
          timeSheetList.totalHour = element["totalHour"];

          FeatchtimeSheetList.add(timeSheetList);
        }
      }
    } catch (ex) {
      print(ex.toString());
    } finally {
      isFetchLoading.value = false;
    }
  }

  Future<void> PostTimeSheet(int timeid) async {
    isLoading.value = true;

    final controller = Get.put(Logincontroller());
    final empId = controller.box.read("UserId");
    final appcode = controller.box.read("AppCode");

    try {
      final url =
          "https://rshrmsapapi.redsecure.online/api/HRMSWEBAPI/PostTimeSheet?authcode=$appcode";

      final res = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json', // <-- important
        },
        body: jsonEncode({
          "Task": taskcontroller.text,
          "totalHour": totalhourcontroller.text,
          "ProjectCode": selectedProject.value,
          "Notes": notescontroller.text,
          "TimeSheetID": timeid,
        }),
      );
      print(res.body);

      if (res.statusCode == 200) {
        print(res.body);
        print("sucess");
      } else {
        print("error");
      }
    } catch (ex) {
      print(ex.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> SumbitTimeSheet(int timeid) async {
    try {
      final appcode = box.read("AppCode");
      final url =
          'https://rshrmsapapi.redsecure.online/api/HRMSWEBAPI/IsSumbitTimeSheet?Timeid=$timeid&authcode=$appcode';

      final res = await http.get(Uri.parse(url));
      print(res.body);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);

        final result = data["Setflow"];

        if (result == false) {
          print("sucess");
          Get.snackbar(
            "Success 🎉",
            "Timesheet submitted successfully!",
            snackPosition: SnackPosition.bottom,
            backgroundColor: Colors.green.shade600,
            colorText: Colors.white,
            borderRadius: 10,
            margin: EdgeInsets.all(12),
            duration: Duration(seconds: 2),
          );

          Get.offAll(() => Navbar());
        } else {
          print("error");
        }
      }
    } catch (ex) {
      print(ex.toString());
    }
  }

  Future<void> DeleteTimeSheet(int id, int timeid) async {
    try {
      final appcode = box.read("AppCode");

      final url =
          "https://rshrmsapapi.redsecure.online/api/HRMSWEBAPI/TimeSheetsDelete?id=$id&authcode=$appcode";

      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        print(data);
        final IsDelete = data['IsDelete'];

        if (IsDelete) {
          await FetchTimeSheet(timeid);
          Get.snackbar('Success', 'Leave deleted successfully');
        } else {
          Get.snackbar('Failed', 'Error');
        }
      }
    } catch (ex) {
      print(ex.toString());
    }
  }
}
