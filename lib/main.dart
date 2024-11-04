import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screen/Auth_UI/SignUp_Screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAklRQ4j3iVKEuYl3ukj7ApSX-mLj9qgd8",
          appId: "1:587009739639:web:a2dcf480a7f68325526f72",
          messagingSenderId: "587009739639",
          projectId: "ecomapp-33a00"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignUpScreen(),
    );
  }
}
