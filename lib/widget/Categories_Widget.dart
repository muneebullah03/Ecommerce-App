// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/models/categories_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../screen/user_panel/Single_Category_Products.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('categories').get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error occured'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              height: Get.height / 5,
              child: const Center(child: CupertinoActivityIndicator()));
        }
        if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No Categories found'));
        }
        if (snapshot.data != null) {
          return Container(
            height: Get.height / 6,
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final categoryData = snapshot.data!.docs[index];
                CategoriesModel categoriesModel = CategoriesModel(
                    categoryId: categoryData['categoryId'],
                    categoryImg: categoryData['categoryImg'],
                    categoryName: categoryData['categoryName'],
                    createdAt: categoryData['createdAt'],
                    updatedAt: categoryData['updatedAt']);
                return GestureDetector(
                  onTap: () {
                    Get.to(() => SingleCategoryProducts(
                        categoryId: categoriesModel.categoryId));
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
                                    9.6, // Adjusted height to avoid overflow
                                width: Get.width / 4.0,
                                imageProvider: CachedNetworkImageProvider(
                                    categoriesModel.categoryImg),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              categoriesModel.categoryName,
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
            ),
          );
        }
        return Container();
      },
    );
  }
}
