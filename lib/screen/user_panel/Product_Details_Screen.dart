// ignore_for_file: must_be_immutable, avoid_unnecessary_containers, unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/models/Cart_Model.dart';
import 'package:e_comm/models/Sale_Product_Model.dart';
import 'package:e_comm/utiles/App-constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductModel productModel;
  ProductDetailsScreen({super.key, required this.productModel});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppConstant.appTextColor),
        title: const Text(
          'Product Details',
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        centerTitle: true,
        backgroundColor: AppConstant.appSecondryColor,
        elevation: 2,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            child: Column(
              children: [
                CarouselSlider(
                    items: widget.productModel.productImages
                        .map((imageUrls) => ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: imageUrls,
                                fit: BoxFit.cover,
                                width: Get.width - 10,
                                placeholder: (context, url) => const ColoredBox(
                                  color: Colors.white,
                                  child: Center(
                                    child: CupertinoActivityIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                        scrollDirection: Axis.horizontal,
                        autoPlay: true,
                        aspectRatio: 2.5)),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Text(widget.productModel.productName),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 20, top: 5),
                              child: Icon(
                                Icons.favorite_border,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: widget.productModel.isSale == true &&
                                    widget.productModel.salePrice != null
                                ? Text("PKR: ${widget.productModel.salePrice}")
                                : Text(widget.productModel.fullPrice),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                                "Category: ${widget.productModel.categoryName}"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                                "Description: ${widget.productModel.productDescription}"),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Material(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: AppConstant.appSecondryColor,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      width: Get.width / 3,
                                      height: Get.height / 16,
                                      child: TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'Chat on WhatsApp',
                                          style: TextStyle(
                                              color: AppConstant.appTextColor),
                                        ),
                                      ))),
                            ),
                            SizedBox(width: Get.width / 15),
                            Material(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: AppConstant.appSecondryColor,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    width: Get.width / 3,
                                    height: Get.height / 16,
                                    child: TextButton(
                                      onPressed: () async {
                                        await checkProductExistance(
                                            uId: user!.uid);
                                      },
                                      child: const Text(
                                        'Add to cart',
                                        style: TextStyle(
                                            color: AppConstant.appTextColor),
                                      ),
                                    ))),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checkProductExistance(
      {required String uId, int quantityIncrement = 1}) async {
    // cart database to store products details and user details
    final DocumentReference documentReference = FirebaseFirestore.instance
        .collection('cart')
        .doc(uId)
        .collection('cartOrders')
        .doc(widget.productModel.productId);

    DocumentSnapshot snapshot = await documentReference.get();
    // if user already add product in cart
    if (snapshot.exists) {
      int currentQuantity = snapshot['productQuantity'];
      int updatedQuantity = currentQuantity + quantityIncrement;

      double totalPrice =
          double.parse(widget.productModel.fullPrice) * updatedQuantity;

      await documentReference.update({
        'productQuantity': updatedQuantity,
        'productTotalPrice': totalPrice
      });
      // if user not add the product into cart
    } else {
      await FirebaseFirestore.instance.collection('cart').doc(uId).set({
        'uId': uId,
        'createdAt': DateTime.now(),
      });

      CartModel cartModel = CartModel(
          productId: widget.productModel.productId,
          categoryId: widget.productModel.categoryId,
          productName: widget.productModel.productName,
          categoryName: widget.productModel.categoryName,
          salePrice: widget.productModel.salePrice,
          fullPrice: widget.productModel.fullPrice,
          productImages: widget.productModel.productImages,
          deliveryTime: widget.productModel.deliveryTime,
          isSale: widget.productModel.isSale,
          productDescription: widget.productModel.productDescription,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          productQuantity: 1,
          productTotalPrice: double.parse(widget.productModel.fullPrice));
      await documentReference.set(cartModel.toMap());
      print('product added');
    }
  }
}
