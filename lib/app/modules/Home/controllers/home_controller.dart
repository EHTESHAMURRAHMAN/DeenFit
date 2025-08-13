import 'package:deenfitapp/app/Api/Api_Import.dart';
import 'package:deenfitapp/app/Api/Base_Api.dart';
import 'package:deenfitapp/app/Model/CategoryResp.dart';
import 'package:deenfitapp/app/Model/ProductResp.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final product = RxList<Product>();
  final isProductLoaded = false.obs;
  final category = RxList<Category>();
  final isCategoryLoaded = false.obs;
  ApiImport apiImport = ApiImport();
  @override
  void onInit() {
    super.onInit();
    fetchCategory();
    fetchAllProduct();
  }

  Future<void> fetchCategory() async {
    isCategoryLoaded.value = false;
    ApiResponse apiResponse = await apiImport.getCategoryApi();
    if (apiResponse.status) {
      CategoryResp response = apiResponse.data;
      category.value = response.data;
      isCategoryLoaded.value = true;
    } else {
      isCategoryLoaded.value = true;
    }
  }

  Future<void> fetchAllProduct() async {
    isProductLoaded.value = false;
    ApiResponse apiResponse = await apiImport.getAllProductApi();
    if (apiResponse.status) {
      ProductResp response = apiResponse.data;
      product.value = response.data;
      isProductLoaded.value = true;
    } else {
      isProductLoaded.value = true;
    }
  }
}
