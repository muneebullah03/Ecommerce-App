import 'package:e_comm/utiles/App-constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class GetDeviceTokenController extends GetxController {
  String? deviceToken;

  @override
  void onInit() {
    super.onInit();
    getDeviceToken();
  }

  Future<void> getDeviceToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      deviceToken = token;
      update();
        } catch (e) {
      Get.snackbar(
        'Error',
        '$e',
        backgroundColor: AppConstant.appSecondryColor,
        colorText: AppConstant.appTextColor,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
