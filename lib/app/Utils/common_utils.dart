import 'package:flutter/material.dart';
import 'package:get/get.dart';

final List<String> imgList = [
  'assets/banner/banner2.png',
  'assets/banner/banner2.png',
];

Widget titleCommon() {
  return Image.asset("assets/icons/logo.png", width: Get.width / 4);
}

Widget backbutton() {
  return InkWell(
    onTap: () => Get.back(),
    child: Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.white),
  );
}
