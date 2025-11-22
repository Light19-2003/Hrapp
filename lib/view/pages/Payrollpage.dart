import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hrapp/bulider/payrollbulider.dart';
import 'package:hrapp/controller/Payrollcontroller.dart';

class Payrollpage extends StatefulWidget {
  const Payrollpage({super.key});

  @override
  State<Payrollpage> createState() => _PayrollpageState();
}

class _PayrollpageState extends State<Payrollpage> {
  String selectedYear = '2025'; // Default year
  final List<String> years = [
    '2024',
    '2025',
  ];

  @override
  Widget build(BuildContext context) {
    final Payrollcontroller payrollController = Get.put(Payrollcontroller());

    payrollController.Getpayroll();
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButton<String>(
              value: selectedYear,
              dropdownColor: Colors.white,
              underline: SizedBox(), // Removes underline
              icon: Icon(Icons.arrow_drop_down, color: Colors.white),
              style: TextStyle(color: Colors.white, fontSize: 16),
              items: years.map((String year) {
                return DropdownMenuItem<String>(
                  value: year,
                  child: Text(year, style: TextStyle(color: Colors.black)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedYear = newValue!;
                });
                // fetchPayrollForYear(selectedYear); // Call your API or logic
              },
            ),
          ),
        ],
        backgroundColor: Colors.grey[100],
        title: Text(
          "Payroll",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        elevation: 5,
        excludeHeaderSemantics: true,
        centerTitle: true,
      ),
      body: Obx(() {
        if (payrollController.isloading.value) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else {
          return PayrollBuilder(
            Year: selectedYear,
          );
        }
      }),
    );
  }
}
