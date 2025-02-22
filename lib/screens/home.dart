import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_with_node/providers/global_access.dart';
import 'package:flutter_with_node/screens/item_details.dart';
import 'package:flutter_with_node/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final allProductsData = ref.watch(getAllProductsProvider);

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text("Flutter with Node"),
      ),
      body: allProductsData.when(
        data: (data) {
          return RefreshIndicator(
            onRefresh: () {
              return ref.refresh(getAllProductsProvider.future);
            },
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 2,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemDetails(
                            itemId: data[index]['_id'],
                          ),
                        ));
                  },
                  child: ItemCard(
                    title: data[index]['title'],
                    brand: data[index]['brand'] ?? "",
                    price: "₹ ${data[index]['price']}",
                    discountPercentage: "${data[index]['discountPercentage']}%",
                    imgUrl: data[index]['thumbnail'].toString(),
                  ),
                );
              },
            ),
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text(error.toString()),
          );
        },
        loading: () {
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 4,
            ),
            itemBuilder: (context, index) => Shimmer.fromColors(
                baseColor: AppColors.grey,
                highlightColor: AppColors.softGrey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 200,
                    width: 500,
                    decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                )),
            itemCount: 10,
          );
        },
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final String title;
  final String brand;
  final String price;
  final String discountPercentage;
  final String imgUrl;

  const ItemCard({
    super.key,
    required this.title,
    required this.brand,
    required this.price,
    required this.discountPercentage,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        width: 500,
        decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                height: 100,
                width: 500,
                decoration: const BoxDecoration(
                    color: AppColors.lightContainer,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: CachedNetworkImage(
                  imageUrl: imgUrl,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: AppColors.grey,
                    highlightColor: AppColors.softGrey,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      height: 100, // Placeholder height
                      width: 500, // Placeholder width
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Text(title),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(brand),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                      ),
                      const Icon(
                        Icons.delete,
                        color: AppColors.error,
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
