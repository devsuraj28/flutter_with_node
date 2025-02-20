import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_with_node/constants/base_url.dart';
import 'dart:developer';

class ApiServices {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseURL,
      connectTimeout: const Duration(seconds: 10),
      headers: {
        'Cookie':
        '_vercel_jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJWQVhlTHpvRG5IMGtNeTRtU3kwanQwZlkiLCJpYXQiOjE3Mzk5ODAwNzksIm93bmVySWQiOiJ0ZWFtX3dPblU4TmFnMUhPb09NVVNROUVhS3VWVCIsImF1ZCI6Im5vZGUtdmVyY2VsLWRlcGxveS03ZXd5MmNnd3otbXlhcHBzLXByb2plY3RzLWFiZGZmN2ZhLnZlcmNlbC5hcHAiLCJ1c2VybmFtZSI6ImRldnN1cmFqMjgiLCJzdWIiOiJzc28tcHJvdGVjdGlvbiJ9.xIRmTKhAmE5prbW_0Oto77IicRdbXLvky394Q45PwwE'
      },
    ),
  );

  Future<Response> get(String doc) async {
    try {
      String fullUrl = "${_dio.options.baseUrl}$doc";
      log("GET Request: $fullUrl");

      Response response = await _dio.get(doc);
      return response;
    } on DioException catch (dioException) {
      log("GET Error: ${dioException.message}");
      throw Exception("From Api Service Get method : $dioException");
    }
  }

  Future<Response> getById(String doc, String id) async {
    try {
      String fullUrl = "${_dio.options.baseUrl}$doc/$id";
      log("GET By ID Request: $fullUrl");

      Response response = await _dio.get("$doc/$id");
      return response;
    } on DioException catch (dioException) {
      log("GET By ID Error: ${dioException.message}");
      throw Exception("From Api Service Get By Id method : $dioException");
    }
  }

  Future<Response> post(String doc, Map<dynamic, dynamic> data) async {
    try {
      String fullUrl = "${_dio.options.baseUrl}$doc";
      log("POST Request: $fullUrl with Data: $data");

      Response response = await _dio.post(doc, data: data);
      return response;
    } on DioException catch (dioException) {
      log("POST Error: ${dioException.message}");
      throw Exception("From Api Service Post method : $dioException");
    }
  }

  Future<Response> update(String doc, String id, Map<dynamic, dynamic> data) async {
    try {
      String fullUrl = "${_dio.options.baseUrl}$doc/$id";
      log("UPDATE Request: $fullUrl with Data: $data");

      Response response = await _dio.put("$doc/$id", data: data);
      return response;
    } on DioException catch (dioException) {
      log("UPDATE Error: ${dioException.message}");
      throw Exception("From Api Service Update method : $dioException");
    }
  }

  Future<Response> delete(String doc, String id) async {
    try {
      String fullUrl = "${_dio.options.baseUrl}$doc/$id";
      log("DELETE Request: $fullUrl");

      Response response = await _dio.delete("$doc/$id");
      return response;
    } on DioException catch (dioException) {
      log("DELETE Error: ${dioException.message}");
      throw Exception("From Api Service Delete method : $dioException");
    }
  }
}

final apiServicesProvider = Provider<ApiServices>((ref) => ApiServices());
