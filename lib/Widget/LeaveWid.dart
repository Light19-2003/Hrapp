import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrapp/Model/DashboardModel.dart';

class Leavebalance extends StatelessWidget {
  const Leavebalance({super.key, required this.leaveDataModel});

  final LeaveDataModel leaveDataModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            "${leaveDataModel.leavetypes}",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          subtitle: Text("${leaveDataModel.daystaken.toString()} Consumed",
              style:
                  TextStyle(fontWeight: FontWeight.normal, color: Colors.grey)),
          trailing: Container(
            width: 80.w,
            margin: EdgeInsets.only(top: 2.h),
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  "${leaveDataModel.balance.toString()} ",

                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.w),
                  // style: GoogleFonts.poppins(
                  //   fontWeight: FontWeight.bold,
                  //   // color: Colors.blue,
                  // ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text("Available",
                    style: TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.grey))
              ],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
