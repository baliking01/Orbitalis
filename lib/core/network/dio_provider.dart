import 'package:dio/dio.dart';
import 'package:orbitalis/core/constants/app_constants.dart';
import 'package:orbitalis/core/network/interceptors/error_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final options = BaseOptions(
    connectTimeout: AppConstants.networkConnectTimeout,
    receiveTimeout: AppConstants.networkReceiveTimeout,
    sendTimeout: AppConstants.networkConnectTimeout,
  );
  return Dio(options)
    ..interceptors.addAll([
      ErrorInterceptor(),
      PrettyDioLogger(),
    ]);
}
