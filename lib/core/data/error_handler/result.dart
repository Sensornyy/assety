import 'dart:async';

abstract class Result<S> {
  final S? data;
  final Exception? error;
  final String? errorMessage;
  final int? errorCode;
  final bool isError;

  Result._({
    this.data,
    this.error,
    this.errorMessage,
    this.errorCode,
    required this.isError,
  });

  factory Result.success() {
    return _Success();
  }

  factory Result.successWithData(S data) {
    return _SuccessWithData(data: data);
  }

  factory Result.failure({Exception? error, String? errorMessage, int? errorCode}) {
    return _Failure(
      error: error,
      errorMessage: errorMessage,
      errorCode: errorCode,
    );
  }

  Future<void> when({
    FutureOr<void> Function()? success,
    FutureOr<void> Function(S)? successWithData,
    FutureOr<void> Function()? failure,
    FutureOr<void> Function(Exception)? failureWithException,
  }) async {
    if (isError && failure != null) {
      await Future.value(failure());
    } else if (isError && failureWithException != null) {
      await Future.value(failureWithException(error!));
    } else if (data == null && success != null) {
      await Future.value(success());
    } else if (successWithData != null) {
      await Future.value(successWithData(data as S));
    }
  }
}

class _Success<S> extends Result<S> {
  _Success() : super._(isError: false, data: null);
}

class _SuccessWithData<S> extends Result<S> {
  _SuccessWithData({super.data}) : super._(isError: false);
}

class _Failure<S> extends Result<S> {
  _Failure({super.error, super.errorMessage, super.errorCode}) : super._(isError: true, data: null);
}
