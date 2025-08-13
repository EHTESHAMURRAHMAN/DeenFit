import 'package:carousel_slider/carousel_slider.dart';
import 'package:deenfitapp/app/Environment/BASE_URL.dart';
import 'package:deenfitapp/app/Utils/common_utils.dart';
import 'package:deenfitapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: titleCommon()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Obx(() {
          if (!controller.isProductLoaded.value ||
              !controller.isCategoryLoaded.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.0,
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                  ),
                  items:
                      imgList
                          .map(
                            (item) => Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 5.0,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(
                                  item,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Categories',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.category.length,
                    separatorBuilder:
                        (context, index) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final item = controller.category[index];
                      return Column(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(item.categoryImage),
                            backgroundColor: Colors.grey[200],
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: 100,
                            child: Text(
                              item.categoryTitle,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Products',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.product.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    final item = controller.product[index];
                    final List<String> images = item.productImage.split(',');
                    final String firstImage =
                        images.isNotEmpty ? images[0] : '';

                    return InkWell(
                      onTap: () {
                        Get.toNamed(
                          Routes.PRODUCT_DETAIL,
                          arguments: {"product": item},
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Get.theme.canvasColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10),
                                ),
                                child: Image.network(
                                  "${ApiConstants.base}/ServiceProduct/$firstImage",
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          const Icon(Icons.broken_image),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Text(
                                item.productTitle,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Row(
                                children: List.generate(5, (starIndex) {
                                  double rating = item.rating;
                                  return Icon(
                                    starIndex < rating
                                        ? Icons.star
                                        : starIndex < rating + 0.5
                                        ? Icons.star_half
                                        : Icons.star_border,
                                    size: 16,
                                    color: Get.theme.primaryColor,
                                  );
                                }),
                              ),
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Get.theme.highlightColor.withOpacity(
                                    .2,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.arrow_downward,
                                      color: Colors.red.shade600,
                                      size: 10,
                                    ),
                                    Text(
                                      '₹${item.discount.toString()}',
                                      style: TextStyle(
                                        color: Colors.red.shade600,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    '₹${item.sellingPrice.toString()}',
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    '₹${item.price.toString()}',
                                    style: TextStyle(
                                      color: Get.theme.highlightColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 3),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
