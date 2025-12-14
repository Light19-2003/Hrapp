import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hrapp/Model/Approval_detailsModl.dart';
import 'package:hrapp/Model/approvalleavemodel.dart';
import 'package:http/http.dart' as http;

class Approvaldetailscontroller extends GetxController {
  var approvalerlist = <ApprovalDetails>[].obs;
  var isLoading = false.obs;
  RxInt count = 0.obs;

  Approval_DetailsResponse approval_detailsResponse =
      Approval_DetailsResponse();

  @override
  void onInit() {
    super.onInit();
    GetApprovaldetails();
  }

  Future<void> GetApprovaldetails() async {
    try {
      GetStorage box = GetStorage();
      int? empid = box.read("UserId");
      isLoading.value = true;

      String url =
          "http://rshrmsapapi.redsecure.online/api/HRMSWEBAPI/ApprovalDetails?empid=$empid&authcode=${box.read('AppCode')}";

      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);

        approvalerlist.clear();

        final listData = result["approval_Details"] ?? [];

        for (var item in listData) {
          ApprovalDetails model = ApprovalDetails();

          // BASE DETAILS
          model.id = item["Id"];
          model.groupID = item["GroupId"];
          model.screenname = item["screenname"];
          model.appdetails = item["appdetails"];
          model.screenID = item["ScreenID"];
          model.recordID = item["RecordID"];

          // LEAVE MODEL
          var leave = item["ApprovelLeaveDetails"];

          ApprovalLeaveModel leaveModel = ApprovalLeaveModel();
          leaveModel.leaveRequestID = leave["LeaveRequestID"];
          leaveModel.requestDate = DateTime.tryParse(leave["RequestDate"]);
          leaveModel.fromDate = DateTime.tryParse(leave["FromDate"]);
          leaveModel.toDate = DateTime.tryParse(leave["ToDate"]);
          leaveModel.leaveDays = leave["LeaveDays"];
          leaveModel.empID = leave["EmpID"];
          leaveModel.leaveType = leave["LeaveType"];
          leaveModel.leave_Type = leave["Leave_Type"];
          leaveModel.employeeName = leave["EmployeeName"];
          leaveModel.department = leave["Department"];
          leaveModel.designation = leave["Designation"];
          leaveModel.remarks = leave["Remarks"];
          leaveModel.wfStatus = leave["WFStatus"];
          leaveModel.balance = (leave["Balance"] ?? 0.0).toDouble();
          leaveModel.balanceBefore = (leave["BalanceBefore"] ?? 0.0).toDouble();
          leaveModel.additionalLeaveMessage = leave["AdditionalLeaveMessage"];
          leaveModel.isSubmit = leave["isSubmit"];

          model.approvalLeaveModel = leaveModel;

          // TIMESHEET LIST
          List timesheetList = item["approvalTimeSheetDetails"] ?? [];

          List<ApprovalTimeSheetDetails> tempSheetList = [];

          for (var sheet in timesheetList) {
            ApprovalTimeSheetDetails tSheet = ApprovalTimeSheetDetails();

            /// JSON data EXACT KEY MATCHES 🚀
            tSheet.Task = sheet["Task"] ?? '';
            tSheet.time = sheet["TotalHour"] ?? '';
            tSheet.ProjectCode = sheet["projectCode"] ?? '';
            tSheet.Notes = sheet["code"] ?? '';

            tempSheetList.add(tSheet);
          }

          model.appTimeSheet = tempSheetList;

          approvalerlist.add(model);
        }

        count.value = approvalerlist.length;
        approval_detailsResponse.approvaldetails = approvalerlist;
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
