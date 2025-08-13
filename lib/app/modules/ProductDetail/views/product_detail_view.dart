import 'package:deenfitapp/app/Environment/BASE_URL.dart';
import 'package:deenfitapp/app/Utils/common_utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/product_detail_controller.dart';

class ProductDetailView extends GetView<ProductDetailController> {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images =
        controller.product.value?.productImage.split(',') ?? [];
    controller.selectedImage.value =
        "${ApiConstants.base}/ServiceProduct/${images.first}";

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: backbutton(),
        title: titleCommon(),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Obx(
            () => AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                controller.selectedImage.value,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder:
                    (context, error, stackTrace) =>
                        const Icon(Icons.broken_image),
              ),
            ),
          ),
          const SizedBox(height: 10),

          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                final thumbUrl =
                    "${ApiConstants.base}/ServiceProduct/${images[index]}";
                return GestureDetector(
                  onTap: () => controller.selectedImage.value = thumbUrl,
                  child: Obx(
                    () => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              controller.selectedImage.value == thumbUrl
                                  ? Get.theme.primaryColor
                                  : Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          thumbUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) =>
                                  const Icon(Icons.broken_image),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                Text(
                  controller.product.value?.productTitle ?? '',
                  style: Get.theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Text(
                      '₹${controller.product.value?.sellingPrice ?? 0}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '₹${controller.product.value?.price ?? 0.0}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '-₹${controller.product.value?.discount ?? 0.0} OFF',
                      style: const TextStyle(fontSize: 14, color: Colors.red),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Row(
                  children: List.generate(5, (index) {
                    double rating = controller.product.value?.rating ?? 0.0;
                    return Icon(
                      index < rating
                          ? Icons.star
                          : index < rating + 0.5
                          ? Icons.star_half
                          : Icons.star_border,
                      color: Get.theme.primaryColor,
                      size: 20,
                    );
                  }),
                ),

                const SizedBox(height: 16),

                Text(
                  controller.product.value?.description ?? '',
                  style: Get.theme.textTheme.bodyLarge,
                ),

                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Get.snackbar(
                            'Added to Cart',
                            '${controller.product.value?.productTitle ?? ''} added successfully!',
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: BorderSide(
                            color: Get.theme.primaryColor,
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 16,
                            color: Get.theme.primaryColor,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          controller.placeOrder();
                        },
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: Get.theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Buy Now',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildDetailRow(
                  "Quantity",
                  controller.product.value?.quantity.toString() ?? '',
                ),
                _buildDetailRow("Color", controller.product.value?.color ?? ''),
                _buildDetailRow("Size", controller.product.value?.size ?? ''),
                _buildDetailRow(
                  "Category",
                  controller.product.value?.categoryTitle ?? '',
                ),
                _buildDetailRow(
                  "Created At",
                  controller.product.value?.productCreatedAt ?? '',
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              "$label:",
              style: Get.theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(child: Text(value, style: Get.theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
