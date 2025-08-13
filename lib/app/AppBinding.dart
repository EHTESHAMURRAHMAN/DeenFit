import 'package:deenfitapp/app/AppController.dart';
import 'package:get/get.dart';

class Appbinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Appcontroller>(Appcontroller(), permanent: true);
  }
}
