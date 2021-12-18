import 'package:dio/dio.dart';
import 'package:flutter_test_sazzad/config/api_client.dart';
import 'package:flutter_test_sazzad/config/app_locator.dart';
import 'package:flutter_test_sazzad/config/base_url_config.dart';
import 'package:flutter_test_sazzad/config/constant_config.dart';
import 'package:flutter_test_sazzad/data/local/create_post_model.dart';

class PostApiService {
  Dio dio = di<ApiClient>().dio;
  ConstantConfig constantConfig = di<ConstantConfig>();
  BaseUrlConfig baseConfig = di<BaseUrlConfig>();

  Future fetchAllPost() async {
    return dio.get(
      '${baseConfig.BASE_URL}posts',
      options: Options(headers: {"APIKEY": constantConfig.API_KEY}),
    );
  }

  Future fetchPostDetail({required int postId}) async {
    return dio.get(
      '${baseConfig.BASE_URL}posts/$postId',
      options: Options(headers: {"APIKEY": constantConfig.API_KEY}),
    );
  }

  Future createPost({required CreatePostModel model}) async {
    return dio.post(
      '${baseConfig.BASE_URL}posts',
      data: {
        "title": model.title,
        "description": model.description,
      },
      options: Options(headers: {"APIKEY": constantConfig.API_KEY}),
    );
  }

  Future createComment({required String comment, required int postId}) async {
    return dio.post(
      '${baseConfig.BASE_URL}posts/$postId/comments',
      data: {
        "message": comment,
      },
      options: Options(headers: {"APIKEY": constantConfig.API_KEY}),
    );
  }

  Future deletePost({required int id}) async {
    return dio.delete(
      '${baseConfig.BASE_URL}posts/$id',
      options: Options(headers: {"APIKEY": constantConfig.API_KEY}),
    );
  }

  Future updatePost({required int id, required CreatePostModel model}) async {
    return dio.put(
      '${baseConfig.BASE_URL}posts/$id',
      data: {
        "title": model.title,
        "description": model.description,
      },
      options: Options(headers: {"APIKEY": constantConfig.API_KEY}),
    );
  }
}
