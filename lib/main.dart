import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_task/screens/splash_screen.dart';
import 'package:new_task/state_management/state_management.dart';
import 'package:new_task/theme/app_theme.dart';

void main() {
  Get.put(StateController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Employee Management App',
      debugShowCheckedModeBanner: false,

      theme: lightTheme,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,

      home: SplashScreen(),
    );
  }
}
