import 'package:deenfitapp/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigateToNextScreen();
  }

  void navigateToNextScreen() {
    Future.delayed(Duration(seconds: 2), () {
      return Get.offAllNamed(Routes.DASHBOARD);
    });
  }
}
