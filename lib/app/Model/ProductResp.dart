import 'dart:convert';

ProductResp productRespFromJson(String str) =>
    ProductResp.fromJson(json.decode(str));
String productRespToJson(ProductResp data) => json.encode(data.toJson());

class ProductResp {
  ProductResp({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final List<Product> data;

  factory ProductResp.fromJson(Map<String, dynamic> json) => ProductResp(
    status: json["status"] ?? '',
    message: json["message"] ?? '',
    data: List<Product>.from(
      (json["data"] ?? []).map((x) => Product.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Product {
  Product({
    required this.productId,
    required this.productImage,
    required this.productTitle,
    required this.price,
    required this.discount,
    required this.sellingPrice,
    required this.quantity,
    required this.description,
    required this.rating,
    required this.productCreatedAt,
    required this.color,
    required this.size,
    required this.categoryId,
    required this.categoryTitle,
    required this.categoryImage,
    required this.categoryCreatedAt,
  });

  final int productId;
  final String productImage;
  final String productTitle;
  final double price;
  final double discount;
  final double sellingPrice;
  final int quantity;
  final String description;
  final double rating;
  final String productCreatedAt;
  final String color;
  final String size;
  final int categoryId;
  final String categoryTitle;
  final String categoryImage;
  final String categoryCreatedAt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json["product_id"] ?? 0,
    productImage: json["product_image"] ?? '',
    productTitle: json["product_title"] ?? '',
    price: (json["price"] ?? 0).toDouble(),
    discount: json["discount"] ?? 0.0,
    sellingPrice: (json["selling_price"] ?? 0).toDouble(),
    quantity: json["quantity"] ?? 0,
    description: json["description"] ?? '',
    rating: (json["rating"] ?? 0).toDouble(),
    productCreatedAt: json["product_created_at"] ?? '',
    color: json["color"] ?? '',
    size: json["size"] ?? '',
    categoryId: json["category_id"] ?? 0,
    categoryTitle: json["category_title"] ?? '',
    categoryImage: json["category_image"] ?? '',
    categoryCreatedAt: json["category_created_at"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "product_image": productImage,
    "product_title": productTitle,
    "price": price,
    "discount": discount,
    "selling_price": sellingPrice,
    "quantity": quantity,
    "description": description,
    "rating": rating,
    "product_created_at": productCreatedAt,
    "color": color,
    "size": size,
    "category_id": categoryId,
    "category_title": categoryTitle,
    "category_image": categoryImage,
    "category_created_at": categoryCreatedAt,
  };
}
