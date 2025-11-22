import 'dart:convert';
import 'package:get/get.dart';
import 'package:hrapp/Model/PayrollModel.dart';
import 'package:hrapp/controller/LoginController.dart';
import 'package:http/http.dart' as http;

final Logincontroller loginController = Get.find<Logincontroller>();

class Payrollcontroller extends GetxController {
  @override
  void onInit() {
    Getpayroll();
    super.onInit();
  }

  var payrolllist = <Payrollmodel>[].obs;
  RxString Year = "2024".obs;

  PayrollReponse payrollReponse = PayrollReponse();
  RxBool isloading = false.obs;

  Future<void> Getpayroll() async {
    isloading.value = true;

    try {
      int? empid = loginController.box.read("UserId");
      String url =
          "http://rshrmsapapi.redsecure.online/api/HRMSWEBAPI/payroll?empid=$empid&authcode=${loginController.box.read('AppCode')}";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        payrolllist.clear();

        final data = jsonDecode(response.body);

        payrollReponse.iserror = data["iserror"];
        payrollReponse.errorMsg = data["errorMsg"];

        final List pay = data["SalarySlip"];

        for (int i = 0; i < pay.length; i++) {
          Payrollmodel payrollmodel = Payrollmodel();

          payrollmodel.id = pay[i]["id"];
          payrollmodel.Empid = pay[i]["EmpId"];
          payrollmodel.empname = pay[i]["EmpName"];
          payrollmodel.dmonth = pay[i]["D_Month"];
          payrollmodel.processingYear = pay[i]["ProcessingYear"];
          payrollmodel.netSalary = pay[i]["NetSalary"];
          payrollmodel.payslipfile = pay[i]["payslipfile"];

          // ✅ Create a new list for each payroll entry
          List<payrollDetail> detailsList = [];

          final payroll1 = pay[i]["payrollDetail"];
          for (int j = 0; j < payroll1.length; j++) {
            payrollDetail payrolldetail = payrollDetail();

            payrolldetail.paytype = payroll1[j]["Paytype"];
            payrolldetail.amount = payroll1[j]["Amount"];
            payrolldetail.isallowance = payroll1[j]["isallowance"];

            detailsList.add(payrolldetail);
          }

          payrollmodel.payrolldetails = detailsList;

          payrolllist.add(payrollmodel);
          print("Payroll ID: ${payrollmodel.id}");
        }
      } else {
        print("Failed to load payroll: ${response.statusCode}");
      }
    } catch (ex) {
      print("Error: $ex");
    }

    isloading.value = false;
  }
}
