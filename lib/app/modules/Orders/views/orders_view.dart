import 'package:deenfitapp/app/Utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: titleCommon(), centerTitle: true),
      body: RefreshIndicator(
        color: Get.theme.primaryColor,
        onRefresh: () => controller.fetchOrders(4),
        child: Obx(() {
          if (!controller.isOrdersLoaded.value) {
            return Center(
              child: CircularProgressIndicator(color: Get.theme.primaryColor),
            );
          }

          if (controller.orders.isEmpty) {
            return Center(
              child: Text(
                controller.errorMessage.isNotEmpty
                    ? controller.errorMessage.value
                    : 'No orders found.',
                style: Get.theme.textTheme.bodyLarge?.copyWith(
                  color: Get.theme.colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.orders.length,
            itemBuilder: (context, index) {
              final order = controller.orders[index];
              return Card(
                color: Get.theme.canvasColor,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...order.orderItems.map(
                        (item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      '• ${item.productName} ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    'Quantity: ${item.quantity}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                controller.currencyFormat.format(item.subtotal),
                                style: Get.theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Get.theme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),
                      OrderStatusSteps(status: order.status),
                      const SizedBox(height: 16),
                      _buildDetailRow('Phone', order.phone, Get.theme),
                      _buildDetailRow(
                        'Address',
                        order.shippingAddress,
                        Get.theme,
                        maxLines: 2,
                      ),
                      _buildDetailRow('Date', order.orderDate, Get.theme),
                      _buildDetailRow(
                        'Total',
                        controller.currencyFormat.format(order.totalAmount),
                        Get.theme,
                      ),
                      _buildDetailRow(
                        'Payment',
                        order.paymentMethod,
                        Get.theme,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    ThemeData theme, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            TextSpan(text: value),
          ],
        ),
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class OrderStatusSteps extends StatelessWidget {
  final int status;

  const OrderStatusSteps({super.key, required this.status});

  static const List<String> _statusNames = [
    'Pending',
    'Confirmed',
    'Packed',
    'Shipped',
    'Delivered',
    'Cancelled',
    'Returned',
  ];

  @override
  Widget build(BuildContext context) {
    final List<String> displayStatuses = _statusNames.sublist(0, 5);
    if (status == 5) {
      displayStatuses.add(_statusNames[5]);
    } else if (status == 6) {
      displayStatuses.add(_statusNames[6]);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(displayStatuses.length, (index) {
        final isCompleted = index <= status && status < 5 || status == index;
        final isLast = index == displayStatuses.length - 1;
        final lineCompleted =
            index < status && status < 5 || status == index && index > 4;

        return Stack(
          children: [
            if (!isLast)
              Positioned(
                left: 11,
                top: 28,
                child: Container(
                  width: 2,
                  height: 34,
                  color:
                      lineCompleted
                          ? Get.theme.primaryColor
                          : Get.theme.colorScheme.onSurfaceVariant.withOpacity(
                            0.3,
                          ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Icon(
                    isCompleted
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color:
                        isCompleted
                            ? Get.theme.primaryColor
                            : Get.theme.highlightColor,
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    displayStatuses[index],
                    style: Get.theme.textTheme.bodyLarge?.copyWith(
                      color:
                          isCompleted
                              ? Get.theme.primaryColor
                              : Get.theme.highlightColor,
                      fontWeight:
                          isCompleted ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
