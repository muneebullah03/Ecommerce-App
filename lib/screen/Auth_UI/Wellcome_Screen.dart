// ignore_for_file: must_be_immutable, avoid_unnecessary_containers

import 'package:e_comm/screen/Auth_UI/Signin_Screen.dart';
import 'package:e_comm/utiles/App-constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../contoller/Google_Sign_In_Controller.dart';

class WellcomeScreen extends StatelessWidget {
  WellcomeScreen({super.key});

  // ignore: prefer_final_fields
  SignInController _signInController = Get.put(SignInController());

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
                'Happy Shopping',
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
                      onPressed: () {
                        _signInController.signInWithGoogle();
                      },
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
                      onPressed: () {
                        Get.to(() => const SignInScreen());
                      },
                      label: const Text(
                        '  Sign in with Email',
                        style: TextStyle(color: AppConstant.appTextColor),
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
