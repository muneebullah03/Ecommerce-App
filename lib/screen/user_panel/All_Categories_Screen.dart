// ignore_for_file: sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_comm/screen/user_panel/Single_Category_Products.dart';
import 'package:e_comm/utiles/App-constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_card/image_card.dart';

import '../../models/categories_model.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appSecondryColor,
        title: const Text(
          'All Categories',
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
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
            );
            // Container(
            //   height: Get.height / 6,
            //   child: ListView.builder(
            //     itemCount: snapshot.data!.docs.length,
            //     shrinkWrap: true,
            //     scrollDirection: Axis.horizontal,
            //     itemBuilder:
            //   ),
            // );
          }
          return Container();
        },
      ),
    );
  }
}
