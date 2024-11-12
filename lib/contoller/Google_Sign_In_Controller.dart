import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/models/User_Model.dart';
import 'package:e_comm/screen/user_panel/Home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'Get_Device_Token.dart';

class SignInController extends GetxController {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithGoogle() async {
    GetDeviceTokenController getDeviceTokenController =
        Get.put(GetDeviceTokenController());
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        EasyLoading.show(status: "Please wait...");
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        final User? user = userCredential.user;

        if (user != null) {
          UserModel userModel = UserModel(
              uId: user.uid,
              username: user.displayName ?? 'Unknown User',
              email: user.email ?? 'No email available',
              phone: user.phoneNumber ?? 'No phone number',
              userImg: user.photoURL ?? 'default_image_url',
              userDeviceToken: getDeviceTokenController.deviceToken.toString(),
              country: '',
              userAddress: '',
              street: '',
              isAdmin: false,
              isActive: true,
              createdOn: DateTime.now(),
              city: '');

          FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set(userModel.toMap());
          EasyLoading.dismiss();
          Get.offAll(const HomeScreen());
        }
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(
        "Login failed. Please try again.",
      );
      print("error: $e");
    }
  }
}
