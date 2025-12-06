import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrapp/common/Help_function.dart';
import 'package:hrapp/controller/DashboardController.dart';
import 'package:hrapp/controller/GetTimeSheetController.dart';
import 'package:hrapp/view/TimeSheet/Time_Sheet_Details.dart';
import 'package:hrapp/view/TimeSheet/Time_screen.dart';

class Darfttimesheet extends StatelessWidget {
  const Darfttimesheet({super.key});

  @override
  Widget build(BuildContext context) {
    final Dashboardcontroller dashboardcontroller =
        Get.put(Dashboardcontroller());

    Gettimesheetcontroller gettimesheetcontroller =
        Get.put(Gettimesheetcontroller());

    return Scaffold(
        backgroundColor: const Color(0xfff5f6fa),
        body: Obx(() {
          final timeSheet = gettimesheetcontroller.timesheetlist
              .where((val) => val.issumbit == false)
              .toList();
          return gettimesheetcontroller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(14),
                  itemCount: timeSheet.length,
                  itemBuilder: (context, index) {
                    final timesheetlist = timeSheet[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.redAccent
                                .withOpacity(0.2), // more visible shadow
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${timesheetlist.workDate}",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.access_time,
                                        size: 18, color: Colors.grey),
                                    SizedBox(width: 6),
                                    Text(
                                      "${(timesheetlist.clockIn ?? "").trim().split(" ").isNotEmpty ? (timesheetlist.clockIn ?? "").trim().split(" ").last : ""} ",
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.timer_outlined,
                                  size: 22, color: Colors.grey),
                              SizedBox(height: 2),
                              Text(
                                timesheetlist.totalHour == null
                                    ? ""
                                    : "${timesheetlist.totalHour}",
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.to(() => Time_Sheet_Screen(
                                        TimeId: timesheetlist.timesheetid,
                                      ));
                                },
                                icon: Icon(Icons.edit,
                                    size: 30, color: Colors.deepOrangeAccent),
                              ),
                              SizedBox(height: 4),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
        }));
  }
}
