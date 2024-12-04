// ignore_for_file: avoid_unnecessary_containers
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/models/Order_Model.dart';
import 'package:e_comm/utiles/App-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import '../../contoller/Total_Price_Controller.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<AllOrdersScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  TotalPriceController totalPriceController = Get.put(TotalPriceController());
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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .doc(user!.uid)
              .collection('orderConfirmed')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Error occured'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                  height: Get.height / 5.5,
                  child: const Center(child: CupertinoActivityIndicator()));
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No Products found'));
            }
            if (snapshot.data != null) {
              return Container(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final productyData = snapshot.data!.docs[index];
                    OrderModel orderModel = OrderModel(
                        productId: productyData['productId'],
                        categoryId: productyData['categoryId'],
                        productName: productyData['productName'],
                        categoryName: productyData['categoryName'],
                        salePrice: productyData['salePrice'],
                        fullPrice: productyData['fullPrice'],
                        productImages: productyData['productImages'],
                        deliveryTime: productyData['deliveryTime'],
                        isSale: productyData['isSale'],
                        productDescription: productyData['productDescription'],
                        createdAt: productyData['createdAt'],
                        updatedAt: productyData['updatedAt'],
                        productQuantity: productyData['productQuantity'],
                        productTotalPrice: productyData['productTotalPrice'],
                        customerId: productyData['customerId'],
                        status: productyData['status'],
                        customerName: productyData['customerName'],
                        customerPhone: productyData['customerPhone'],
                        customerAddress: productyData['customerAddress'],
                        customerDeviceToken:
                            productyData['customerDeviceToken']);
                    totalPriceController.fetchProductTotalPrice();
                    return SwipeActionCell(
                        key: ObjectKey(orderModel.productId),
                        trailingActions: [
                          SwipeAction(
                              title: "Delete",
                              onTap: (CompletionHandler handler) async {
                                // await FirebaseFirestore.instance
                                //     .collection('cart')
                                //     .doc(user!.uid)
                                //     .collection('cartOrders')
                                //     .doc(cartModel.productId)
                                //     .delete();
                              },
                              forceAlignmentToBoundary: true,
                              performsFirstActionWithFullSwipe: true)
                        ],
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                            title: Text(orderModel.productName),
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(orderModel.productImages[0]),
                            ),
                            subtitle: Row(
                              children: [
                                Text(orderModel.productTotalPrice.toString()),
                                const SizedBox(width: 30),
                                orderModel.status == true
                                    ? const Text('Pendind')
                                    : const Text('Delivered')
                              ],
                            ),
                          ),
                        ));
                  },
                ),
              );
            }

            return Container();
          }),
    );
  }
}
