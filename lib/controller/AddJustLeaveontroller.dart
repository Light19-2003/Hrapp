import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class addjustleavecontroller extends GetxController {
  Future<void> addjustleave(int? leaveid, String reason) async {
    final url =
        "https://rshrmsapapi.redsecure.online/api/HRMSWEBAPI/AddjustLeave";

    Map<String, dynamic> body = {
      "LeaveId": leaveid,
      "Status": reason,
    };

    try {
      final res = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        print(data);

        final iserror = data["isError"];

        if (iserror == false) {
          print("success");
        } else {
          print("error");
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
