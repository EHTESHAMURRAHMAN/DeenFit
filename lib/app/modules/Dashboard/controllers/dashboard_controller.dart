import 'package:deenfitapp/app/modules/Home/controllers/home_controller.dart';
import 'package:deenfitapp/app/modules/Orders/controllers/orders_controller.dart';
import 'package:deenfitapp/app/modules/SearchProduct/controllers/search_product_controller.dart';
import 'package:deenfitapp/app/modules/Profile/controllers/profile_controller.dart';
import 'package:deenfitapp/app/modules/Home/views/home_view.dart';
import 'package:deenfitapp/app/modules/Orders/views/orders_view.dart';
import 'package:deenfitapp/app/modules/SearchProduct/views/search_product_view.dart';
import 'package:deenfitapp/app/modules/Profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if (!Get.isRegistered<HomeController>()) {
      Get.lazyPut<HomeController>(() => HomeController());
    } else {
      Get.find<HomeController>();
    }
  }

  void changeTab(int index) {
    selectedIndex.value = index;

    switch (index) {
      case 0:
        if (!Get.isRegistered<HomeController>()) {
          Get.lazyPut<HomeController>(() => HomeController());
        } else {
          Get.find<HomeController>();
        }
        break;
      case 1:
        if (!Get.isRegistered<SearchProductController>()) {
          Get.lazyPut<SearchProductController>(() => SearchProductController());
        } else {
          Get.find<SearchProductController>();
        }
        break;
      case 2:
        if (!Get.isRegistered<OrdersController>()) {
          Get.lazyPut<OrdersController>(() => OrdersController());
        } else {
          Get.find<OrdersController>();
        }
        break;
      case 3:
        if (!Get.isRegistered<ProfileController>()) {
          Get.lazyPut<ProfileController>(() => ProfileController());
        } else {
          Get.find<ProfileController>();
        }
        break;
    }
  }

  final List<Widget> pages = [
    HomeView(),
    SearchProductView(),
    OrdersView(),
    ProfileView(),
  ];
}
