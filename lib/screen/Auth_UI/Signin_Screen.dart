import 'package:e_comm/screen/Auth_UI/SignUp_Screen.dart';
import 'package:e_comm/utiles/App-constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SignInScreen> {
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
                    ? const Text('Wellcome to my APp')
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
                    child: TextFormField(
                      cursorColor: AppConstant.appSecondryColor,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: Icon(Icons.visibility_off),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black))),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 200),
                  child: Text('Forget password?',
                      style: TextStyle(
                          color: AppConstant.appSecondryColor,
                          fontWeight: FontWeight.bold)),
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
                        onPressed: () {},
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
