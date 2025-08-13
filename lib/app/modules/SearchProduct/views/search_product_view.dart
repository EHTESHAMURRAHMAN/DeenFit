import 'package:deenfitapp/app/Environment/BASE_URL.dart';
import 'package:deenfitapp/app/Utils/common_utils.dart';
import 'package:deenfitapp/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/search_product_controller.dart';

class SearchProductView extends GetView<SearchProductController> {
  const SearchProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: titleCommon(), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildSearchField(context),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                if (!controller.isProductLoaded.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.filteredProducts.isEmpty) {
                  return const Center(child: Text('No products found'));
                }

                return ListView.builder(
                  itemCount: controller.filteredProducts.length,
                  itemBuilder: (context, index) {
                    final item = controller.filteredProducts[index];
                    final String image = item.productImage.split(',').first;

                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          Routes.PRODUCT_DETAIL,
                          arguments: {"product": item},
                        );
                      },
                      child: Card(
                        color: Get.theme.canvasColor,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  "${ApiConstants.base}/ServiceProduct/$image",
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (_, __, ___) => const Icon(
                                        Icons.broken_image,
                                        size: 80,
                                      ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.productTitle,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),
                                    _buildRatingStars(item.rating),
                                    const SizedBox(height: 6),
                                    _buildDiscountTag(item.discount),
                                    const SizedBox(height: 6),
                                    _buildPriceRow(
                                      item.sellingPrice,
                                      item.price,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Get.theme.canvasColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: TextFormField(
          onChanged: controller.filterProducts,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Get.theme.primaryColor),
            suffixIcon: InkWell(
              onTap: () {
                controller.filterProducts('');
                FocusScope.of(context).unfocus();
              },
              child: Icon(Icons.cancel_outlined, color: Colors.red),
            ),
            hintText: 'Search product by title...',
            hintStyle: TextStyle(color: Get.theme.primaryColor),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating
              ? Icons.star
              : index < rating + 0.5
              ? Icons.star_half
              : Icons.star_border,
          size: 16,
          color: Get.theme.primaryColor,
        );
      }),
    );
  }

  Widget _buildDiscountTag(double discount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Get.theme.highlightColor.withOpacity(.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.arrow_downward, size: 10, color: Colors.red.shade600),
          const SizedBox(width: 4),
          Text(
            '₹${discount.toString()}',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade600,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(double sellingPrice, double originalPrice) {
    return Row(
      children: [
        Text(
          '₹$sellingPrice',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '₹$originalPrice',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Get.theme.highlightColor,
            decoration: TextDecoration.lineThrough,
          ),
        ),
      ],
    );
  }
}
