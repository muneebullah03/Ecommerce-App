// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/utiles/App-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var isPasswordVisible = false.obs;

  // ignore: body_might_complete_normally_nullable
  Future<UserCredential?> signInwithEmail(
    String email,
    String password,
  ) async {
    try {
      //  EasyLoading.show(status: 'Please wait...');
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      EasyLoading.dismiss();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar('Error', '$e',
          backgroundColor: AppConstant.appSecondryColor,
          colorText: AppConstant.appTextColor,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
