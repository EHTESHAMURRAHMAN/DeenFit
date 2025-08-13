import 'package:deenfitapp/app/Services/Storage.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static Future<void> init() async {
    await Get.putAsync(() => StorageService().init());
  }
}
