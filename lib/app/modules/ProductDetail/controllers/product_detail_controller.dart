import 'package:deenfitapp/app/Api/Api_Import.dart';
import 'package:deenfitapp/app/Api/Base_Api.dart';
import 'package:deenfitapp/app/Model/Common_resp.dart';
import 'package:deenfitapp/app/Model/ProductResp.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  final product = Rxn<Product>();
  final selectedImage = ''.obs;
  final argument = Get.arguments;
  final List<Product> selectedProducts = [];
  ApiImport apiImport = ApiImport();
  @override
  void onInit() {
    super.onInit();
    if (argument != null) {
      product.value = argument['product'];
    }
  }

  void placeOrder() async {
    if (product.value == null) {
      Get.snackbar('Error', 'No product selected.');
      return;
    }

    Product selected = product.value!;

    List<Map<String, dynamic>> orderItems = [
      {
        "productID": selected.productId,
        "productName": selected.productTitle,
        "quantity": 1,
        "price": selected.sellingPrice,
      },
    ];

    Map<String, dynamic> body = {
      "userId": 4,
      "customerName": "ReliWell",
      "phone": "+91-9369464481",
      "shippingAddress": "Mohankola",
      "paymentMethod": "Cash on Delivery",
      "orderItems": orderItems,
    };

    ApiResponse apiResponse = await apiImport.placeOrderApi(body);

    if (apiResponse.status) {
      CommonResponse response = apiResponse.data;
      Get.snackbar(
        response.status.toString(),
        response.message,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } else {
      Get.snackbar('Error', apiResponse.message);
    }
  }

  @override
  void onClose() {
    super.onClose();
    product.value = null;
  }
}
