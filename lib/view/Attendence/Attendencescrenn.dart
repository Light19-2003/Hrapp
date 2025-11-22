import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrapp/Model/AttendenceRecords.dart';
import 'package:hrapp/Themecolor/Palette.dart';
import 'package:hrapp/Widget/AttendenceCalender.dart';
import 'package:hrapp/bulider/AttendencedetailsBulider.dart';
import 'package:hrapp/controller/AttendenceRecords.dart';
import 'package:hrapp/controller/Attendencedetails%20controller.dart';
import 'package:hrapp/controller/checkoutcontroller.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class Attendencescrenn extends StatelessWidget {
  const Attendencescrenn({super.key});

  @override
  Widget build(BuildContext context) {
    Attendencerecordscontroller attendanceRecordController =
        Get.put(Attendencerecordscontroller());
    DateTime selectedDate = DateTime.now();

    final DateFormat formatter = DateFormat('MMM');
    final String formattedDate = formatter.format(selectedDate);

    String? month;
    void _pickMonthYear(BuildContext context) async {
      final DateTime currentDate = DateTime.now();
      final DateTime? picked = await showMonthPicker(
        context: context,
        initialDate: currentDate, // Start with the current date
        firstDate: DateTime(currentDate.year), // Restrict to the current year
        lastDate: DateTime(
            currentDate.year, 12), // Allow selection only in the current year
      );

      if (picked != null) {
        final DateFormat formatter = DateFormat('yyyy-MMM');
        final String formattedDate = formatter.format(picked);

        attendanceRecordController.monthTypeId = picked.month;
        attendanceRecordController.yearid = picked.year;

        // Update the text field
        attendanceRecordController.Mothcon.text = formattedDate;

        print("Selected Month: ${picked.month}");
        print("Selected Year: ${picked.year}");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Attendence"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onTap: () {
                  _pickMonthYear(context);
                },
                readOnly: true,
                controller: attendanceRecordController.Mothcon,
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.calendar_month),
                    label: Text("Select month and year "),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.Kmain),
                        borderRadius: BorderRadius.circular(15))),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Center(
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Palette.Kmain)),
                onPressed: () {
                  if (attendanceRecordController.Mothcon.text.isEmpty) {
                    Get.snackbar("Month", "Choose any month and year");
                  } else {
                    attendanceRecordController.getAttendenceRecords();
                    Get.snackbar(
                      "Please Wait", // Title of the Snackbar
                      "Fetching attendance details. This may take a moment.",
                      icon: Icon(Icons.hourglass_bottom, color: Colors.white),
                      snackPosition: SnackPosition.bottom,
                      backgroundColor: Colors.blueAccent,
                      colorText: Colors.white,
                      borderRadius: 8,
                      margin: EdgeInsets.all(10),
                      duration: Duration(seconds: 2),
                    );
                  }
                },
                label: Text(
                  "Serach",
                  style: TextStyle(
                    color: Palette.Kwhite,
                  ),
                ),
                icon: Icon(
                  Icons.search,
                  color: Palette.Kwhite,
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Divider(
              indent: 22,
              endIndent: 22,
            ),
            Obx(() => attendanceRecordController.loading.value
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      // color: Colors.,

                      child: Container(
                          height: 400.h,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.all(13.0),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: const [
                              //       Text("Sun"),
                              //       Text("Mon"),
                              //       Text("Tue"),
                              //       Text("Wed"),
                              //       Text("Thu"),
                              //       Text("Fri"),
                              //       Text("Sat"),
                              //     ],
                              //   ),
                              // ),
                              Expanded(
                                // child: Padding(
                                //   padding: const EdgeInsets.all(5.0),
                                //   child: const AttendanceDetailsBuilder(),
                                // ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Obx(() {
                                    if (attendanceRecordController
                                        .attendence.isEmpty) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }

                                    return AttendanceCalendar(
                                      records:
                                          attendanceRecordController.attendence,
                                      month: DateTime(
                                          2023, 5), // Set your desired month
                                    );
                                  }),
                                ),
                              ),
                            ],
                          )),
                    ),
                  )
                : Center(
                    child: SizedBox.shrink(),
                  )),
            Obx(() => attendanceRecordController.loading.value
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 15.h,
                          width: 15.w,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("- Persent")
                      ],
                    ),
                  )
                : Center(
                    child: SizedBox.shrink(),
                  )),
            Obx(() => attendanceRecordController.loading.value
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 15.h,
                          width: 15.w,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("- Absent")
                      ],
                    ),
                  )
                : Center(
                    child: SizedBox.shrink(),
                  )),
            Obx(() => attendanceRecordController.loading.value
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 15.h,
                          width: 15.w,
                          color: Colors.grey,
                        ),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        Text(
                          " - Weekend",
                          style: TextStyle(fontSize: 13),
                        )
                      ],
                    ),
                  )
                : Center(
                    child: SizedBox.shrink(),
                  )),
            Obx(() => attendanceRecordController.loading.value
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 15.h,
                          width: 15.w,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("- Leave")
                      ],
                    ),
                  )
                : Center(
                    child: SizedBox.shrink(),
                  )),
            Obx(() => attendanceRecordController.loading.value
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 15.h,
                          width: 15.w,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("- Hoilday")
                      ],
                    ),
                  )
                : Center(
                    child: SizedBox.shrink(),
                  )),
            Obx(() => attendanceRecordController.loading.value
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 15.h,
                          width: 15.w,
                          color: Colors.blueGrey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        const Text("- Not Available (NA)")
                      ],
                    ),
                  )
                : Center(
                    child: SizedBox.shrink(),
                  )),
          ],
        ),
      ),
    );
  }
}
