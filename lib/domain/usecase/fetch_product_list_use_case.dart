import 'package:dartz/dartz.dart';
import 'package:product_list/common/failure.dart';
import 'package:product_list/common/use_case.dart';
import 'package:product_list/domain/entities/product_list.dart';
import 'package:product_list/domain/repository/product_repository.dart';

class FetchProductListUseCase extends UseCase<ProductList, NoParams> {
  final ProductRepository productRepository;

  FetchProductListUseCase({
    required this.productRepository,
  });

  @override
  Future<Either<FailureException, ProductList>> call(NoParams params) async {
    return await productRepository.fetchProductList();
  }
}
