import 'package:dio/dio.dart';

class DioHelper {
  static Dio dio = Dio();
  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
          'lang': 'en',
          'Authorization':
              'Yryy3f65GvGNBXTj3cilEEDoGVLEjiDVSmdWVUlXflzka27MnZDsk2goC1ZlGbKtTgn31Q'
        }));
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    return await dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }
}
