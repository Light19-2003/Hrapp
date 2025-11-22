import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';
import 'package:hrapp/Model/PayrollModel.dart';
import 'package:hrapp/controller/Payrollcontroller.dart';

class Deduction extends StatelessWidget {
  const Deduction({super.key, required this.payrollmodel});

  final Payrollmodel payrollmodel;

  @override
  Widget build(BuildContext context) {
    List<payrollDetail> payrolllist = payrollmodel.payrolldetails!
        .where((p0) => p0.isallowance == false)
        .toList();

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
                  "No Deduction available",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.normal),
                ),
              ),
            )
          else
            // ✅ Fix: wrap ListView.builder in a SizedBox or Expanded
            SizedBox(
              height: 100, // 👈 set height as per your layout
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: payrolllist.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${payrolllist[index].paytype}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${payrolllist[index].amount}00",
                              style: TextStyle(color: Colors.grey),
                            ),
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
