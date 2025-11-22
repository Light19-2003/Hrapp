import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrapp/Model/LeaveRequestModel.dart';
import 'package:hrapp/controller/LeaveRequestController.dart';
import 'package:hrapp/main.dart';
import 'package:hrapp/view/pages/ApprovedSave.dart';
import 'package:hrapp/view/pages/approvedpage.dart';
import 'package:hrapp/view/pages/leavedashboard.dart';
import 'package:intl/intl.dart';

class Fulldayleave extends StatelessWidget {
  Fulldayleave({super.key});

  @override
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    final Addfulldayleave = Get.put(Leaverequestcontroller());
    // Addfulldayleave.Getdayscal();

    // Addfulldayleave.Getdayscal();

    Future<void> scheduleNotification() async {
      // Android notification setup
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'leave_channel_id', // Channel ID
        'Leave Notifications', // Channel name
        channelDescription:
            'Notifications about leave requests', // Add this for Android 12+
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      );

      // iOS notification setup
      const DarwinNotificationDetails iosPlatformChannelSpecifics =
          DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      // Combine both
      const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics,
      );

      // Show notification
      await flutterLocalNotificationsPlugin.show(
        0, // Notification ID
        'Leave Submitted Successfully',
        'Your leave request has been submitted successfully and is waiting for approval.',
        platformChannelSpecifics,
      );
    }

    String txtDate = DateFormat('d MMM yyyy').format(DateTime.now());
    Leaverequestmodel leaverequestmodel = Leaverequestmodel();

    void fromsubmit(Leaverequestmodel leaverequest) async {
      if (_formkey.currentState!.validate()) {
        Get.snackbar(
          'Success', 'Leave request submitted successfully',

          snackPosition: SnackPosition.top, // Position of the snackbar
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Error",
          "Please fill all required fields",
          snackPosition: SnackPosition.top,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      ;
    }

    void _fromDate() async {
      final now = DateTime.now();
      DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: now, //get today's date
          firstDate: DateTime
              .now(), //DateTime.now() - not to allow to choose before today.
          lastDate: DateTime(2101));

      if (pickedDate != null) {
        print(pickedDate);
        DateFormat('yyyy-MM-dd');

        //get the picked date in the format => 2022-07-04 00:00:00.000
        String formattedDate = DateFormat('d MMM yyyy').format(
            pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
        print(
            formattedDate); //formatted date output using intl package =>  2022-07-04
        //You can format date as per your need
        txtDate = formattedDate;

        Addfulldayleave.fromdatecontroller.text = txtDate;
      } else {
        print("Date is not selected");
      }
    }

    // Addfulldayleave.fromdatecontroller.text = txtDate;

    void _toDate() async {
      final now = DateTime.now();
      final DateTime? fromDate = DateFormat('d MMM yyyy')
          .parse(Addfulldayleave.fromdatecontroller.text);

      // final firstdate = DateTime(now.year - 1, now.month, now.day);
      DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate:
              fromDate!.add(const Duration(days: 1)), //get today's date

          firstDate: fromDate.add(const Duration(
              days: 1)), //DateTime.now() - not to allow to choose before today.
          lastDate: DateTime(2050));

      if (pickedDate != null) {
        print(
            pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
        String formattedDate = DateFormat('d MMM yyyy').format(
            pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
        print(
            formattedDate); //formatted date output using intl package =>  2022-07-04
        //You can format date as per your need

        Addfulldayleave.todatecontroller.text = formattedDate;
      } else {
        print("Date is not selected");
      }
    }

    Future<void> pickDateRange(BuildContext context) async {
      final DateTime now = DateTime.now();

      // Start from the current date
      final DateTime startDate = now;

      // End 6 months from the current date
      final DateTime endDate = DateTime(now.year, now.month + 6, now.day);

      final DateTimeRange? pickedRange = await showDateRangePicker(
        context: context,
        firstDate: startDate, // Disable past dates
        lastDate: endDate, // Extend up to 6 months
      );

      if (pickedRange != null) {
        // Use intl to format the dates
        final DateFormat formatter = DateFormat('d MMM yyyy');
        final String formattedStartDate = formatter.format(pickedRange.start);
        final String formattedEndDate = formatter.format(pickedRange.end);

        // Update the controller with the selected range
        Addfulldayleave.todatecontroller.text =
            "$formattedStartDate - $formattedEndDate";

        // Update individual start and end dates
        Addfulldayleave.startdate = formattedStartDate;
        Addfulldayleave.enddate = formattedEndDate;

        // Call your Getdayscal method
        Addfulldayleave.Getdayscal();
      }
    }

    //

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fullday leave"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding for better layout
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        // Expanded(
                        //   child: TextFormField(
                        //     onTap: _fromDate,
                        //     controller: Addfulldayleave.fromdatecontroller,
                        //     decoration: InputDecoration(
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(20),
                        //         borderSide:
                        //             const BorderSide(color: Colors.black),
                        //       ),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //         borderSide:
                        //             const BorderSide(color: Colors.grey),
                        //       ),
                        //       label: const Text("From date"),
                        //     ),
                        //     validator: (Value) {
                        //       if (Value == null || Value.isEmpty) {
                        //         return "Please enter the date";
                        //       }
                        //       return null;
                        //     },
                        //   ),
                        // ),
                        // SizedBox(
                        //   width: 20,
                        // ),
                        Expanded(
                          child: TextFormField(
                            onTap: () async {
                              await pickDateRange(
                                  context); // Pass the BuildContext
                            },
                            controller: Addfulldayleave.todatecontroller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              label: const Text("Select the date"),
                            ),
                            validator: (Value) {
                              if (Value == null || Value.isEmpty) {
                                return "Please enter to date";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Obx(() => Addfulldayleave.isloading.value
                  ? Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              Addfulldayleave.Getdayscal();
                            },
                            readOnly: true,
                            controller: Addfulldayleave.Leavesdays,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              label: const Text("Leave Days"),
                            ),
                          ),
                        ),
                      ],
                    )),
              SizedBox(
                height: 20,
              ),
              DropDownTextField(
                enableSearch: true,
                clearIconProperty: IconProperty(color: Colors.green),
                searchTextStyle: const TextStyle(color: Colors.red),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "please enter your leave type ";
                  } else {
                    return null;
                  }
                },
                controller: Addfulldayleave.cnt,
                dropDownItemCount: 13,
                dropDownList: const [
                  DropDownValueModel(name: "Annual Leave", value: 1),
                  DropDownValueModel(name: "Sick", value: 2),
                  DropDownValueModel(name: "Sick Leave Half Pay", value: 4),
                  DropDownValueModel(name: "Unpaid Leave", value: 10004),
                  DropDownValueModel(
                      name: "Sick Leave Without Pay", value: 20013),
                  DropDownValueModel(name: "Half Day Leave", value: 40015),
                  DropDownValueModel(name: "Covid Leave", value: 20005),
                  DropDownValueModel(name: "Bereavement Leave", value: 20008),
                  DropDownValueModel(name: "Marriage Leave", value: 20011),
                  DropDownValueModel(name: "Maternity Leave", value: 20012),
                  DropDownValueModel(name: "Emergency Leave", value: 30015),
                  DropDownValueModel(name: "Hajj Leave", value: 20014),
                  DropDownValueModel(name: "Umrah Leave", value: 20015)
                ],
                // clearOption: true,
                textFieldDecoration: InputDecoration(
                  hintText: "Select the Leave Type",
                ),
                onChanged: (val) {
                  Addfulldayleave.Leavestype =
                      Addfulldayleave.cnt.dropDownValue!.value;

                  print(Addfulldayleave.Leavestype =
                      Addfulldayleave.cnt.dropDownValue!.value);

                  // int? leaveid = _cnt.dropDownValue!.value;
                  // leaverequest.cnt.dropDownValue = val;
                  // leaverequest.cnt.dropDownValue = val;

                  // print(leaverequest.cnt.dropDownValue);

                  // Handle the selected value
                  // print(_cnt.dropDownValue!.value);
                  // leaveTypeId = _cnt.dropDownValue!.value;
                  //   leavetypecon.text = val;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: Addfulldayleave.remarkcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  label: const Text("remarks"),
                ),
                validator: (Value) {
                  if (Value == null || Value.isEmpty) {
                    return "Please enter the your remarks";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            MaterialButton(
              onPressed: () {
                leaverequestmodel.wFStatus =
                    Addfulldayleave.WFStatuscontroller.text = "P";

                Addfulldayleave.ishalfday = false;
                Addfulldayleave.issubmit = true;
                Addfulldayleave.Postleaverequest(leaverequestmodel);

                fromsubmit(leaverequestmodel);

                if (Addfulldayleave.todatecontroller.text.isNotEmpty &&
                    Addfulldayleave.remarkcontroller.text.isNotEmpty &&
                    Addfulldayleave.Leavesdays.text.isNotEmpty &&
                    Addfulldayleave.Leavestype.toString().isNotEmpty) {
                  scheduleNotification();
                  Get.offAll(() => ApprovedPage());
                }
              },
              color: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              height: 50,
              minWidth: MediaQuery.of(context).size.width * 0.4,
              child: const Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              width: 40,
            ),
            MaterialButton(
              onPressed: () {
                leaverequestmodel.wFStatus =
                    Addfulldayleave.WFStatuscontroller.text = "P";

                Addfulldayleave.ishalfday = false;
                Addfulldayleave.issubmit = false;
                Addfulldayleave.Postleaverequest(leaverequestmodel);

                fromsubmit(leaverequestmodel);
                if (Addfulldayleave.todatecontroller.text.isNotEmpty &&
                    Addfulldayleave.remarkcontroller.text.isNotEmpty &&
                    Addfulldayleave.Leavesdays.text.isNotEmpty &&
                    Addfulldayleave.Leavestype.toString().isNotEmpty) {
                  scheduleNotification();
                  Get.offAll(() => ApprovedSave());
                }
              },
              color: Color.fromRGBO(49, 39, 79, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              height: 50,
              minWidth: MediaQuery.of(context).size.width * 0.4,
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
