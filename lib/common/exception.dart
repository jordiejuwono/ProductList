class ServerException implements Exception {
  final String errorMessage;
  ServerException({
    required this.errorMessage,
  });
}

class DatabaseException implements Exception {
  final String errorMessage;
  DatabaseException({
    required this.errorMessage,
  });
}
