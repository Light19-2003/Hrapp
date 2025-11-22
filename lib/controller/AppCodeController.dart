import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hrapp/Login/NewLoginScreen.dart';
import 'package:http/http.dart' as http;

class CodeController extends GetxController {
  TextEditingController appcode = TextEditingController();
  final box = GetStorage();

  RxBool isloading = false.obs;
  Future<void> checkAppCode() async {
    try {
      isloading.value = true;
      final String code = appcode.text;

      final url =
          'https://rshrmsapapi.redsecure.online/api/HRMSWEBAPI/AppcodeCheack?authcode=$code';

      print(url);
      final response = await http.get(Uri.parse(url));

      print(response.body);

      if (response.statusCode == 200) {
        print("sucess");
        final appcode = box.write('AppCode', code);
        print(appcode);

        Get.offAll(() => Newloginscreen());
        Get.snackbar("Success", "App code is valid");
      } else {
        print("error");
        Get.snackbar("Error", "App code is invalid");
      }
    } catch (e) {
      print(e);
    } finally {
      isloading.value = false;
    }
  }
}
