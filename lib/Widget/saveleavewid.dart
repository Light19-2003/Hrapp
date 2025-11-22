import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';
import 'package:hrapp/Model/AllLeavemodel.dart';
import 'package:hrapp/bulider/actvities.dart';
import 'package:hrapp/controller/AllLeaveController.dart';
import 'package:hrapp/controller/DeleteController.dart';
import 'package:hrapp/view/pages/fromeditscreen.dart';
import 'package:hrapp/view/pages/fromeditscreen2.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class Saveleavewid extends StatelessWidget {
  const Saveleavewid({super.key, required this.allleavemodel});

  final Allleavemodel allleavemodel;

  @override
  Widget build(BuildContext context) {
    Deletecontroller delete = Get.put(Deletecontroller());
    final allleave = Get.put(Allleavecontroller());
    // final Savedleave = Get.put(Allleavecontroller());

    String date1 = allleavemodel.todate.toString();
    DateTime dateTime1 = DateTime.parse(date1);

    String todate = DateFormat('d MMM yyyy').format(dateTime1).toLowerCase();

    String? newtodate;

    String? to;

    if (todate == "1 jan 0001") {
      newtodate = ""; // You don't need to assign todate again
      to = "";
    } else {
      newtodate = todate;
      to = "to";
    }

    String date = allleavemodel.fromDate.toString();
    DateTime dateTime = DateTime.parse(date);

    String fromdate = DateFormat('d MMM yyyy').format(dateTime);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Slidable(
          key: Key(allleavemodel.id.toString()),
          endActionPane: ActionPane(motion: StretchMotion(), children: [
            SlidableAction(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              onPressed: (context) {
                delete.delete(allleavemodel.id!);

                delete.refreshScreen();
              },
              backgroundColor: Colors.red,
              icon: Icons.delete,
              label: 'Delete',
            )
          ]),
          child: ListTile(
              // leading: Column(
              //   children: [
              //     Text("${allleavemodel.Remarks}"),
              //     Text(
              //       " $fromdate To  $todate ",
              //       style: TextStyle(fontSize: 10),
              //     ),
              //   ],
              // ),
              title: Text(
                "${allleavemodel.Remarks}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "$newtodate $to $fromdate",
                style: TextStyle(fontSize: 10),
              ),
              trailing: ElevatedButton.icon(
                  onPressed: () {
                    Get.to(() => Fromeditscreen2(
                          allleavemodel: allleavemodel,
                        ));
                  },
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.green)),
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 15,
                  ),
                  label: Text(
                    'Edit',
                    style: TextStyle(color: Colors.white),
                  ))),
        ),
      ),
    );
  }
}
