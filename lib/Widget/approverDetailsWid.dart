import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrapp/Model/Approval_detailsModl.dart';
import 'package:hrapp/Themecolor/Palette.dart';
import 'package:hrapp/Themecolor/appimages.dart';
import 'package:hrapp/view/pages/ViewDetailsScreen.dart';

class Approverdetailswid extends StatelessWidget {
  Approverdetailswid({super.key, required this.approvalDetails});

  ApprovalDetails approvalDetails;

  @override
  @override
  Widget build(BuildContext context) {
    String? status;

    if (approvalDetails.Status == "P") {
      status = "Pending";
    }

    Color? color;

    if (approvalDetails.remarks == null) {
      status = '';
    } else {
      status = approvalDetails.remarks;
    }

    if (approvalDetails.Status == "P") {
      color = Colors.yellow;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Get.to(
            () => Viewdetailsscreen(
              approvalDetails: approvalDetails,
            ),
          );
        },
        child: Card(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40.h,
                        width: 35.w,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          // color: Color(0xFF0A1D48),
                          // gradient: LinearGradient(
                          //   colors:Color(0xFF0A1D48),
                          //   begin: Alignment.topRight,
                          //   end: Alignment.bottomLeft,
                          // ),
                          // color: getRandomBlueShade(),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Image(
                          image: AssetImage(
                            Appimages.calender,
                          ),
                          color: Palette.Kmain,
                          width: 25.w,
                          height: 20.h,
                        ),
                      ),

                      // Container(
                      //     height: 35.h,
                      //     width: MediaQuery.of(context).size.width * 0.34,
                      //     decoration: BoxDecoration(
                      //       border: Border.all(color: Colors.amber),
                      //       color: Colors.amber[100],
                      //     ),
                      //     child:

                      //         ),
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${approvalDetails.screenname}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),

                      // Icon(Icons.calendar_month),
                    ],
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text(
                        //   "Emp Name",
                        //   style:
                        //       TextStyle(color: Colors.grey[500], fontSize: 12),
                        // ),
                        // Text(
                        //   "Leave Details",
                        //   style:
                        //       TextStyle(color: Colors.grey[500], fontSize: 12),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 150.w,
                          child: Text(
                            "${approvalDetails.appdetails}",
                            overflow: TextOverflow.clip,
                            softWrap: true,
                            maxLines: 2,
                          ),
                        ),
                        // Text("Sick leave")
                      ],
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     children: [
                  //       Text(
                  //         "Approver Name",
                  //         style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  //       ),
                  //       Text(
                  //         "from date",
                  //         style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: [
                  //     Text(
                  //       "${approvalDetails.Approver_User_Name}",
                  //       style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                  //     ),
                  //     Text("12-dec-2024")
                  //   ],
                  // ),
                  SizedBox(
                    height: 5,
                  ),

                  Row(
                    children: [
                      Container(
                        height: 40.h,
                        width: MediaQuery.of(context).size.width / 1.2,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(15)),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "View Details",
                              style: TextStyle(color: Colors.blue),
                            )),
                      )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
