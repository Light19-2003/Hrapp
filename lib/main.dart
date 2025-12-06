import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:get_storage/get_storage.dart';
import 'package:hrapp/Login/NewLoginScreen.dart';
import 'package:hrapp/Testing/TimeLine.dart';

import 'package:hrapp/Themecolor/Palette.dart';

import 'package:hrapp/controller/LoginController.dart';
import 'package:hrapp/view/Auth_Screen/Auth.dart';
import 'package:hrapp/view/Auth_Screen/UserCheack.dart';
import 'package:hrapp/view/TimeSheet/Time_screen.dart';

import 'package:hrapp/view/navbar.dart';

import 'package:hrapp/view/pages/Login2.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:upgrader/upgrader.dart';

// import 'package:hrapp/homeapge.dart';
// import 'package:hrapp/view/navbar.dart';
// import 'package:hrapp/view/pages/Loginpage.dart';
// import 'package:hrapp/view/pages/Salaryslip.dart';
// import 'package:hrapp/view/pages/leavedashboard.dart';
// import 'package:hrapp/view/pages/leavepage.dart';
// import 'package:hrapp/view/pages/testscreen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Android settings
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // ✅ iOS settings
  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(); // Use this instead of old IOSInitializationSettings

  // ✅ Combine both
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  // ✅ Initialize plugin
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Other initializations
  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final login = Get.put(Logincontroller());

    // int? id = login.box.read("UserId");

    RSHRMSTheme rshrmsTheme = RSHRMSTheme();

    Widget initialScreen;

    final userid = login.box.read("UserId");
    final isauth = login.box.read("isauth");

    final appcode = login.box.read("AppCode");

    // if (userid != null && isauth == true) {
    //   initialScreen = AuthScreen();
    // } else if (userid != null && isauth == false) {
    //   initialScreen = Navbar();
    // } else {
    //   initialScreen = Login2();
    // }

    // if (appcode != null) {
    //   initialScreen = Newloginscreen();
    // } else if (userid != null) {
    //   if (isauth == true) {
    //     initialScreen = AuthScreen();
    //   } else {
    //     initialScreen = Navbar();
    //   }
    // } else {
    //   initialScreen = UserCheack();
    // }

    if (appcode == null) {
      initialScreen = UserCheack();
    } else if (userid == null && isauth == false) {
      initialScreen = Newloginscreen();
    } else if (userid != null && isauth == true) {
      initialScreen = AuthScreen();
    } else {
      initialScreen = Navbar();
    }

    return ScreenUtilInit(
        designSize: const Size(370, 825),
        minTextAdapt: true,
        splitScreenMode: true,
        child: GetMaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', 'US'),
            const Locale('hi', ''), // Hindi
          ],
          theme: rshrmsTheme.hrapptheme,
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          // initialRoute: '/',
          // getPages: [
          //   // GetPage(name: '/', page: () => HomeScreen()),
          //   GetPage(name: '/', page: () => const Testscreen()),
          //   GetPage(name: '/leavedashboard', page: () => Leavedashboard()),
          // ],
          // routes: {'/leavedashboard': (context) => Leavedashboard()},
          //  if userid has value it will go in navbar else  login

          home: UpgradeAlert(
            upgrader: Upgrader(
                messages: UpgraderMessages(
              code: "Update",
            )),
            child: initialScreen,
          ),
        ));
  }
}
