import 'package:get/get.dart';

class ProfileController extends GetxController {
  final isLoading = true.obs;
  final userProfile = UserProfile().obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  void fetchProfile() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    userProfile.value = UserProfile(
      name: 'Ehtesham',
      email: 'ehtesham@example.com',
      phone: '+1234567890',
      imageUrl: null,
    );
    isLoading.value = false;
  }

  void logout() {
    // Get.offAllNamed('/login');
  }
}

class UserProfile {
  final String? name;
  final String? email;
  final String? phone;
  final String? imageUrl;

  UserProfile({this.name, this.email, this.phone, this.imageUrl});
}
