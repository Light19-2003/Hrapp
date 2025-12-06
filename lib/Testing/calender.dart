import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrapp/controller/AddJustLeaveontroller.dart';
import 'package:hrapp/controller/AttendenceRecords.dart';
import 'package:hrapp/controller/GetTimeSheetController.dart';
import 'package:hrapp/controller/TimeLineController.dart';
import 'package:http/http.dart';

class YearMonthPicker extends StatefulWidget {
  @override
  State<YearMonthPicker> createState() => _YearMonthPickerState();
}

class _YearMonthPickerState extends State<YearMonthPicker> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // addjustleavecontroller addjustleave = Get.put(addjustleavecontroller());
    // Attendencerecords attendencerecords = Get.put(Attendencerecords());
    // Timelinecontroller timelinecontroller = Get.put(Timelinecontroller());
    // attendencerecords.monthTypeId = 5;
    // attendencerecords.yearid = 2025;
    Gettimesheetcontroller gettimesheetcontroller =
        Get.put(Gettimesheetcontroller());
    return Scaffold(
      appBar: AppBar(
        title: Text('Year and Month Picker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Selected: ${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // attendencerecords.getAttendenceRecords();
              // addjustleave.addjustleave("1", 'Rejected');
              // timelinecontroller.getTimeline(13, 30130);
              gettimesheetcontroller.GetTimeSheet();
            },
            child: Text("Pick Month & Year"),
          ),
        ],
      ),
    );
  }
}
