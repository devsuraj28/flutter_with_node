import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_with_node/providers/data_provider.dart';

final getAllProductsProvider =
    FutureProvider.autoDispose((ref) => ref.read(getDataProvider).getAllProducts());
