// ignore_for_file: avoid_unnecessary_containers, unused_local_variable

import 'package:e_comm/contoller/Sign_Up_Controller.dart';
import 'package:e_comm/screen/Auth_UI/Signin_Screen.dart';
import 'package:e_comm/utiles/App-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SignUpScreen> {
  final SignUpController signUpController = Get.put(SignUpController());
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userCityController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appSecondryColor,
            title: const Text(
              'Sign Up',
              style: TextStyle(color: AppConstant.appTextColor),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Wellcome to my App',
                      style: TextStyle(
                          color: AppConstant.appSecondryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: Get.height / 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: userEmailController,
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
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: userNameController,
                        cursorColor: AppConstant.appSecondryColor,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: 'UserName',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black))),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: userPhoneController,
                        cursorColor: AppConstant.appSecondryColor,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: 'Phone',
                            prefixIcon: const Icon(Icons.phone),
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
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: userCityController,
                        cursorColor: AppConstant.appSecondryColor,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                            hintText: 'Location',
                            prefixIcon: const Icon(Icons.location_pin),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black))),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: Get.width,
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Obx(
                          () => TextFormField(
                            controller: userPasswordController,
                            cursorColor: AppConstant.appSecondryColor,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText:
                                signUpController.isPasswwordVisible.value,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                prefixIcon: const Icon(Icons.password),
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      signUpController.isPasswwordVisible
                                          .toggle();
                                    },
                                    child: signUpController
                                            .isPasswwordVisible.value
                                        ? const Icon(Icons.visibility_off)
                                        : const Icon(Icons.visibility)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.black))),
                          ),
                        )),
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
                            String name = userNameController.text.trim();
                            String email = userEmailController.text.trim();
                            String phone = userPhoneController.text.trim();
                            String city = userCityController.text.trim();
                            String password =
                                userPasswordController.text.trim();
                            String userDeviceToken = '';

                            if (name.isEmpty ||
                                email.isEmpty ||
                                phone.isEmpty ||
                                city.isEmpty ||
                                password.isEmpty) {
                              Get.snackbar(
                                  'Error', "Please Fill all the Details",
                                  backgroundColor: AppConstant.appSecondryColor,
                                  colorText: AppConstant.appTextColor,
                                  snackPosition: SnackPosition.BOTTOM);
                            } else {
                              UserCredential? userCredential =
                                  await SignUpController().signUpWithEmail(
                                      name,
                                      email,
                                      phone,
                                      city,
                                      password,
                                      userDeviceToken);
                              if (userCredential != null) {
                                Get.snackbar('Verification Email send',
                                    'Please check your Email',
                                    backgroundColor:
                                        AppConstant.appSecondryColor,
                                    colorText: AppConstant.appTextColor,
                                    snackPosition: SnackPosition.BOTTOM);
                                FirebaseAuth.instance.signOut();
                                Get.offAll(() =>  const SignInScreen());
                              }
                            }
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(color: AppConstant.appTextColor),
                          ),
                        )),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an acount?",
                          style: TextStyle(
                            color: AppConstant.appSecondryColor,
                          )),
                      GestureDetector(
                        onTap: () => Get.offAll(() => const SignInScreen()),
                        child: const Text(" Sign In",
                            style: TextStyle(
                                color: AppConstant.appSecondryColor,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
