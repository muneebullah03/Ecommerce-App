import 'package:e_comm/utiles/App-constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class WellcomeScreen extends StatefulWidget {
  const WellcomeScreen({super.key});

  @override
  State<WellcomeScreen> createState() => _WellcomeScreenState();
}

class _WellcomeScreenState extends State<WellcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondryColor,
        title: const Text('Wellcome to my App'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Lottie.asset('assets/image/splash-icon.json'),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Text(
                'Happing Shopping',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: Get.height / 12,
            ),
            Material(
              child: Container(
                  decoration: BoxDecoration(
                      color: AppConstant.appSecondryColor,
                      borderRadius: BorderRadius.circular(20)),
                  width: Get.width / 1.2,
                  height: Get.height / 12,
                  child: TextButton.icon(
                      icon: Image.asset(
                        'assets/image/final-google-logo.png',
                        width: Get.width / 12,
                        height: Get.height / 1.2,
                      ),
                      onPressed: () {},
                      label: const Text(
                        'Sign in with google',
                        style: TextStyle(color: AppConstant.appTextColor),
                      ))),
            ),
            SizedBox(
              height: Get.height / 50,
            ),
            Material(
              child: Container(
                  decoration: BoxDecoration(
                      color: AppConstant.appSecondryColor,
                      borderRadius: BorderRadius.circular(20)),
                  width: Get.width / 1.2,
                  height: Get.height / 12,
                  child: TextButton.icon(
                      icon: const Icon(
                        Icons.email,
                        color: AppConstant.appTextColor,
                      ),
                      onPressed: () {},
                      label: const Text(
                        '  Sign in with google',
                        style: TextStyle(color: AppConstant.appTextColor),
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
