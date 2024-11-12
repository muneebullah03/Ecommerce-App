// ignore_for_file: prefer_const_constructors

import 'package:e_comm/screen/user_panel/All_Categories_Screen.dart';
import 'package:e_comm/screen/user_panel/All_Sale_Products.dart';
import 'package:e_comm/utiles/App-constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widget/All_Products_Screen.dart';
import '../../widget/Categories_Widget.dart';
import '../../widget/Custom_Drawer.dart';
import '../../widget/Heading_Widget.dart';
import '../../widget/Sale_Product_Widget.dart';
import '../../widget/carousel_Widget.dart';
import 'All_Products_Screen.dart';
import 'Cart_Screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConstant.appTextColor),
        backgroundColor: AppConstant.appSecondryColor,
        title: const Text(
          'Flutter demo',
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.all(10),
            child: GestureDetector(
                onTap: () {
                  Get.to(() => CartScreen());
                },
                child: Icon(Icons.shopping_cart)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(height: 10),
            const CarouselWidget(),
            HeadingWidget(
              headingTitle: 'Categories',
              headingSubtitle: 'Low Budget Items',
              ontap: () {
                Get.to(() => AllCategoriesScreen());
              },
              buttonText: 'See more >',
            ),
            const CategoriesWidget(),
            const SizedBox(height: 10),
            HeadingWidget(
              headingTitle: 'Flash Sale',
              headingSubtitle: 'Unbeatable discount ',
              ontap: () {
                Get.to(() => AllSaleProductsScreen());
              },
              buttonText: 'See more >',
            ),
            const SaleProductWidget(),
            HeadingWidget(
              headingTitle: 'All products',
              headingSubtitle: 'All products according budget',
              ontap: () {
                Get.to(() => AllProductsScreen());
              },
              buttonText: 'See more >',
            ),
            const AllProductsWidget()
          ],
        ),
      ),
    );
  }
}
