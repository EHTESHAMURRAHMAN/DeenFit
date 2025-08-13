import 'dart:convert';

OrderResponse orderResponseFromJson(String str) =>
    OrderResponse.fromJson(json.decode(str));

String orderResponseToJson(OrderResponse data) => json.encode(data.toJson());

class OrderResponse {
  OrderResponse({
    required this.status,
    required this.message,
    this.orderID,
    required this.orders,
  });

  final String status;
  final String message;
  final dynamic orderID;
  final List<Order> orders;

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
    status: json["status"] ?? '',
    message: json["message"] ?? '',
    orderID: json["orderID"],
    orders: List<Order>.from(
      (json["orders"] ?? []).map((x) => Order.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "orderID": orderID,
    "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
  };
}

class Order {
  Order({
    required this.orderID,
    required this.customerName,
    required this.phone,
    required this.shippingAddress,
    required this.orderDate,
    required this.totalAmount,
    required this.paymentMethod,
    required this.status,
    required this.currentStatus,
    required this.orderItems,
    required this.statusHistory,
  });

  final int orderID;
  final String customerName;
  final String phone;
  final String shippingAddress;
  final String orderDate;
  final double totalAmount;
  final String paymentMethod;
  final int status;
  final String currentStatus;
  final List<OrderItem> orderItems;
  final StatusHistory statusHistory;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    orderID: json["orderID"] ?? 0,
    customerName: json["customerName"] ?? '',
    phone: json["phone"] ?? '',
    shippingAddress: json["shippingAddress"] ?? '',
    orderDate: json["orderDate"] ?? '',
    totalAmount: (json["totalAmount"] ?? 0).toDouble(),
    paymentMethod: json["paymentMethod"] ?? '',
    status: json["status"] ?? 0,
    currentStatus: json["currentStatus"] ?? '',
    orderItems: List<OrderItem>.from(
      (json["orderItems"] ?? []).map((x) => OrderItem.fromJson(x)),
    ),
    statusHistory: StatusHistory.fromJson(json["statusHistory"] ?? {}),
  );

  Map<String, dynamic> toJson() => {
    "orderID": orderID,
    "customerName": customerName,
    "phone": phone,
    "shippingAddress": shippingAddress,
    "orderDate": orderDate,
    "totalAmount": totalAmount,
    "paymentMethod": paymentMethod,
    "status": status,
    "currentStatus": currentStatus,
    "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
    "statusHistory": statusHistory.toJson(),
  };
}

class OrderItem {
  OrderItem({
    required this.orderItemID,
    required this.orderID,
    required this.productID,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.subtotal,
  });

  final int orderItemID;
  final int orderID;
  final int productID;
  final String productName;
  final int quantity;
  final double price;
  final double subtotal;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    orderItemID: json["orderItemID"] ?? 0,
    orderID: json["orderID"] ?? 0,
    productID: json["productID"] ?? 0,
    productName: json["productName"] ?? '',
    quantity: json["quantity"] ?? 0,
    price: (json["price"] ?? 0).toDouble(),
    subtotal: (json["subtotal"] ?? 0).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "orderItemID": orderItemID,
    "orderID": orderID,
    "productID": productID,
    "productName": productName,
    "quantity": quantity,
    "price": price,
    "subtotal": subtotal,
  };
}

class StatusHistory {
  StatusHistory({
    required this.statusID,
    required this.orderID,
    required this.status,
    required this.statusName,
    required this.updatedAt,
    required this.updatedBy,
  });

  final int statusID;
  final int orderID;
  final int status;
  final String statusName;
  final String updatedAt;
  final String updatedBy;

  factory StatusHistory.fromJson(Map<String, dynamic> json) => StatusHistory(
    statusID: json["statusID"] ?? 0,
    orderID: json["orderID"] ?? 0,
    status: json["status"] ?? 0,
    statusName: json["statusName"] ?? '',
    updatedAt: json["updatedAt"] ?? '',
    updatedBy: json["updatedBy"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "statusID": statusID,
    "orderID": orderID,
    "status": status,
    "statusName": statusName,
    "updatedAt": updatedAt,
    "updatedBy": updatedBy,
  };
}
