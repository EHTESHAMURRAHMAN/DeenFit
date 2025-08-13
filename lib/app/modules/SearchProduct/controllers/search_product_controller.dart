import 'package:deenfitapp/app/Api/Api_Import.dart';
import 'package:deenfitapp/app/Api/Base_Api.dart';
import 'package:deenfitapp/app/Model/ProductResp.dart';
import 'package:get/get.dart';

class SearchProductController extends GetxController {
  final product = RxList<Product>();
  final filteredProducts = RxList<Product>();
  final isProductLoaded = false.obs;

  final ApiImport apiImport = ApiImport();

  @override
  void onInit() {
    super.onInit();
    fetchAllProduct();
  }

  @override
  void onReady() {
    super.onReady();
    fetchAllProduct();
  }

  Future<void> fetchAllProduct() async {
    isProductLoaded.value = false;
    ApiResponse apiResponse = await apiImport.getAllProductApi();
    if (apiResponse.status) {
      ProductResp response = apiResponse.data;
      product.value = response.data;
      filteredProducts.value = response.data;
    }
    isProductLoaded.value = true;
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      filteredProducts.value = product;
    } else {
      filteredProducts.value =
          product
              .where(
                (item) => item.productTitle.toLowerCase().contains(
                  query.toLowerCase(),
                ),
              )
              .toList();
    }
  }
}
