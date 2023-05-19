import 'package:product_list/common/exception.dart';
import 'package:product_list/data/datasource/local/db/database_helper.dart';
import 'package:product_list/data/mapper/data_mapper.dart';
import 'package:product_list/domain/entities/product_list.dart';
import 'package:product_list/domain/entities/product_table.dart';

abstract class LocalDataSource {
  Future<int> insertProduct(ProductTable product);
  Future<List<ProductTable>> fetchProductCart();
  Future<int> editProduct(ProductTable product);
}

class LocalDataSourceImpl implements LocalDataSource {
  final DatabaseHelper databaseHelper;

  LocalDataSourceImpl({
    required this.databaseHelper,
  });

  @override
  Future<List<ProductTable>> fetchProductCart() async {
    try {
      final result = await databaseHelper.fetchProductCart();
      return result.map((e) => ProductTable.fromJson(e)).toList();
    } catch (error) {
      throw DatabaseException(errorMessage: error.toString());
    }
  }

  @override
  Future<int> insertProduct(ProductTable product) async {
    try {
      final result = await databaseHelper.insertProduct(product);
      return result;
    } catch (error) {
      throw DatabaseException(errorMessage: error.toString());
    }
  }

  @override
  Future<int> editProduct(ProductTable product) async {
    try {
      final result = await databaseHelper.editProduct(product);
      return result;
    } catch (error) {
      throw DatabaseException(errorMessage: error.toString());
    }
  }
}
