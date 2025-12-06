import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrapp/common/Help_function.dart';
import 'package:hrapp/controller/DashboardController.dart';

class Submittedtimesheet extends StatelessWidget {
  const Submittedtimesheet({super.key});

  @override
  Widget build(BuildContext context) {
    final Dashboardcontroller dashboardcontroller =
        Get.put(Dashboardcontroller());
    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),
      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: 7,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.2), // more visible shadow
                  blurRadius: 1, // smooth blur
                  spreadRadius: 1, // soft expansion
                  offset: const Offset(0, 2), // slight downward shadow
                ),
              ],
            ),
            child: Row(
              children: [
                // DATE ICON + DATE
                const Icon(Icons.calendar_month, color: Colors.blue, size: 28),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$formattedDate",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 18, color: Colors.grey),
                          SizedBox(width: 6),
                          Text(
                            "${dashboardcontroller.getTime.signin} - ",
                            style: TextStyle(
                              fontSize: 13,
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
                  children: const [
                    Icon(Icons.timer_outlined,
                        size: 22, color: Colors.deepOrange),
                    SizedBox(height: 2),
                    Text(
                      "9h 39m",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.deepOrange,
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
                  children: const [
                    Icon(Icons.done_all, size: 22, color: Colors.green),
                    SizedBox(height: 4),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
