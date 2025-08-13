import 'package:deenfitapp/app/Utils/common_utils.dart';
import 'package:deenfitapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: titleCommon()),
      body: Obx(() {
        final profile = controller.userProfile.value;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Get.theme.primaryColor,
                      backgroundImage:
                          profile.imageUrl != null
                              ? NetworkImage(profile.imageUrl!)
                              : null,
                      child:
                          profile.imageUrl == null
                              ? Icon(
                                Icons.person,
                                size: 50,
                                color: Get.theme.canvasColor,
                              )
                              : null,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      profile.name ?? 'No Name',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      profile.email ?? 'No Email',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      profile.phone ?? 'No Phone',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // My Account Section
              _sectionTitle("My Account"),
              Card(
                color: Get.theme.canvasColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _profileTile(
                      Icons.shopping_bag,
                      'My Orders',
                      onTap: () {
                        Get.toNamed(Routes.ORDERS);
                      },
                    ),
                    _profileTile(
                      Icons.favorite_border,
                      'Wishlist',
                      onTap: () {
                        // Navigate to Wishlist
                      },
                    ),
                    _profileTile(
                      Icons.location_on_outlined,
                      'Address Book',
                      onTap: () {
                        // Navigate to Address Management
                      },
                    ),
                    _profileTile(
                      Icons.account_circle_outlined,
                      'Edit Profile',
                      onTap: () {
                        // Navigate to Edit Profile
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Settings Section
              _sectionTitle("Settings"),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Get.theme.canvasColor,
                child: Column(
                  children: [
                    _profileTile(
                      Icons.dark_mode_outlined,
                      'Dark Mode',
                      trailing: Switch(value: false, onChanged: (_) {}),
                    ),
                    _profileTile(
                      Icons.logout,
                      'Logout',
                      onTap: () {
                        controller.logout();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // Section title widget
  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Reusable profile tile
  Widget _profileTile(
    IconData icon,
    String title, {
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Get.theme.primaryColor),
      title: Text(title),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
