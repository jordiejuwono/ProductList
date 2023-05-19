import 'package:dartz/dartz.dart';
import 'package:product_list/common/failure.dart';
import 'package:product_list/common/use_case.dart';
import 'package:product_list/domain/entities/product_table.dart';
import 'package:product_list/domain/repository/product_repository.dart';

class EditProductUseCase extends UseCase<int, ProductTable> {
  final ProductRepository repository;

  EditProductUseCase({
    required this.repository,
  });

  @override
  Future<Either<FailureException, int>> call(ProductTable params) async {
    return await repository.editProduct(params);
  }
}
