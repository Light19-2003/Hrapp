import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:hrapp/controller/DashboardController.dart';
import 'package:hrapp/view/TimeSheet/DarftTimeSheet.dart';
import 'package:hrapp/view/TimeSheet/SubmittedTimeSheet.dart';


class TimeSheetDetails extends StatelessWidget {
  const TimeSheetDetails({super.key});

  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("TimeSheet"),
          bottom: TabBar(tabs: [
            Tab(
              child: Text("Draft"),
            ),
            Tab(
              child: Text("Submitted"),
            )
          ]),
        ),
        body: TabBarView(children: [Darfttimesheet(), Submittedtimesheet()]),
      ),
    );
  }
}
