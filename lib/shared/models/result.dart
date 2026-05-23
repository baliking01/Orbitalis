import 'package:orbitalis/core/errors/app_exception.dart';

typedef Result<T> = ({T? data, AppException? error});

extension ResultX<T> on Result<T> {
  bool get isSuccess => error == null;
  bool get isFailure => error != null;

  R fold<R>(
    R Function(T data) onSuccess,
    R Function(AppException error) onFailure,
  ) {
    if (isSuccess) return onSuccess(data as T);
    return onFailure(error!);
  }
}

Result<T> success<T>(T data) => (data: data, error: null);
Result<T> failure<T>(AppException error) => (data: null, error: error);
