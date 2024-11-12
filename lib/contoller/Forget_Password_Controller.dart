import 'package:e_comm/screen/Auth_UI/Signin_Screen.dart';
import 'package:e_comm/utiles/App-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> forgetPasswordController(String userEmail) async {
    try {
      EasyLoading.show(status: 'Please wait....');
      _auth.sendPasswordResetEmail(email: userEmail);
      Get.snackbar(
          'Requst sent successfly', 'Password reset via Email to $userEmail',
          backgroundColor: AppConstant.appSecondryColor,
          colorText: AppConstant.appTextColor,
          snackPosition: SnackPosition.BOTTOM);

      Get.offAll(const SignInScreen());
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(
        "Login failed. Please try again.",
      );
      print("error: $e");
    }
  }
}
