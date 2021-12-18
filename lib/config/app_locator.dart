import 'package:flutter_test_sazzad/config/api_client.dart';
import 'package:flutter_test_sazzad/config/base_url_config.dart';
import 'package:flutter_test_sazzad/config/constant_config.dart';
import 'package:flutter_test_sazzad/domain/repository/post_repository.dart';
import 'package:flutter_test_sazzad/domain/service/post_api_service.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

Future<void> init() async {
  di.registerLazySingleton(() => ApiClient());
  di.registerLazySingleton(() => ConstantConfig());
  di.registerLazySingleton(() => BaseUrlConfig());
  di.registerLazySingleton(() => PostRepository());
  di.registerLazySingleton(() => PostApiService());
/*
  // Bloc
  di.registerLazySingleton(() => AllPostBloc());

  di.registerLazySingleton(() => PostDetailBloc());

  di.registerLazySingleton(() => CreatePostBloc());*/
}
