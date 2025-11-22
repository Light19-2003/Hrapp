import 'dart:typed_data';

class Dashboardmodel {
  bool? isError;
  String? errorMsg;
  bool? markatt;

  List<LeaveDataModel>? leavedata;

  List<UpcomingActivites>? upcomingactivies;

  List<UpcomingBrithday>? upcomingbrithday;

  GetTime? getime;
}

class LeaveDataModel {
  int? id;
  String? empname;
  String? leavetypes;

  // int? leavedata;

  int? leavebf;
  int? daystaken;
  double? balance;
}

class UpcomingActivites {
  int? id;
  String? meassage;
}

class UpcomingBrithday {
  int? empcode;

  String? empname;
  String? emailwork;
  String? dob;
  Uint8List? imageBytes;

  String? userimage;
}

class GetTime {
  String? signin;
  String? signout;
}
