// ignore_for_file: avoid_unnecessary_containers

import 'package:e_comm/utiles/App-constant.dart';
import 'package:flutter/material.dart';

class HeadingWidget extends StatelessWidget {
  final String headingTitle;
  final String headingSubtitle;
  final VoidCallback ontap;
  final String buttonText;
  const HeadingWidget(
      {super.key,
      required this.headingTitle,
      required this.headingSubtitle,
      required this.ontap,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 36),
                  child: Text(
                    headingTitle,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800),
                  ),
                ),
                Text(
                  headingSubtitle,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontSize: 12.0),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: InkWell(
              onTap: ontap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: AppConstant.appSecondryColor, width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: AppConstant.appSecondryColor),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
