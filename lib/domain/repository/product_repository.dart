import 'package:dartz/dartz.dart';
import 'package:product_list/common/failure.dart';
import 'package:product_list/data/model/product_list_dto.dart';
import 'package:product_list/domain/entities/product_list.dart';
import 'package:product_list/domain/entities/product_table.dart';

abstract class ProductRepository {
  Future<Either<FailureException, ProductList>> fetchProductList();
  Future<Either<FailureException, int>> insertProduct(ProductTable product);
  Future<Either<FailureException, List<ProductTable>>> fetchProductCart();
  Future<Either<FailureException, int>> editProduct(ProductTable product);
}
