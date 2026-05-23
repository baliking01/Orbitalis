import 'package:dio/dio.dart';
import 'package:orbitalis/core/errors/app_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = switch (err.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        const TimeoutException('Request timed out. Please try again.'),
      DioExceptionType.connectionError =>
        const NetworkException('No internet connection.'),
      DioExceptionType.badResponse => NetworkException(
          'Server error ${err.response?.statusCode ?? 'unknown'}.',
        ),
      _ => UnknownException(err.message ?? 'An unknown error occurred.'),
    };

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: exception,
        type: err.type,
        message: exception.message,
      ),
    );
  }
}
