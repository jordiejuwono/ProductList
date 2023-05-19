import 'package:dartz/dartz.dart';
import 'package:product_list/common/failure.dart';
import 'package:product_list/data/datasource/local/local_data_source.dart';
import 'package:product_list/data/datasource/remote/remote_data_source.dart';
import 'package:product_list/data/mapper/data_mapper.dart';
import 'package:product_list/data/model/product_list_dto.dart';
import 'package:product_list/domain/entities/product_list.dart';
import 'package:product_list/domain/entities/product_table.dart';
import 'package:product_list/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final DataMapper mapper;
  final RemoteDataSource dataSource;
  final LocalDataSource localDataSource;

  ProductRepositoryImpl({
    required this.mapper,
    required this.dataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<FailureException, ProductList>> fetchProductList() async {
    try {
      final response = await dataSource.fetchProductList();
      return Right(mapper.mapProductDtoToProduct(response));
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<FailureException, List<ProductTable>>>
      fetchProductCart() async {
    try {
      final response = await localDataSource.fetchProductCart();
      return Right(response);
    } catch (error) {
      return Left(DatabaseFailure(error.toString()));
    }
  }

  @override
  Future<Either<FailureException, int>> insertProduct(
      ProductTable product) async {
    try {
      final response = await localDataSource.insertProduct(product);
      return Right(response);
    } catch (error) {
      return Left(DatabaseFailure(error.toString()));
    }
  }

  @override
  Future<Either<FailureException, int>> editProduct(
      ProductTable product) async {
    try {
      final response = await localDataSource.editProduct(product);
      return Right(response);
    } catch (error) {
      return Left(DatabaseFailure(error.toString()));
    }
  }
}
