import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hrapp/Model/PayrollModel.dart';
import 'package:hrapp/common/ProfileTile.dart';
import 'package:hrapp/view/pages/Salaryslip.dart';

class Payrollwid extends StatelessWidget {
  const Payrollwid({super.key, required this.payrollmodel, required this.Year});

  final Payrollmodel payrollmodel;

  final String Year;

  @override
  Widget build(BuildContext context) {
    // final filteredList = payrollmodel
    //     .where((payroll) => payroll.processingYear.toString() == Year)
    //     .toList();

    return CommonTile(
      title: payrollmodel.dmonth!,
      icon: Icon(Icons.payment),
      subtitle: "BHD ${payrollmodel.netSalary}.000",
      onTap: () {
        Get.to(
          () => Salaryslip(payrollmodel: payrollmodel),
          transition: Transition.cupertinoDialog,
          duration: Duration.zero,
        );
      },
      trailingIcon: Icon(Icons.arrow_forward_ios, size: 20),
      elevation: 2,
      borderRadius: 12,
      // Optional professional touches:
      titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
      subtitleStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      iconBackgroundColor:
          Theme.of(context).colorScheme.primary.withOpacity(0.1),
      margin: EdgeInsets.only(bottom: 12),
    );
  }
}
