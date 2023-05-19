import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:product_list/common/failure.dart';

abstract class UseCase<T, Params> {
  const UseCase();

  Future<Either<FailureException, T>> call(Params params);
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
