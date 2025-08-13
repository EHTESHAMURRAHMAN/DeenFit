import 'package:deenfitapp/app/Api/Api.dart';
import 'package:deenfitapp/app/Api/Api_Path.dart';
import 'package:deenfitapp/app/Api/Base_Api.dart';
import 'package:deenfitapp/app/Model/CategoryResp.dart';
import 'package:deenfitapp/app/Model/Common_resp.dart';
import 'package:deenfitapp/app/Model/Order_Resp.dart';
import 'package:deenfitapp/app/Model/ProductResp.dart';

class ApiImport extends API {
  @override
  Future<ApiResponse> getCategoryApi() async {
    ApiResponse apiResponse = await getRequestAPI(GET_CATEGORY);
    if (apiResponse.status) {
      CategoryResp response = categoryRespFromJson(apiResponse.data);
      return ApiResponse.success(response);
    } else {
      return ApiResponse.failed(apiResponse.message);
    }
  }

  @override
  Future<ApiResponse> getAllProductApi() async {
    ApiResponse apiResponse = await getRequestAPI(GET_ALL_PRODUCT);
    if (apiResponse.status) {
      ProductResp response = productRespFromJson(apiResponse.data);
      return ApiResponse.success(response);
    } else {
      return ApiResponse.failed(apiResponse.message);
    }
  }

  @override
  Future<ApiResponse> getAllOrdersApi(int id) async {
    ApiResponse apiResponse = await getRequestAPI('$GET_ORDERS_BY_USERID/$id');
    if (apiResponse.status) {
      OrderResponse response = orderResponseFromJson(apiResponse.data);
      return ApiResponse.success(response);
    } else {
      return ApiResponse.failed(apiResponse.message);
    }
  }

  @override
  Future<ApiResponse> placeOrderApi(Map body) async {
    ApiResponse apiResponse = await postRequestAPI(PLACE_ORDER, body);
    if (apiResponse.status) {
      CommonResponse response = commonResponseFromJson(apiResponse.data);
      return ApiResponse.success(response);
    } else {
      return ApiResponse.failed(apiResponse.message);
    }
  }
}
