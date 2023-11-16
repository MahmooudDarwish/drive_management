import 'package:driver_management/core/api_constance.dart';
import 'package:dio/dio.dart';


class DioHelper {
  late Dio dio;

  init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstance.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );
  }

  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': "Bearer $token",
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': "Bearer $token",
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': "Bearer $token",
    };
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
