sealed class AppException implements Exception {
  const AppException(this.message);
  final String message;
}

final class NetworkException extends AppException {
  const NetworkException(super.message);
}

final class TimeoutException extends AppException {
  const TimeoutException(super.message);
}

final class ParseException extends AppException {
  const ParseException(super.message);
}

final class CacheException extends AppException {
  const CacheException(super.message);
}

final class UnknownException extends AppException {
  const UnknownException(super.message);
}
