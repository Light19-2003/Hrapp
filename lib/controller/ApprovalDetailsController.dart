import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hrapp/Model/Approval_detailsModl.dart';
import 'package:hrapp/Model/approvalleavemodel.dart';
import 'package:hrapp/controller/Attendencecontroller.dart';
import 'package:http/http.dart' as http;

class Approvaldetailscontroller extends GetxController {
  var approvalerlist = <ApprovalDetails>[].obs;
  RxInt count = 0.obs;
  var isLoading = false.obs; // 🔥 Add this line

  Approval_DetailsResponse approval_detailsResponse =
      Approval_DetailsResponse();
  int? empid = logincontroller.box.read("UserId");

  @override
  void onInit() {
    super.onInit();
    GetApprovaldetails();
  }

  Future<void> GetApprovaldetails() async {
    try {
      isLoading.value = true; // 🔥 Start loading

      String url =
          "http://rshrmsapapi.redsecure.online/api/HRMSWEBAPI/ApprovalDetails?empid=$empid&authcode=${logincontroller.box.read('AppCode')}";

      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        approvalerlist.clear();

        approval_detailsResponse.isError = data["isError"];
        approval_detailsResponse.errorMsg = data["errorMsg"];

        final applist = data["approval_Details"];

        for (var element in applist) {
          ApprovalDetails approvalDetails = ApprovalDetails();

          approvalDetails.id = element["Id"];
          approvalDetails.screenname = element["screenname"];
          approvalDetails.groupID = element["GroupId"];
          approvalDetails.appdetails = element["appdetails"];
          approvalDetails.screenID = element["ScreenID"];
          approvalDetails.recordID = element["RecordID"];

          final approvalleavedetails = element["ApprovelLeaveDetails"];
          ApprovalLeaveModel leaveModel = ApprovalLeaveModel();

          leaveModel.leaveRequestID = approvalleavedetails["LeaveRequestID"];
          leaveModel.requestDate =
              DateTime.tryParse(approvalleavedetails["RequestDate"] ?? '');
          leaveModel.fromDate =
              DateTime.tryParse(approvalleavedetails["FromDate"] ?? '');
          leaveModel.toDate =
              DateTime.tryParse(approvalleavedetails["ToDate"] ?? '');
          leaveModel.leaveDays = approvalleavedetails["LeaveDays"];
          leaveModel.empID = approvalleavedetails["EmpID"];
          leaveModel.leaveType = approvalleavedetails["LeaveType"];
          leaveModel.leave_Type = approvalleavedetails["Leave_Type"] ?? '';
          leaveModel.requiredDocument =
              approvalleavedetails["RequiredDocument"] ?? '';
          leaveModel.contactDetails =
              approvalleavedetails["ContactDetails"] ?? '';
          leaveModel.dateOfReturning =
              DateTime.tryParse(approvalleavedetails["DateOfReturning"] ?? '');
          leaveModel.duration = approvalleavedetails["Duration"] ?? '';
          leaveModel.departureDate =
              approvalleavedetails["DepartureDate"] ?? '';
          leaveModel.arrivalDate = approvalleavedetails["ArrivalDate"] ?? '';
          leaveModel.destination = approvalleavedetails["Destination"] ?? '';
          leaveModel.employeeName = approvalleavedetails["EmployeeName"] ?? '';
          leaveModel.department = approvalleavedetails["Department"] ?? '';
          leaveModel.dateOfJoining =
              DateTime.tryParse(approvalleavedetails["DateOfJoining"] ?? '');
          leaveModel.designation = approvalleavedetails["Designation"] ?? '';
          leaveModel.balance =
              (approvalleavedetails["Balance"] ?? 0).toDouble();
          leaveModel.balanceBefore =
              (approvalleavedetails["BalanceBefore"] ?? 0).toDouble();
          leaveModel.empSig = approvalleavedetails["EmpSig"] ?? '';
          leaveModel.remarks = approvalleavedetails["Remarks"] ?? '';
          leaveModel.wfStatus = approvalleavedetails["WFStatus"] ?? '';
          leaveModel.lrForm = approvalleavedetails["LR_Form"] ?? '';
          leaveModel.additionalLeaveMessage =
              approvalleavedetails["AdditionalLeaveMessage"] ?? '';
          leaveModel.isSubmit = approvalleavedetails["isSubmit"] ?? false;
          leaveModel.emailWork = approvalleavedetails["Email_Work"] ?? '';

          approvalDetails.approvalLeaveModel = leaveModel;
          approvalerlist.add(approvalDetails);
        }

        count.value = approvalerlist.length;
        approval_detailsResponse.approvaldetails = approvalerlist;
      }
    } catch (ex) {
      print(ex.toString());
    } finally {
      isLoading.value = false; // 🔥 Stop loading
    }
  }
}
