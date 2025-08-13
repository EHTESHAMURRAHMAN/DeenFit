import 'dart:convert';
import 'package:deenfitapp/app/Environment/BASE_URL.dart';
import 'package:deenfitapp/app/Model/Common_resp.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var timeoutDuration = 90;

// UserResponse? userInfo;
// UserProfileResponse? userProfile;
// LoginResponse? tokenInfo;
// String? deviceId;

String userPassword = '';

Map<String, String> headers = {
  "Content-Type": "application/json;charset=UTF-8",
  "accept": "application/json",
  "Access-Control-Allow-Origin": "*",
  'Charset': 'utf-8',
};

Future<ApiResponse> postRequestAPI(method, body) async {
  try {
    String url = '${ApiConstants.baseurl}$method';
    final response = await postRequest(url, body);
    if (kDebugMode) {
      print('$url\n${jsonEncode(body)}');
    }
    ApiResponse apiResponse = responseFilter(response);
    if (apiResponse.status) {
      return ApiResponse(
        status: true,
        data: apiResponse.data,
        message: SUCCESS,
      );
    } else {
      return apiResponse;
    }
  } catch (e) {
    return ApiResponse(status: false, data: null, message: e.toString());
  }
}

Future<ApiResponse> getRequestAPI(method) async {
  try {
    String url = '${ApiConstants.baseurl}$method';
    print('Get => $url');
    final response = await getRequest(url);
    ApiResponse apiResponse = responseFilter(response);
    if (apiResponse.status) {
      return ApiResponse(
        status: true,
        data: apiResponse.data,
        message: SUCCESS,
      );
    } else {
      return apiResponse;
    }
  } catch (e) {
    return ApiResponse(status: false, data: null, message: e.toString());
  }
}

Future<ApiResponse> commonPostAPI(method, body) async {
  try {
    String url = '${ApiConstants.baseurl}$method';
    final response = await postRequest(url, body);
    ApiResponse apiResponse = responseFilter(response);
    if (apiResponse.status) {
      CommonResponse response = commonResponseFromJson(apiResponse.data);
      return ApiResponse(status: true, data: response, message: SUCCESS);
    } else {
      return apiResponse;
    }
  } catch (e) {
    return ApiResponse(status: false, data: null, message: e.toString());
  }
}

Future<ApiResponse> get3rdPartyRequestAPI(method) async {
  try {
    String url = '$method';
    print('Get => $url');
    final response = await getRequest(url);
    ApiResponse apiResponse = responseFilter(response);
    if (apiResponse.status) {
      return ApiResponse(
        status: true,
        data: apiResponse.data,
        message: SUCCESS,
      );
    } else {
      return apiResponse;
    }
  } catch (e) {
    return ApiResponse(status: false, data: null, message: e.toString());
  }
}

ApiResponse responseFilter(http.Response response) {
  try {
    if (kDebugMode) {
      print(response.body);
    }
    switch (response.statusCode) {
      case 200:
        var data = jsonDecode(response.body);
        if (data is Map) {
          Map map = jsonDecode(response.body);
          if (map['status'] == 'failed') {
            if (map['message'] != null) {
              if (map['message'].toString().toLowerCase().contains('expire')) {
                clearAllCache();
              }
            }
            return ApiResponse(
              status: false,
              data: response.body,
              message: map['message'],
            );
          }
        }
        return ApiResponse(status: true, data: response.body, message: SUCCESS);
      case 401:
        clearAllCache();
        return ApiResponse(
          status: false,
          data: response.body,
          message: 'Unauthorized',
        );
      case 400:
        return ApiResponse(
          status: false,
          data: response.body,
          message: 'Bad Request',
        );
      case 404:
        return ApiResponse(
          status: false,
          data: response.body,
          message: 'Not Found',
        );
      case 408:
        return ApiResponse(
          status: false,
          data: response.body,
          message: 'Request Timeout',
        );
      default:
        return ApiResponse(status: false, data: response.body, message: ERROR);
    }
  } catch (e) {
    return ApiResponse(status: false, data: null, message: e.toString());
  }
}

Future<void> clearAllCache() async {
  final prefs = Get.find<SharedPreferences>();
  await prefs.clear();
  //Get.offAll(() => SignIn());
}

Future<http.Response> getRequestToken(url, token) async {
  if (kDebugMode) {
    print(url);
  }
  Map<String, String> headers1 = {
    "Content-Type": "application/json;charset=UTF-8",
    "accept": "application/json",
    "Access-Control-Allow-Origin": "*",
    'Charset': 'utf-8',
    "Authorization": "Bearer $token",
  };
  final response = await http
      .get(Uri.parse(url), headers: headers1)
      .timeout(
        Duration(seconds: timeoutDuration),
        onTimeout: () {
          return http.Response('Request time out', 408);
        },
      );
  return response;
}

Future<http.Response> postRequestToken(
  url,
  body,
  token, {
  loading = true,
}) async {
  if (kDebugMode) {
    print('${Uri.parse(url)}\n$body');
  }
  Map<String, String> headers1 = {
    "Content-Type": "application/json;charset=UTF-8",
    "accept": "application/json",
    "Access-Control-Allow-Origin": "*",
    'Charset': 'utf-8',
    "Authorization": "Bearer $token",
  };

  final response = await http
      .post(Uri.parse(url), body: json.encode(body), headers: headers1)
      .timeout(
        Duration(seconds: timeoutDuration),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
  EasyLoading.dismiss();
  return response;
}

Future<http.Response> getRequest(url) async {
  if (kDebugMode) {
    print(url);
  }

  final response = await http
      .get(Uri.parse(url), headers: headers)
      .timeout(
        Duration(seconds: timeoutDuration),
        onTimeout: () {
          return http.Response('Request time out', 408);
        },
      );
  return response;
}

Future<http.Response> postRequest(url, body, {loading = true}) async {
  if (kDebugMode) {
    print('${Uri.parse(url)}\n$body');
  }

  final response = await http
      .post(Uri.parse(url), body: json.encode(body), headers: headers)
      .timeout(
        Duration(seconds: timeoutDuration),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );
  EasyLoading.dismiss();
  return response;
}

const String SUCCESS = 'success';
const String ERROR = 'failure';

class ApiResponse {
  bool status;
  String message;
  dynamic data;
  ApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ApiResponse.success(data) {
    return ApiResponse(status: true, message: '', data: data);
  }

  factory ApiResponse.failed(message) {
    return ApiResponse(status: false, message: message, data: null);
  }
}
