// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/models/Sale_Product_Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../screen/user_panel/Product_Details_Screen.dart';

class AllProductsWidget extends StatefulWidget {
  const AllProductsWidget({super.key});

  @override
  State<AllProductsWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<AllProductsWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('products')
          .where('isSale', isEqualTo: false)
          .get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error occured'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              height: Get.height / 5.5,
              child: const Center(child: CupertinoActivityIndicator()));
        }
        if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No Products found'));
        }
        if (snapshot.data != null) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
                childAspectRatio: 1.19),
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final productyData = snapshot.data!.docs[index];
              ProductModel productModel = ProductModel(
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
                  updatedAt: productyData['updatedAt']);
              return GestureDetector(
                onTap: () {
                  Get.to(
                      () => ProductDetailsScreen(productModel: productModel));
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: SizedBox(
                    width: Get.width / 5.0,
                    child: ClipRRect(
                      child: Column(
                        children: [
                          Expanded(
                            child: FillImageCard(
                              borderRadius: 20,
                              heightImage: Get.height /
                                  5.5, // Adjusted height to avoid overflow
                              width: Get.width / 1.5,
                              imageProvider: CachedNetworkImageProvider(
                                  productModel.productImages[0]),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            productModel.productName,
                            style: const TextStyle(fontSize: 10),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
