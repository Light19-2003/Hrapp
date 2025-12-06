import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrapp/Themecolor/Palette.dart';
import 'package:hrapp/common/Help_function.dart';
import 'package:hrapp/controller/DashboardController.dart';
import 'package:hrapp/controller/GetTimeSheetController.dart';
import 'package:hrapp/view/TimeSheet/Time_Sheet_Details.dart';
import 'package:intl/intl.dart';

class Time_Sheet_Screen extends StatefulWidget {
  Time_Sheet_Screen({super.key, required this.TimeId});

  final int? TimeId;

  @override
  State<Time_Sheet_Screen> createState() => _Time_Sheet_ScreenState();
}

class _Time_Sheet_ScreenState extends State<Time_Sheet_Screen> {
  @override
  final Gettimesheetcontroller gettimesheetcontroller =
      Get.put(Gettimesheetcontroller());

  final Dashboardcontroller dashboardcontroller =
      Get.put(Dashboardcontroller());
  void initState() {
    super.initState();

    // 👇 This will run automatically once when page open
    gettimesheetcontroller.FetchTimeSheet(widget.TimeId!);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TimeSheet"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade300)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildLabel("Employee Name :"),
                          BuildText(profilecontroller.profilemodel.empname
                              .toString()),
                        ],
                      ),
                      Divider(
                        indent: 15,
                        endIndent: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildLabel("Work Date :"),
                          BuildText(
                              '${DateFormat('dd-MM-yyyy').format(DateTime.now())}'),
                        ],
                      ),
                      Divider(
                        indent: 15,
                        endIndent: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildLabel("Clock IN -Clock OUT:"),
                          BuildText(
                              '${dashboardcontroller.getTime.signin} - ${dashboardcontroller.getTime.signout}'),
                        ],
                      ),
                      Divider(
                        indent: 15,
                        endIndent: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildLabel("Total Hours :"),
                          BuildText(getTotalHours(
                              '${dashboardcontroller.getTime.signin}',
                              '${dashboardcontroller.getTime.signout}')),
                        ],
                      )  ,

                      /// Task Details
                      ///
                    ],
                  ),
                ),
              ),
              const Text(
                "Task Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade300)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildInputField(
                          label: "Task Name",
                          controller: gettimesheetcontroller.taskcontroller),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                      ),
                      buildInputField(
                          label: "Time(In Hours)",
                          controller:
                              gettimesheetcontroller.totalhourcontroller),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                      ),
                      buildInputField(
                          label: "Project Code",
                          controller:
                              gettimesheetcontroller.projectcodecontroller),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                      ),
                      buildInputField(
                          label: "Notes",
                          controller: gettimesheetcontroller.notescontroller),
                      Obx(
                        () => Center(
                          child: gettimesheetcontroller.isLoading.value
                              ? const CircularProgressIndicator.adaptive()
                              : ElevatedButton.icon(
                                  onPressed: () {
                                    gettimesheetcontroller.PostTimeSheet(
                                        widget.TimeId!);

                                    // gettimesheetcontroller.FetchTimeSheet(
                                    //     widget.TimeId!);
                                  },
                                  icon: const Icon(Icons.save),
                                  label: const Text("Save"),
                                ),
                        ),
                      ),

                      //// timeSheet Entry

                      Divider(
                        indent: 10,
                        endIndent: 10,
                      ),
                      SizedBox(
                          height: 200,
                          child: Obx(
                            () => gettimesheetcontroller.isFetchLoading.value
                                ? Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  )
                                : ListView.builder(
                                    itemCount: gettimesheetcontroller
                                        .FeatchtimeSheetList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final timesheetlist =
                                          gettimesheetcontroller
                                              .FeatchtimeSheetList[index];
                                      return Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 14),
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.redAccent.withOpacity(
                                                  0.2), // more visible shadow
                                              blurRadius: 1, // smooth blur
                                              spreadRadius: 1, // soft expansion
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            // DATE ICON + DATE
                                            const Icon(Icons.calendar_month,
                                                color: Colors.blue, size: 28),
                                            const SizedBox(width: 12),

                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${timesheetlist.task}",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.access_time,
                                                          size: 18,
                                                          color: Colors.grey),
                                                      SizedBox(width: 6),
                                                      Text(
                                                        "${timesheetlist.totalHour}",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 2),
                                                Text(
                                                  "${timesheetlist.projectCode}",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),

                                            // TOTAL HOURS
                                            // Column(
                                            //   crossAxisAlignment:
                                            //       CrossAxisAlignment.end,
                                            //   children: [
                                            //     IconButton(
                                            //       onPressed: () {
                                            //         Get.to(() => Time_Sheet_Screen(
                                            //               TimeId:
                                            //                   timesheetlist.timesheetid,
                                            //             ));
                                            //       },
                                            //       icon: Icon(Icons.edit,
                                            //           size: 30,
                                            //           color: Colors.deepOrangeAccent),
                                            //     ),
                                            //     SizedBox(height: 4),
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                      );
                                    }),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text("Submit"),
      ),
    );
  }
}
