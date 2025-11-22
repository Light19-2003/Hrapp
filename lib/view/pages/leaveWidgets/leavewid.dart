import 'package:flutter/material.dart';
import 'package:hrapp/Model/AllLeavemodel.dart';
import 'package:intl/intl.dart';

class Leaveapproved extends StatelessWidget {
  const Leaveapproved({super.key, this.allleavemodel});

  final Allleavemodel? allleavemodel;

  @override
  Widget build(BuildContext context) {
    String? text;
    if (allleavemodel!.wfstatus == "A") {
      text = "Approved";
    }

    Color? color;

    if (allleavemodel!.wfstatus == 'A' || allleavemodel!.wfstatus == 'a') {
      color = Colors.green;
    }

    String date1 = allleavemodel!.todate.toString();
    DateTime dateTime1 = DateTime.parse(date1);

    String todate = DateFormat('d MMM yyyy').format(dateTime1);

    String date = allleavemodel!.todate.toString();
    DateTime dateTime = DateTime.parse(date);

    String fromdate = DateFormat('d MMM yyyy').format(dateTime1);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)
              // border: Border(bottom: BorderSide(color: Colors.grey)

              // ),

              // boxShadow: [
              //   BoxShadow(
              //     color:
              //         Colors.black.withOpacity(0.5), // Shadow color with opacity
              //     spreadRadius: 2, // Spread radius (how wide the shadow is)
              //     blurRadius: 3, // Blur radius (how soft the shadow is)
              //     offset: Offset(0, 3), // Shadow position (x, y)
              //   ),
              // ],
              ),
          child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Resons- ${allleavemodel!.Remarks}",
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  "$fromdate To $todate",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            trailing: Container(
              height: 30,
              width: 90,
              decoration: BoxDecoration(
                  border: Border.all(color: color!),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  text!,
                  style: TextStyle(color: color),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
