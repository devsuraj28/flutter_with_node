import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_with_node/services/api_services.dart';

class DataProvider {
  Ref ref;

  DataProvider(this.ref);

  Future<List<dynamic>> getAllProducts() async {
    try {
      Response response =
          await ref.read(apiServicesProvider).get(doc: '/api/products');

      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        return [];
      }
    } on DioException catch (e) {
      throw Exception("Here Exception Occurs $e");
    }
  }

  Future<dynamic> getProductDetail(String productId) async {
    try {
      Response response = await ref
          .read(apiServicesProvider)
          .getById(doc: '/api/products', id: productId);

      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        return [];
      }
    } on DioException catch (e) {
      throw Exception("Here Exception Occurs $e");
    }
  }
}

final getDataProvider = Provider<DataProvider>((ref) => DataProvider(ref));
