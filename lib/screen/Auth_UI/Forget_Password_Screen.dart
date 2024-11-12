// ignore_for_file: avoid_unnecessary_containers, file_names
import 'package:e_comm/utiles/App-constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../contoller/Forget_Password_Controller.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});
  @override
  State<ForgetPasswordScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<ForgetPasswordScreen> {
  final ForgetPasswordController forgetPasswordController =
      Get.put(ForgetPasswordController());
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appSecondryColor,
            title: const Text(
              'Forget Password',
              style: TextStyle(color: AppConstant.appTextColor),
            ),
            centerTitle: true,
          ),
          body: Container(
            child: Column(
              children: [
                isKeyboardVisible
                    ? const Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Text(
                          'Wellcome to my App',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      )
                    : Column(
                        children: [
                          Lottie.asset('assets/image/splash-icon.json'),
                        ],
                      ),
                SizedBox(
                  height: Get.height / 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: emailController,
                      cursorColor: AppConstant.appSecondryColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Emial',
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black))),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height / 90,
                ),
                const SizedBox(height: 20),
                Material(
                  child: Container(
                      decoration: BoxDecoration(
                          color: AppConstant.appSecondryColor,
                          borderRadius: BorderRadius.circular(20)),
                      width: Get.width / 2,
                      height: Get.height / 16,
                      child: TextButton(
                        onPressed: () async {
                          String email = emailController.text.trim();
                          if (email.isEmpty) {
                            Get.snackbar('Error', 'Please fill the details ',
                                backgroundColor: AppConstant.appSecondryColor,
                                colorText: AppConstant.appTextColor,
                                snackPosition: SnackPosition.BOTTOM);
                          } else {
                            forgetPasswordController
                                .forgetPasswordController(email);
                          }
                        },
                        child: const Text(
                          'Forget',
                          style: TextStyle(color: AppConstant.appTextColor),
                        ),
                      )),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
