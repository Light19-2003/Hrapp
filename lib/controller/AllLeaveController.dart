import 'dart:convert';

import 'package:get/get.dart';

import 'package:hrapp/Model/AllLeavemodel.dart';
// import 'package:hrapp/bulider/actvities.dart';
import 'package:hrapp/controller/LoginController.dart';
import 'package:http/http.dart' as http;

class Allleavecontroller extends GetxController {
  final login = Get.put(Logincontroller());
  var issumbitlist = <Allleavemodel>[].obs;
  AllLeaveReponse allLeaveReponse = AllLeaveReponse();
  // var savedlist = <Allleavemodel>[].obs;
  var approvedlist = <Allleavemodel>[].obs;
  var pendinglist = <Allleavemodel>[].obs;
  var rejectlist = <Allleavemodel>[].obs;
  RxBool isloading = false.obs;

  Future<void> FectchLeaverequest() async {
    isloading.value = true;
    try {
      int? empid = login.box.read("UserId");

      String url =
          'http://rshrmsapapi.redsecure.online/api/HRMSWEBAPI/IsSumbit?EmpId=$empid&authcode=${login.box.read('AppCode')}';

      final reponse = await http
          .post(Uri.parse(url), headers: {"Content-Type": "application/json"});

      if (reponse.statusCode == 200) {
        approvedlist.clear();
        pendinglist.clear();
        rejectlist.clear();
        issumbitlist.clear();
        final data = jsonDecode(reponse.body);

        allLeaveReponse.isError = data["isError"];
        allLeaveReponse.errorMsg = data["errorMsg"];

        final List body = data["savedleavelist1"];

        final allleave = data["allLeave1"];
        final List approved = allleave["approvedlist1"];
        final List pendding = allleave["pendinglist1"];
        final List reject = allleave["rejectedlist1"];

        for (int i = 0; i < body.length; i++) {
          Allleavemodel allleavemodel = Allleavemodel();

          allleavemodel.id = body[i]["ID"];
          allleavemodel.fromDate = body[i]["FromDate"];
          allleavemodel.todate = body[i]["ToDate"];
          allleavemodel.LeaveType = body[i]["LeaveId"];
          allleavemodel.Leave = body[i]["LeaveType"];
          allleavemodel.Leavedays = body[i]["Leavedays"];
          allleavemodel.Remarks = body[i]["Remarks"];
          allleavemodel.requiredDocument = body[i]["RequiredDocument"];
          allleavemodel.wfstatus = body[i]["wfstatus"];
          allleavemodel.ishalfday = body[i]["ishalfday"];
          allleavemodel.issumbit = body[i]["issumbit"];

          issumbitlist.add(allleavemodel);
        }

        for (int j = 0; j < approved.length; j++) {
          Allleavemodel allleavemodel = Allleavemodel();

          allleavemodel.id = approved[j]["ID"];
          allleavemodel.fromDate = approved[j]["FromDate"];
          allleavemodel.todate = approved[j]["ToDate"];
          allleavemodel.LeaveType = approved[j]["LeaveID"];
          allleavemodel.Leavedays = approved[j]["Leavedays"];
          allleavemodel.Leave = approved[j]["LeaveType"];
          allleavemodel.Remarks = approved[j]["Remarks"];
          allleavemodel.requiredDocument = approved[j]["RequiredDocument"];
          allleavemodel.wfstatus = approved[j]["wfstatus"];
          allleavemodel.ishalfday = approved[j]["ishalfday"];
          allleavemodel.issumbit = approved[j]["issumbit"];

          approvedlist.add(allleavemodel);
        }

        for (int a = 0; a < pendding.length; a++) {
          Allleavemodel allleavemodel = Allleavemodel();

          allleavemodel.id = pendding[a]["ID"];
          allleavemodel.fromDate = pendding[a]["FromDate"];
          allleavemodel.todate = pendding[a]["ToDate"];
          allleavemodel.LeaveType = pendding[a]["LeaveID"];
          allleavemodel.Leavedays = pendding[a]["Leavedays"];
          allleavemodel.Leave = pendding[a]["LeaveType"];
          allleavemodel.Remarks = pendding[a]["Remarks"];
          allleavemodel.requiredDocument = pendding[a]["RequiredDocument"];
          allleavemodel.wfstatus = pendding[a]["wfstatus"];
          allleavemodel.ishalfday = pendding[a]["ishalfday"];
          allleavemodel.issumbit = pendding[a]["issumbit"];

          pendinglist.add(allleavemodel);
        }

        for (int y = 0; y < reject.length; y++) {
          Allleavemodel allleavemodel = Allleavemodel();

          allleavemodel.id = reject[y]["ID"];
          allleavemodel.fromDate = reject[y]["FromDate"];
          allleavemodel.todate = reject[y]["ToDate"];
          allleavemodel.LeaveType = reject[y]["LeaveID"];
          allleavemodel.Leavedays = reject[y]["Leavedays"];
          allleavemodel.Leave = reject[y]["LeaveType"];
          allleavemodel.Remarks = reject[y]["Remarks"];
          allleavemodel.requiredDocument = reject[y]["RequiredDocument"];
          allleavemodel.wfstatus = reject[y]["wfstatus"];
          allleavemodel.ishalfday = reject[y]["ishalfday"];
          allleavemodel.issumbit = reject[y]["issumbit"];

          rejectlist.add(allleavemodel);
        }
      }
    } catch (ex) {
      print(ex.toString());
    }
    isloading.value = false;
  }
}
