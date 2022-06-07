import 'package:my_fina/base/theme.dart';
import 'package:my_fina/helper/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

Widget showShimmerList(){
  return Container(
    margin: EdgeInsets.all(wValue(15)),
    child: Shimmer.fromColors(
      baseColor: greyShimmer,
      highlightColor: Colors.white60,
      child: Column(
        children: [
          SizedBox(
            height: hValue(15),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.grey,
                width: Get.width,
                height: hValue(10),
              ),
              SizedBox(
                height: hValue(5),
              ),
              Container(
                color: Colors.grey,
                width: wValue(150),
                height: hValue(10),
              )
            ],
          ),
          SizedBox(
            height: hValue(15),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.grey,
                width: Get.width,
                height: hValue(10),
              ),
              SizedBox(
                height: hValue(5),
              ),
              Container(
                color: Colors.grey,
                width: wValue(150),
                height: hValue(10),
              )
            ],
          ),
          SizedBox(
            height: hValue(15),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.grey,
                width: Get.width,
                height: hValue(10),
              ),
              SizedBox(
                height: hValue(5),
              ),
              Container(
                color: Colors.grey,
                width: wValue(150),
                height: hValue(10),
              )
            ],
          ),
          SizedBox(
            height: hValue(15),
          ),
        ],
      ),
    ),
  );
}