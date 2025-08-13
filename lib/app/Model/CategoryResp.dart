import 'dart:convert';

CategoryResp categoryRespFromJson(String str) =>
    CategoryResp.fromJson(json.decode(str));

String categoryRespToJson(CategoryResp data) => json.encode(data.toJson());

class CategoryResp {
  CategoryResp({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final List<Category> data;

  factory CategoryResp.fromJson(Map<String, dynamic> json) => CategoryResp(
    status: json["status"] ?? '',
    message: json["message"] ?? '',
    data: List<Category>.from(
      (json["data"] ?? []).map((x) => Category.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Category {
  Category({
    required this.categoryId,
    required this.categoryImage,
    required this.categoryTitle,
    required this.categoryCreatedAt,
  });

  final int categoryId;
  final String categoryImage;
  final String categoryTitle;
  final String categoryCreatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryId: json["category_id"] ?? 0,
    categoryImage: json["category_image"] ?? '',
    categoryTitle: json["category_title"] ?? '',
    categoryCreatedAt: json["category_created_at"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_image": categoryImage,
    "category_title": categoryTitle,
    "category_created_at": categoryCreatedAt,
  };
}
