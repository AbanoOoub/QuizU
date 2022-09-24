import 'package:dio/dio.dart';

import '../constant/end_points.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 10000,
      receiveDataWhenStatusError: true,
      followRedirects: false,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      headers: {"Accept": "application/json"},
      validateStatus: (_) => true,
    ));
  }

  static Future<Response> getData(
      {required String endPoint, required String token}) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    return await dio.get(endPoint);
  }

  static Future<Response> postData({
    required String endPoint,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    token != null
        ? dio.options.headers = {
            'Authorization': 'Bearer $token',
          }
        : null;

    return dio.post(endPoint, queryParameters: query, data: data);
  }
}
