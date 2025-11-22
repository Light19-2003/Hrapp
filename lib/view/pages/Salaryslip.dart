import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrapp/Model/PayrollModel.dart';
import 'package:hrapp/Widget/Salarywid.dart';
import 'package:hrapp/Widget/deduction.dart';
import 'package:hrapp/Widget/table1.dart';
import 'package:hrapp/bulider/actvities.dart';
import 'package:hrapp/common/ccustomappbar.dart';
import 'package:hrapp/constants/constants.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:number_to_words_english/number_to_words_english.dart';

class Salaryslip extends StatelessWidget {
  const Salaryslip({super.key, required this.payrollmodel});

  final Payrollmodel payrollmodel;

  @override
  Widget build(BuildContext context) {
    int? number = payrollmodel.netSalary;

    String? words;

    if (number != null) {
      words = NumberToWordsEnglish.convert(number);
      print(words); // Output: Eight hundred twenty-four
    } else {}

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          title: Text(
            "Salary Slip",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          elevation: 5,
          excludeHeaderSemantics: true,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(10)),
                  child: Salarywid(
                    payrollmodel: payrollmodel,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(),
                Row(
                  children: [
                    Text(
                      "Earning",
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    )
                  ],
                ),
                Table1(
                  payrollmodel: payrollmodel,
                ),
                Row(
                  children: [
                    Text(
                      "Deduction",
                      style: TextStyle(color: Colors.black, fontSize: 22),
                    )
                  ],
                ),
                Deduction(
                  payrollmodel: payrollmodel,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      " Total Salary - BHD${payrollmodel.netSalary.toString()}.000",
                      style: TextStyle(fontSize: 22),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Text(
                        "Total Salary(in words) -",
                        style: GoogleFonts.aBeeZee(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "${words!.toUpperCase()} Bahraini Dinar",
                        style: GoogleFonts.aBeeZee(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Image.asset(
                    //   "assets/Signature.jpg",
                    //   height: 50,
                    // ),
                    Image.network(
                      "https://res.cloudinary.com/dbi2izwfz/image/upload/v1747047454/4_eapumo.png",
                      height: 120.h,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Prepared by",
                      style: GoogleFonts.aBeeZee(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "HR Department",
                      style: GoogleFonts.aBeeZee(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "${payrollmodel.dmonth! + " " + payrollmodel.processingYear.toString()}",
                      style: GoogleFonts.aBeeZee(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
