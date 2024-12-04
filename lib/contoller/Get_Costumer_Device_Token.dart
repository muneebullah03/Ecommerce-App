import 'package:firebase_messaging/firebase_messaging.dart';

Future<String> GetCostumerDeviceToken() async {
  try {
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      return token;
    } else {
      throw Exception('Error');
    }
  } catch (e) {
    throw Exception('Error');
  }
}