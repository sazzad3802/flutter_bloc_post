import 'package:dio/dio.dart';
import 'package:flutter_test_sazzad/config/base_url_config.dart';

class ApiClient {
  late Dio dio;

  ApiClient() {
    dio = Dio(BaseOptions(baseUrl: BaseUrlConfig().BASE_URL));
  }
}
