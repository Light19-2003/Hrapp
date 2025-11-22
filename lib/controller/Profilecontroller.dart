import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:hrapp/Model/ProfileModel.dart';
import 'package:http/http.dart' as http;
import 'package:hrapp/controller/LoginController.dart';

final controller = Get.put(Logincontroller());

class Profilecontroller extends GetxController {
  @override
  void onInit() {
    GetProfile();
    super.onInit();
  }

  var isLoading = false.obs;
  Profilemodel profilemodel = Profilemodel();
  ProfileModelReponse profileModelReponse = ProfileModelReponse();

  Uint8List? imageBytes; // To store the decoded image bytes

  Future<void> GetProfile() async {
    try {
      isLoading.value = true;
      final empid = controller.box.read("UserId");

      final String url =
          "http://rshrmsapapi.redsecure.online/api/HRMSWEBAPI/userdetails?empid=$empid&&authcode=${controller.box.read('AppCode')}";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final extractedData = jsonDecode(response.body);

        profileModelReponse.iserror = extractedData["isError"];
        profileModelReponse.errmag = extractedData['errorMsg'];

        profilemodel.id = extractedData["UserProFileData"]["ID"];
        profilemodel.empcode = extractedData["UserProFileData"]["EmpCode"];
        profilemodel.empname = extractedData["UserProFileData"]["EmpName"];
        profilemodel.email_work =
            extractedData["UserProFileData"]["Email_work"];
        profilemodel.designation =
            extractedData["UserProFileData"]["Department"];
        profilemodel.department =
            extractedData["UserProFileData"]["Designation"];
        profilemodel.currentaddress =
            extractedData["UserProFileData"]["CurrentAddress"];
        profilemodel.permanentaddress =
            extractedData["UserProFileData"]["PermanentAddress"];
        profilemodel.gender = extractedData["UserProFileData"]["Gender"];
        profilemodel.userimage = extractedData["UserProFileData"]["ProfilePic"];
        profilemodel.image = extractedData["UserProFileData"]["ProfilePic"];

        profileModelReponse.profilemodel = profilemodel;

        // Decode the Base64 image string if it exists
        if (profilemodel.image != null) {
          imageBytes = base64Decode(profilemodel.image!);
        }
      } else {
        print("Failed to load profile data.");
      }
    } catch (ex) {
      print("Error: ${ex.toString()}");
    } finally {
      isLoading.value = false; // Ensure loading is set to false in both success and failure cases
    }
  }
}
