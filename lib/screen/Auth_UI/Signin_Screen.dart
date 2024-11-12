// ignore_for_file: avoid_unnecessary_containers, unnecessary_null_comparison
import 'package:e_comm/screen/Auth_UI/Forget_Password_Screen.dart';
import 'package:e_comm/screen/Auth_UI/SignUp_Screen.dart';
import 'package:e_comm/screen/admin_panal/Admin_main_Screen.dart';
import 'package:e_comm/screen/user_panel/Home_screen.dart';
import 'package:e_comm/utiles/App-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../contoller/SignIn_Controller.dart';
import '../../contoller/get_user_data_Controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SignInScreen> {
  final SigninController signinController = Get.put(SigninController());
  final GetUserDataController getUserDataController =
      Get.put(GetUserDataController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppConstant.appSecondryColor,
            title: const Text(
              'Sign In',
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
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: Get.width,
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Obx(
                        () => TextFormField(
                          controller: passwordController,
                          cursorColor: AppConstant.appSecondryColor,
                          keyboardType: TextInputType.text,
                          obscureText: signinController.isPasswordVisible.value,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: const Icon(Icons.password),
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    signinController.isPasswordVisible.toggle();
                                  },
                                  child:
                                      signinController.isPasswordVisible.value
                                          ? const Icon(Icons.visibility_off)
                                          : const Icon(Icons.visibility)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.black))),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 200),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const ForgetPasswordScreen());
                    },
                    child: const Text('Forget password?',
                        style: TextStyle(
                            color: AppConstant.appSecondryColor,
                            fontWeight: FontWeight.bold)),
                  ),
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
                          String password = passwordController.text.trim();

                          if (email.isEmpty || password.isEmpty) {
                            Get.snackbar('Error', 'Please fill all details');
                          } else {
                            UserCredential? userCredential =
                                await signinController.signInwithEmail(
                                    email, password);

                            var userData = await getUserDataController
                                .getUserData(userCredential!.user!.uid);
                            if (userCredential != null) {
                              if (userCredential.user!.emailVerified) {
                                if (userData[0]['isAdmin'] == true) {
                                  Get.off(() => const AdminMainScreen());
                                  Get.snackbar('successfly Admin Login',
                                      'Login Successfly',
                                      backgroundColor:
                                          AppConstant.appSecondryColor,
                                      colorText: AppConstant.appTextColor,
                                      snackPosition: SnackPosition.BOTTOM);
                                } else {
                                  Get.off(() => const HomeScreen());
                                  Get.snackbar('successfly user login   ',
                                      'Login Successfly',
                                      backgroundColor:
                                          AppConstant.appSecondryColor,
                                      colorText: AppConstant.appTextColor,
                                      snackPosition: SnackPosition.BOTTOM);
                                }

                                Get.offAll(() => const HomeScreen());
                              } else {
                                Get.snackbar(
                                    'Error', 'Please verify your Email',
                                    backgroundColor:
                                        AppConstant.appSecondryColor,
                                    colorText: AppConstant.appTextColor,
                                    snackPosition: SnackPosition.BOTTOM);
                              }
                            } else {
                              Get.snackbar('Error', 'Please try again',
                                  backgroundColor: AppConstant.appSecondryColor,
                                  colorText: AppConstant.appTextColor,
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                          }
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(color: AppConstant.appTextColor),
                        ),
                      )),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an acount?",
                        style: TextStyle(
                          color: AppConstant.appSecondryColor,
                        )),
                    GestureDetector(
                      onTap: () => Get.offAll(() => const SignUpScreen()),
                      child: const Text(" Sign Up",
                          style: TextStyle(
                              color: AppConstant.appSecondryColor,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
