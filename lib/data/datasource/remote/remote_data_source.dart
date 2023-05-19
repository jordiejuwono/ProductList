import 'package:dio/dio.dart';
import 'package:product_list/common/constants.dart';
import 'package:product_list/common/exception.dart';
import 'package:product_list/data/model/product_list_dto.dart';

abstract class RemoteDataSource {
  Future<ProductListDto> fetchProductList();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio dio;

  RemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<ProductListDto> fetchProductList() async {
    try {
      final response = await dio.get(Constants.productUrl);
      return ProductListDto.fromJson(response.data);
    } catch (error) {
      throw ServerException(errorMessage: error.toString());
    }
  }
}
