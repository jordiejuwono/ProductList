import 'package:dartz/dartz.dart';
import 'package:product_list/common/failure.dart';
import 'package:product_list/common/use_case.dart';
import 'package:product_list/domain/entities/product_list.dart';
import 'package:product_list/domain/entities/product_table.dart';
import 'package:product_list/domain/repository/product_repository.dart';

class FetchProductCartUseCase extends UseCase<List<ProductTable>, NoParams> {
  final ProductRepository repository;
  FetchProductCartUseCase({
    required this.repository,
  });

  @override
  Future<Either<FailureException, List<ProductTable>>> call(
      NoParams params) async {
    return await repository.fetchProductCart();
  }
}
