import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';

import 'package:hrapp/Themecolor/Palette.dart';
import 'package:hrapp/controller/AllLeaveController.dart';
import 'package:hrapp/controller/LeaveController.dart';
import 'package:hrapp/view/LeaveHistroy/LeaveHistroyScreen.dart';
import 'package:hrapp/view/leaveapply/FulldayLeave.dart';
import 'package:hrapp/view/pages/Halfdaypage.dart';
import 'package:hrapp/view/pages/Halffrom.dart';
import 'package:hrapp/view/pages/RejectedLeave.dart';
import 'package:hrapp/view/pages/SaveLeave.dart';
import 'package:hrapp/view/pages/approvedLeave.dart';
import 'package:hrapp/view/pages/pendingLeave.dart';

class Leavepage extends StatefulWidget {
  const Leavepage({Key? key}) : super(key: key);

  @override
  _LeavepageState createState() => _LeavepageState();
}

class _LeavepageState extends State<Leavepage> {
  late final Allleavecontroller allleave;
  late final Leavecontroller leave;

  @override
  void initState() {
    super.initState();
    allleave = Get.put(Allleavecontroller());
    leave = Get.put(Leavecontroller());

    allleave.FectchLeaverequest();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: SpeedDial(
            backgroundColor: Palette.Kmain,
            foregroundColor: Palette.Kwhite,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  tileMode: TileMode.mirror,
                  colors: [Colors.purple, Colors.blue],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Text("Apply Leave"),
            ),
            label: Text("Apply Leave"),
            curve: Curves.bounceInOut,
            childPadding: EdgeInsets.only(top: 20),
            animatedIcon: AnimatedIcons.add_event,
            icon: Icons.add,
            activeIcon: Icons.close,
            children: [
              SpeedDialChild(
                elevation: 4,
                child: Icon(Icons.add),
                label: 'Full day',
                backgroundColor: Colors.white,
                labelBackgroundColor: Colors.white,
                labelStyle: TextStyle(color: Colors.black),
                onTap: () {
                  Get.to(() => Fulldayleave());
                },
              ),
              SpeedDialChild(
                child: Icon(Icons.add),
                label: 'Half day',
                backgroundColor: Color(0xfffFFFFF),
                labelBackgroundColor: Colors.white,
                labelStyle: TextStyle(color: Colors.black),
                onTap: () {
                  Get.to(() => Halffrom());
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => Leavehistroyscreen());
              },
              icon: Icon(Icons.history),
            )
          ],
          backgroundColor: Colors.grey[100],
          title: Text(
            "Leaves",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          elevation: 5,
          excludeHeaderSemantics: true,
          centerTitle: true,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: Colors.grey.shade700,
            labelColor: Palette.Kmain,
            indicatorColor: Palette.Kmain,
            indicatorWeight: 5.0,
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              color: Colors.grey,
              fontSize: 8,
            ),
            tabs: [
              Tab(text: "Approved"),
              Tab(text: "Pending"),
              Tab(text: "Rejected"),
              Tab(text: "HalfDay"),
              Tab(text: "Draft"),
            ],
          ),
        ),
        body: Obx(() {
          if (allleave.isloading.value) {
            return Center(child: CircularProgressIndicator());
          }
          return TabBarView(
            clipBehavior: Clip.antiAlias,
            physics: BouncingScrollPhysics(),
            children: [
              Approvedleave(),
              Pendingleave(),
              Rejectedleave(),
              HalfDayPage(),
              Saveleave(),
            ],
          );
        }),
      ),
    );
  }
}
