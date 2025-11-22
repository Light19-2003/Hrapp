import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';
import 'package:hrapp/Model/PayrollModel.dart';
import 'package:hrapp/controller/Payrollcontroller.dart';

class Table1 extends StatelessWidget {
  const Table1({super.key, required this.payrollmodel});

  final Payrollmodel payrollmodel;

  @override
  Widget build(BuildContext context) {
    final Payrollcontroller payrollController = Get.put(Payrollcontroller());

    final payrolllist = payrollmodel.payrolldetails!
        .where((ob) => ob.isallowance == true)
        .toList();

    //     List<payrollDetail> payrolllist =
    // payrollController.payrolldetails.where((ob) => ob.isallowance == true).toList();

    // payrollmodel.payrolldetails!
    //     .where((obj) => obj.isallowance == true)
    //     .toList();

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          if (payrolllist.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  "No allowances available.",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            )
          else
            // Wrap with SizedBox to give a fixed or limited height
            SizedBox(
              height: MediaQuery.of(context).size.height /
                  4, // 👈 adjust this height as per your UI
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: payrolllist.length,
                itemBuilder: (BuildContext context, int i) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${payrolllist[i].paytype}"),
                            Text("${payrolllist[i].amount}00"),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
