import 'package:get/get.dart';

import '../controllers/credentials_controller.dart';

class CredentialsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CredentialsController>(
      () => CredentialsController(),
    );
  }
}
