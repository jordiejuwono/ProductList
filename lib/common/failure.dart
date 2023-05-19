class FailureException {
  final String errorMessage;
  FailureException(this.errorMessage);
}

class ServerFailure extends FailureException {
  ServerFailure(String message) : super(message);
}

class DatabaseFailure extends FailureException {
  DatabaseFailure(String message) : super(message);
}
