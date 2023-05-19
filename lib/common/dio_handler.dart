import 'package:dio/dio.dart';

class DioHandler {
  Dio get dio => _getDio();

  Dio _getDio() {
    BaseOptions dioOptions = BaseOptions(
      baseUrl: "https://dummyjson.com/",
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    );
    Dio dio = Dio(dioOptions);

    return dio;
  }
}
