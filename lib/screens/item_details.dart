import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_with_node/utils/colors.dart';

import '../providers/global_access.dart';

class ItemDetails extends ConsumerStatefulWidget {
  final String itemId;
  const ItemDetails({super.key,required this.itemId});

  @override
  ConsumerState<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends ConsumerState<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    final productsDetail = ref.watch(productDetailProvider(widget.itemId));

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text("Flutter with Node"),
      ),
      body: productsDetail.when(data: (data) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 1,
                    height: 200.0,
                    autoPlay: true,
                    autoPlayInterval: const Duration(milliseconds: 2000)),
                items: (data['images'] as List<dynamic>).map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.softGrey,
                              blurRadius: 5.0,
                              spreadRadius: 2.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              url,
                              fit: BoxFit.fill,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ?? 1)
                                        : null,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(child: Icon(Icons.error, size: 50, color: Colors.red));
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(data['title']),
                        Row(
                          children: [
                            Text(data['rating'].toString()),
                            const Icon(Icons.star, color: Colors.amber,)
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 4,),
                    Text(data['brand']),
                    const SizedBox(height: 8,),
                    Text(data['availabilityStatus'] ?? "Out of Stock" ),
                    const SizedBox(height: 8,),
                    Text("₹ ${data['price']} with ${data['discountPercentage'] }% off" ),
                    const SizedBox(height: 16,),
                    Text("${data['description']}" ),

                  ],
                ),
              )
            ],
          ),
        );
      }, error: (error, stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      }, loading: () => const Center(
      child: CircularProgressIndicator(),
    ),)
    );
  }
}
