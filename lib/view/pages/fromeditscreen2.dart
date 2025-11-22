import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrapp/Model/AllLeavemodel.dart';
import 'package:hrapp/controller/updatedleavecontroller.dart';
import 'package:hrapp/view/pages/approvedpage%20copy.dart';
import 'package:intl/intl.dart';

class Fromeditscreen2 extends StatefulWidget {
  final Allleavemodel allleavemodel;

  const Fromeditscreen2({super.key, required this.allleavemodel});

  @override
  State<Fromeditscreen2> createState() => _Fromeditscreen2State();
}

class _Fromeditscreen2State extends State<Fromeditscreen2> {
  final updatedleavecontroller = Get.put(Updatedleavecontroller());
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // Set remarks
    updatedleavecontroller.remarkcontroller.text =
        widget.allleavemodel.Remarks ?? '';

    // Format and set dates
    final fromDateTime =
        DateTime.parse(widget.allleavemodel.fromDate.toString());
    final toDateTime = DateTime.parse(widget.allleavemodel.todate.toString());
    final fromDateFormatted = DateFormat('d MMM yyyy').format(fromDateTime);
    final toDateFormatted = DateFormat('d MMM yyyy').format(toDateTime);

    String todate = DateFormat('d MMM yyyy').format(toDateTime).toLowerCase();

    String? newtodate;

    String? to;

    if (todate == "1 jan 0001") {
      newtodate = ""; // You don't need to assign todate again
      to = "";
    } else {
      newtodate = toDateFormatted;
      to = "-";
    }

    updatedleavecontroller.fromdatecontroller.text = fromDateFormatted;
    updatedleavecontroller.todatecontroller.text =
        "$newtodate $to $fromDateFormatted";
    updatedleavecontroller.startdate = fromDateFormatted;
    updatedleavecontroller.enddate = toDateFormatted;
    updatedleavecontroller.Leavesdays.text =
        widget.allleavemodel.Leavedays.toString();

    // Set default leave type for DropDownTextField
    final leaveTypeValue = widget.allleavemodel.LeaveType ?? 0;
    const leaveOptions = [
      DropDownValueModel(name: "Annual Leave", value: 1),
      DropDownValueModel(name: "Sick", value: 2),
      DropDownValueModel(name: "Sick Leave Half Pay", value: 4),
      DropDownValueModel(name: "Unpaid Leave", value: 10004),
      DropDownValueModel(name: "Sick Leave Without Pay", value: 20013),
      DropDownValueModel(name: "Half Day Leave", value: 40015),
      DropDownValueModel(name: "Covid Leave", value: 20005),
      DropDownValueModel(name: "Bereavement Leave", value: 20008),
      DropDownValueModel(name: "Marriage Leave", value: 20011),
      DropDownValueModel(name: "Maternity Leave", value: 20012),
      DropDownValueModel(name: "Emergency Leave", value: 30015),
      DropDownValueModel(name: "Hajj Leave", value: 20014),
      DropDownValueModel(name: "Umrah Leave", value: 20015),
    ];

    // Find the matching leave type
    final selectedModel = leaveOptions.firstWhere(
      (element) => element.value == leaveTypeValue,
      orElse: () => const DropDownValueModel(name: "Unknown", value: 0),
    );

    // Set the default value in the controller
    if (selectedModel.value != 0) {
      updatedleavecontroller.cnt.setDropDown(selectedModel);
      updatedleavecontroller.selectedLeaveType = selectedModel.value;
    }

    print("Selected Leave Type: ${updatedleavecontroller.selectedLeaveType}");
  }

  @override
  Widget build(BuildContext context) {
    void fromsubmit() async {
      if (_formkey.currentState!.validate()) {
        updatedleavecontroller.WFStatuscontroller.text = 'P';
        updatedleavecontroller.ishalfday = false;
        updatedleavecontroller.issubmit = true;
        await updatedleavecontroller.Updatedleave(widget.allleavemodel.id);

        Get.snackbar(
          'Success',
          'Leave successfully Updated',
          snackPosition: SnackPosition.top,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.off(() => ApprovedPage2());
      } else {
        Get.snackbar(
          'Error',
          'Please fill all required fields',
          snackPosition: SnackPosition.top,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }

    Future<void> pickDateRange(BuildContext context) async {
      final now = DateTime.now();
      final startDate = now;
      final endDate = DateTime(now.year, now.month + 6, now.day);

      final pickedRange = await showDateRangePicker(
        context: context,
        firstDate: startDate,
        lastDate: endDate,
      );

      if (pickedRange != null) {
        final formatter = DateFormat('d MMM yyyy');
        final formattedStartDate = formatter.format(pickedRange.start);
        final formattedEndDate = formatter.format(pickedRange.end);

        updatedleavecontroller.todatecontroller.text =
            "$formattedStartDate - $formattedEndDate";
        updatedleavecontroller.startdate = formattedStartDate;
        updatedleavecontroller.enddate = formattedEndDate;
        await updatedleavecontroller.Getdayscal();
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: const Text(
          "Leave Edit",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        elevation: 5,
        centerTitle: true,
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onTap: () => pickDateRange(context),
                  controller: updatedleavecontroller.todatecontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    label: const Text("Choose any date"),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter any date";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  readOnly: true,
                  controller: updatedleavecontroller.Leavesdays,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    label: const Text("Leave Days"),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropDownTextField(
                  enableSearch: true,
                  controller: updatedleavecontroller
                      .cnt, // Use cnt instead of controller
                  clearIconProperty: IconProperty(color: Colors.green),
                  searchTextStyle: const TextStyle(color: Colors.red),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your leave type";
                    }
                    return null;
                  },
                  dropDownItemCount: 13,
                  dropDownList: const [
                    DropDownValueModel(name: "Annual Leave", value: 1),
                    DropDownValueModel(name: "Sick", value: 2),
                    DropDownValueModel(name: "Sick Leave Half Pay", value: 4),
                    DropDownValueModel(name: "Unpaid Leave", value: 10004),
                    DropDownValueModel(
                        name: "Sick Leave Without Pay", value: 20013),
                    DropDownValueModel(name: "Half Day Leave", value: 40015),
                    DropDownValueModel(name: "Covid Leave", value: 20005),
                    DropDownValueModel(name: "Bereavement Leave", value: 20008),
                    DropDownValueModel(name: "Marriage Leave", value: 20011),
                    DropDownValueModel(name: "Maternity Leave", value: 20012),
                    DropDownValueModel(name: "Emergency Leave", value: 30015),
                    DropDownValueModel(name: "Hajj Leave", value: 20014),
                    DropDownValueModel(name: "Umrah Leave", value: 20015),
                  ],
                  textFieldDecoration: const InputDecoration(
                    hintText: "Select the leave type",
                  ),
                  onChanged: (val) {
                    if (val is DropDownValueModel) {
                      updatedleavecontroller.selectedLeaveType = val.value;
                      print("Selected Leave Type ID: ${val.value}");
                    }
                  },
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: updatedleavecontroller.remarkcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    label: const Text("Enter the remarks"),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your remarks";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: fromsubmit,
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    height: 50,
                    minWidth: MediaQuery.of(context).size.width * 0.4,
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
