// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'package:e_comm/contoller/get_user_data_Controller.dart';
import 'package:e_comm/screen/Auth_UI/Wellcome_Screen.dart';
import 'package:e_comm/screen/admin_panal/Admin_main_Screen.dart';
import 'package:e_comm/screen/user_panel/Home_screen.dart';
import 'package:e_comm/utiles/App-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      isLogin(context);
    });
  }

  Future<void> isLogin(BuildContext context) async {
    if (user != null) {
      GetUserDataController getUserDataController =
          Get.put(GetUserDataController());
      var userData = await getUserDataController.getUserData(user!.uid);
      if (userData[0]['isAdmin'] == true) {
        Get.offAll(() => const AdminMainScreen());
      } else {
        Get.offAll(() => const HomeScreen());
      }
    } else {
      Get.to(() => WellcomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.appSecondryColor,
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondryColor,
        elevation: 0,
      ),
      // ignore: sized_box_for_whitespace
      body: Container(
        width: Get.width,
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Lottie.asset('assets/image/splash-icon.json'),
              ),
            ),
            Text(
              AppConstant.appPowerebBy,
              style: const TextStyle(
                  color: AppConstant.appTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
