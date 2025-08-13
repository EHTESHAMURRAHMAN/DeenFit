import 'package:deenfitapp/app/Api/Api_Import.dart';
import 'package:deenfitapp/app/Model/Order_Resp.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrdersController extends GetxController {
  final orders = RxList<Order>();
  final orderItems = RxList<OrderItem>();
  final statusHistories = RxList<StatusHistory>();
  final isOrdersLoaded = false.obs;
  final errorMessage = ''.obs;
  final ApiImport apiImport = ApiImport();
  final currencyFormat = NumberFormat.currency(locale: 'en_IN', symbol: '₹');

  @override
  void onInit() {
    super.onInit();
    fetchOrders(4);
  }

  Future<void> fetchOrders(int id) async {
    isOrdersLoaded.value = false;
    errorMessage.value = '';
    try {
      final apiResponse = await apiImport.getAllOrdersApi(id);
      if (apiResponse.status && apiResponse.data is OrderResponse) {
        final response = apiResponse.data as OrderResponse;
        orders.value = response.orders;
        orderItems.value =
            response.orders.expand((order) => order.orderItems).toList();
        statusHistories.value =
            response.orders.map((order) => order.statusHistory).toList();
        isOrdersLoaded.value = true;
      } else {
        isOrdersLoaded.value = true;
        errorMessage.value = apiResponse.message;
      }
    } catch (e) {
      isOrdersLoaded.value = true;
      errorMessage.value = 'An error occurred: $e';
    }
  }
}
