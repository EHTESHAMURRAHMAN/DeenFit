import 'package:deenfitapp/app/Api/Base_Api.dart';

abstract class API {
  Future<ApiResponse> getAllProductApi();
  Future<ApiResponse> getCategoryApi();
  Future<ApiResponse> getAllOrdersApi(int id);
  Future<ApiResponse> placeOrderApi(Map body);
}
