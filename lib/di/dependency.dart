import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:product_list/common/dio_handler.dart';
import 'package:product_list/data/datasource/local/db/database_helper.dart';
import 'package:product_list/data/datasource/local/local_data_source.dart';
import 'package:product_list/data/datasource/remote/remote_data_source.dart';
import 'package:product_list/data/mapper/data_mapper.dart';
import 'package:product_list/data/repository/product_repository_impl.dart';
import 'package:product_list/domain/repository/product_repository.dart';
import 'package:product_list/domain/usecase/delete_product_use_case.dart';
import 'package:product_list/domain/usecase/edit_product_use_case.dart';
import 'package:product_list/domain/usecase/fetch_product_cart_use_case.dart';
import 'package:product_list/domain/usecase/fetch_product_list_use_case.dart';
import 'package:product_list/domain/usecase/insert_cart_use_case.dart';

final locator = GetIt.instance;

void init() {
  _registerDio();
  _registerDb();
  _registerData();
  _registerMapper();
  _registerDomain();
  _registerUseCase();
}

void _registerDio() {
  locator.registerLazySingleton<Dio>(() => DioHandler().dio);
}

void _registerDb() {
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
}

void _registerData() {
  locator.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(dio: locator()));
  locator.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(databaseHelper: locator()));
}

void _registerMapper() {
  locator.registerLazySingleton(() => DataMapper());
}

void _registerDomain() {
  locator.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
      mapper: locator(),
      remoteDataSource: locator(),
      localDataSource: locator()));
}

void _registerUseCase() {
  locator.registerLazySingleton(
      () => FetchProductListUseCase(productRepository: locator()));
  locator.registerLazySingleton(
      () => FetchProductCartUseCase(repository: locator()));
  locator.registerLazySingleton(() => InsertCartUseCase(repository: locator()));
  locator
      .registerLazySingleton(() => EditProductUseCase(repository: locator()));
  locator
      .registerLazySingleton(() => DeleteProductUseCase(repository: locator()));
}
