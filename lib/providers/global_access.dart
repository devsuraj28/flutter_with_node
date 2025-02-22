import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_with_node/providers/data_provider.dart';

final getAllProductsProvider = FutureProvider.autoDispose(
    (ref) => ref.read(getDataProvider).getAllProducts());

final productDetailProvider =
    FutureProvider.autoDispose.family<dynamic, String>(
  (ref, productId) => ref.read(getDataProvider).getProductDetail(productId),
);
