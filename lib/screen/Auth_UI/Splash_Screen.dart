import 'dart:async';
import 'package:e_comm/screen/Auth_UI/Wellcome_Screen.dart';
import 'package:e_comm/utiles/App-constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Get.offAll(const WellcomeScreen());
    });
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
