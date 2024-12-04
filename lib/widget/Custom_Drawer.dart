// ignore_for_file: prefer_const_constructors
import 'package:e_comm/screen/user_panel/All_Products_Screen.dart';
import 'package:e_comm/screen/user_panel/Home_screen.dart';
import 'package:e_comm/utiles/App-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../screen/Auth_UI/Wellcome_Screen.dart';
import '../screen/user_panel/All_Orders_Screen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height / 25),
      child: Drawer(
        backgroundColor: AppConstant.appSecondryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Wrap(
          runSpacing: 10,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: ListTile(
                title: Text(
                  "Muneeb Ullah",
                  style: TextStyle(color: AppConstant.appTextColor),
                ),
                titleAlignment: ListTileTitleAlignment.center,
                subtitle: Text("Flutter Developer",
                    style: TextStyle(color: AppConstant.appTextColor)),
                leading: CircleAvatar(
                  radius: 30,
                  child: Text("M"),
                ),
              ),
            ),
            Divider(
              indent: 15,
              endIndent: 15,
              color: Colors.grey,
              thickness: 1.5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: ListTile(
                onTap: () {
                  Get.to(() => HomeScreen());
                  Get.close(1);
                },
                title: Text("Home",
                    style: TextStyle(color: AppConstant.appTextColor)),
                leading: Icon(
                  Icons.home,
                  color: AppConstant.appTextColor,
                ),
                trailing:
                    Icon(Icons.arrow_forward, color: AppConstant.appTextColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: ListTile(
                onTap: () {
                  Get.to(() => AllProductsScreen());
                },
                title: Text("Products",
                    style: TextStyle(color: AppConstant.appTextColor)),
                leading: Icon(
                  Icons.production_quantity_limits_outlined,
                  color: AppConstant.appTextColor,
                ),
                trailing:
                    Icon(Icons.arrow_forward, color: AppConstant.appTextColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: ListTile(
                onTap: () {
                  Get.to(() => AllOrdersScreen());
                },
                title: Text("Orders",
                    style: TextStyle(color: AppConstant.appTextColor)),
                leading: Icon(
                  Icons.shopping_bag,
                  color: AppConstant.appTextColor,
                ),
                trailing:
                    Icon(Icons.arrow_forward, color: AppConstant.appTextColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: ListTile(
                onTap: () {
                  Get.close(1);
                },
                title: Text("Contact",
                    style: TextStyle(color: AppConstant.appTextColor)),
                leading: Icon(
                  Icons.help,
                  color: AppConstant.appTextColor,
                ),
                trailing:
                    Icon(Icons.arrow_forward, color: AppConstant.appTextColor),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: ListTile(
                onTap: () async {
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  auth.signOut();
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  await googleSignIn.signOut();

                  Get.off(() => WellcomeScreen());
                },
                title: Text("Logout",
                    style: TextStyle(color: AppConstant.appTextColor)),
                leading: Icon(
                  Icons.logout,
                  color: AppConstant.appTextColor,
                ),
                trailing:
                    Icon(Icons.arrow_forward, color: AppConstant.appTextColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
