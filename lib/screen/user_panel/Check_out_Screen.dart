// ignore_for_file: avoid_unnecessary_containers, unrelated_type_equality_checks, unused_local_variable, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/utiles/App-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import '../../contoller/Get_Costumer_Device_Token.dart';
import '../../contoller/Total_Price_Controller.dart';
import '../../models/Cart_Model.dart';
import '../../servicess/place_Order_Service.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  TotalPriceController totalPriceController = Get.put(TotalPriceController());
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConstant.appTextColor),
        title: const Text(
          "Checkout Screen",
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
                    showCustomBottomSheet();
                  },
                  child: const Text(
                    'Confirm',
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

  void showCustomBottomSheet() {
    Get.bottomSheet(Container(
      height: Get.height * 0.6,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: "Username",
                    labelStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey,
                    ),
                    hintText: "Enter your username",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Phone",
                    labelStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey,
                    ),
                    hintText: "Enter your phone number",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                    labelText: "Address",
                    labelStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey,
                    ),
                    hintText: "Enter your address",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black))),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstant.appMainColor),
                onPressed: () async {
                  if (nameController != '' &&
                      phoneController != '' &&
                      addressController != '') {
                    String name = nameController.text.trim();
                    String phone = phoneController.text.trim();
                    String address = addressController.text.trim();

                    String customerToken = await GetCostumerDeviceToken();
                    placeOrder(
                        context: context,
                        customerName: name,
                        customerPhone: phone,
                        customerAddress: address,
                        customerDeviceToken: customerToken);
                  } else {
                    Get.snackbar('Error', 'Please fill all the details',
                        backgroundColor: AppConstant.appSecondryColor,
                        colorText: AppConstant.appTextColor,
                        snackPosition: SnackPosition.BOTTOM);
                  }
                },
                child: const Text(
                  'Place Order',
                  style: TextStyle(color: AppConstant.appTextColor),
                ))
          ],
        ),
      ),
    ));
  }
}
