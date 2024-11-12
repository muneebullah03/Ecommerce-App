// ignore_for_file: avoid_unnecessary_containers

import 'package:e_comm/utiles/App-constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConstant.appTextColor),
        title: const Text(
          "Shopping cart",
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        centerTitle: true,
        backgroundColor: AppConstant.appMainColor,
      ),
      body: Container(
        child: ListView.builder(
            itemCount: 20,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return const Card(
                elevation: 5,
                child: ListTile(
                  title: Text("Just New Item added"),
                  leading: CircleAvatar(
                    child: Icon(Icons.man),
                  ),
                  subtitle: Row(
                    children: [
                      Text('3000'),
                      SizedBox(width: 30),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: AppConstant.appMainColor,
                        child: Text(
                          '-',
                          style: TextStyle(color: AppConstant.appTextColor),
                        ),
                      ),
                      SizedBox(width: 35),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: AppConstant.appMainColor,
                        child: Text(
                          '+',
                          style: TextStyle(color: AppConstant.appTextColor),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
      bottomNavigationBar: Container(
        child: Row(
          children: [
            const Text('Total PKR:'),
            const SizedBox(width: 10),
            const Text(
              '5000',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            const SizedBox(width: 220),
            Material(
                child: Container(
                    decoration: BoxDecoration(
                        color: AppConstant.appSecondryColor,
                        borderRadius: BorderRadius.circular(20)),
                    width: Get.width / 4,
                    height: Get.height / 20,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Check out',
                        style: TextStyle(color: AppConstant.appTextColor),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
