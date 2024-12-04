// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/models/Order_Model.dart';
import 'package:e_comm/screen/user_panel/Home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../utiles/App-constant.dart';
import 'generate_order_Id_Service.dart';

void placeOrder(
    {required BuildContext context,
    required String customerName,
    required String customerPhone,
    required String customerAddress,
    required String customerDeviceToken}) async {
  final user = FirebaseAuth.instance.currentUser;
  EasyLoading.show(status: 'Please wait...');
  if (user != null) {
    try {
      // fetch all documents
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cart')
          .doc(user.uid)
          .collection('cartOrders')
          .get();

      List<QueryDocumentSnapshot> doucments = querySnapshot.docs;

      for (var doc in doucments) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;
        // generate a unique Id
        String orderId = generateOrderId();

        OrderModel orderModel = OrderModel(
            productId: data['productId'],
            categoryId: data['categoryId'],
            productName: data['productName'],
            categoryName: data['categoryName'],
            salePrice: data['salePrice'],
            fullPrice: data['fullPrice'],
            productImages: data['productImages'],
            deliveryTime: data['deliveryTime'],
            isSale: data['isSale'],
            productDescription: data['productDescription'],
            createdAt: DateTime.now(),
            updatedAt: data['updatedAt'],
            productQuantity: data['productQuantity'],
            productTotalPrice: data['productTotalPrice'],
            customerId: user.uid,
            status: false,
            customerName: customerName,
            customerPhone: customerPhone,
            customerAddress: customerAddress,
            customerDeviceToken: customerDeviceToken);
        for (var x = 0; x < doucments.length; x++) {
          await FirebaseFirestore.instance
              .collection('orders')
              .doc(user.uid)
              .set(
            {
              'uId': user.uid,
              'customerName': customerName,
              'customerPhone': customerPhone,
              'customerAddress': customerAddress,
              'customerDeviceToken': customerDeviceToken,
              'orderStatus': false,
              'createdAt': DateTime.now(),
            },
          );
          // upload orders
          await FirebaseFirestore.instance
              .collection('cart')
              .doc(user.uid)
              .collection('cartOrders')
              .doc(orderId)
              .set(orderModel.toMap());

          // delete cart products
          await FirebaseFirestore.instance
              .collection('cart')
              .doc(user.uid)
              .collection('cartOrders')
              .doc(orderModel.productId)
              .delete();
        }
      }
      Get.snackbar('Order Confimed', 'Thank you for your Order!',
          backgroundColor: AppConstant.appSecondryColor,
          colorText: AppConstant.appTextColor,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3));
      EasyLoading.dismiss();
      Get.offAll(() => const HomeScreen());
    } catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
  }
}
