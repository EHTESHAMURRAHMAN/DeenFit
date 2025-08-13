import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        body: controller.pages[controller.selectedIndex.value],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Get.theme.highlightColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(18.0),
                  border: Border.all(
                    color: Get.theme.highlightColor.withOpacity(0.3),
                    width: 1.0,
                  ),
                ),
                child: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  type: BottomNavigationBarType.fixed,
                  elevation: 0,
                  selectedItemColor: Get.theme.primaryColor,
                  unselectedItemColor: Colors.white,
                  currentIndex: controller.selectedIndex.value,
                  onTap: controller.changeTab,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.search),
                      label: 'Search',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.cart),
                      label: 'Cart',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.person),
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
