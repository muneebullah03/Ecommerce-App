// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/models/Sale_Product_Model.dart';
import 'package:e_comm/utiles/App-constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../screen/user_panel/Product_Details_Screen.dart';

class SaleProductWidget extends StatefulWidget {
  const SaleProductWidget({super.key});

  @override
  State<SaleProductWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<SaleProductWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('products')
          .where('isSale', isEqualTo: true)
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
          return const Center(child: Text('No Categories found'));
        }
        if (snapshot.data != null) {
          return Container(
            height: Get.height / 5,
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final productsData = snapshot.data!.docs[index];
                ProductModel productModel = ProductModel(
                    productId: productsData['productId'],
                    categoryId: productsData['categoryId'],
                    productName: productsData['productName'],
                    categoryName: productsData['categoryName'],
                    salePrice: productsData['salePrice'],
                    fullPrice: productsData['fullPrice'],
                    productImages: productsData['productImages'],
                    deliveryTime: productsData['deliveryTime'],
                    isSale: productsData['isSale'],
                    productDescription: productsData['productDescription'],
                    createdAt: productsData['createdAt'],
                    updatedAt: productsData['updatedAt']);
                return GestureDetector(
                  onTap: () {
                    Get.to(
                        () => ProductDetailsScreen(productModel: productModel));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: SizedBox(
                      width: Get.width / 4.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Column(
                          children: [
                            Expanded(
                              child: FillImageCard(
                                heightImage: Get.height /
                                    10, // Adjusted height to avoid overflow
                                width: Get.width / 4.0,
                                imageProvider: CachedNetworkImageProvider(
                                    productModel.productImages[0]),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              productModel.productName,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 10),
                              textAlign: TextAlign.center,
                            ),
                            Row(
                              children: [
                                Text(
                                  " PKR${productModel.salePrice}",
                                ),
                                const SizedBox(width: 2),
                                Text(productModel.fullPrice,
                                    style: const TextStyle(
                                        color: AppConstant.appSecondryColor,
                                        decoration:
                                            TextDecoration.lineThrough)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
