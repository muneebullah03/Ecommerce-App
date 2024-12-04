// ignore_for_file: avoid_unnecessary_containers
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/screen/user_panel/Check_out_Screen.dart';
import 'package:e_comm/utiles/App-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import '../../contoller/Total_Price_Controller.dart';
import '../../models/Cart_Model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
              .collection('cart')
              .doc(user!.uid)
              .collection('cartOrders')
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
                    CartModel cartModel = CartModel(
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
                        productTotalPrice: productyData['productTotalPrice']);
                    totalPriceController.fetchProductTotalPrice();
                    return SwipeActionCell(
                        key: ObjectKey(cartModel.productId),
                        trailingActions: [
                          SwipeAction(
                              title: "Delete",
                              onTap: (CompletionHandler handler) async {
                                await FirebaseFirestore.instance
                                    .collection('cart')
                                    .doc(user!.uid)
                                    .collection('cartOrders')
                                    .doc(cartModel.productId)
                                    .delete();
                              },
                              forceAlignmentToBoundary: true,
                              performsFirstActionWithFullSwipe: true)
                        ],
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                            title: Text(cartModel.productName),
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(cartModel.productImages[0]),
                            ),
                            subtitle: Row(
                              children: [
                                Text(cartModel.productTotalPrice.toString()),
                                const SizedBox(width: 30),
                                GestureDetector(
                                  onTap: () async {
                                    if (cartModel.productQuantity > 1) {
                                      await FirebaseFirestore.instance
                                          .collection('cart')
                                          .doc(user!.uid)
                                          .collection('cartOrders')
                                          .doc(cartModel.productId)
                                          .update({
                                        'productQuantity':
                                            cartModel.productQuantity - 1,
                                        'productTotalPrice':
                                            double.parse(cartModel.fullPrice) *
                                                (cartModel.productQuantity - 1)
                                      });
                                    }
                                  },
                                  child: const CircleAvatar(
                                    radius: 20,
                                    backgroundColor: AppConstant.appMainColor,
                                    child: Text(
                                      '-',
                                      style: TextStyle(
                                          color: AppConstant.appTextColor),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 35),
                                GestureDetector(
                                  onTap: () async {
                                    await FirebaseFirestore.instance
                                        .collection('cart')
                                        .doc(user!.uid)
                                        .collection('cartOrders')
                                        .doc(cartModel.productId)
                                        .update({
                                      'productQuantity':
                                          cartModel.productQuantity
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 25),
                                    child: Text(
                                        cartModel.productQuantity.toString()),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await FirebaseFirestore.instance
                                        .collection('cart')
                                        .doc(user!.uid)
                                        .collection('cartOrders')
                                        .doc(cartModel.productId)
                                        .update({
                                      'productQuantity':
                                          cartModel.productQuantity + 1,
                                      'productTotalPrice': double.parse(
                                              cartModel.fullPrice) +
                                          double.parse(cartModel.fullPrice) *
                                              (cartModel.productQuantity)
                                    });
                                  },
                                  child: const CircleAvatar(
                                    radius: 20,
                                    backgroundColor: AppConstant.appMainColor,
                                    child: Text(
                                      '+',
                                      style: TextStyle(
                                          color: AppConstant.appTextColor),
                                    ),
                                  ),
                                ),
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
      bottomNavigationBar: Container(
        child: Row(
          children: [
            const Text('Total PKR:'),
            const SizedBox(width: 10),
            Obx(
              () => Text(
                totalPriceController.totalPrice.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            const SizedBox(width: 100),
            Material(
              child: Container(
                decoration: BoxDecoration(
                    color: AppConstant.appSecondryColor,
                    borderRadius: BorderRadius.circular(20)),
                width: Get.width / 3,
                height: Get.height / 20,
                child: TextButton(
                  onPressed: () {
                    Get.to(() => const CheckOutScreen());
                  },
                  child: const Text(
                    'Check out',
                    style: TextStyle(color: AppConstant.appTextColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
