import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';

class LocalLogin extends GetxController {
  LocalAuthentication auth = LocalAuthentication();
  final box = GetStorage();
  Future<bool> localAuth() async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    bool isDeviceSupported = await auth.isDeviceSupported();

    if (!canCheckBiometrics || !isDeviceSupported) {
      return false;
    }

    try {
      bool isauth = await auth.authenticate(
          localizedReason: "Authentification",
          options: const AuthenticationOptions(
              stickyAuth: true, biometricOnly: true));

      return isauth;
    } catch (ex) {
      print(ex);

      return false;
    }
  }
}
