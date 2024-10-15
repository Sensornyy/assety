abstract class Result<S, F> {
  final S? data;
  final F? error;
  final bool isError;

  Result._({
    this.data,
    this.error,
    required this.isError,
  });

  factory Result.success() {
    return _Success();
  }

  factory Result.successWithData(S data) {
    return _SuccessWithData(data: data);
  }

  factory Result.failure([F? error]) {
    return _Failure(error: error);
  }

  void when({
    void Function()? success,
    void Function(S)? successWithData,
    void Function(F?)? failure,
  }) {
    if (isError && failure != null) {
      failure(error);
    } else if (data == null && success != null) {
      success();
    } else if (successWithData != null) {
      successWithData(data!);
    }
  }
}

class _Success<S, F> extends Result<S, F> {
  _Success() : super._(isError: false, data: null);
}

class _SuccessWithData<S, F> extends Result<S, F> {
  final S data;

  _SuccessWithData({required this.data}) : super._(isError: false, data: data);
}

class _Failure<S, F> extends Result<S, F> {
  _Failure({F? error}) : super._(isError: true, error: error, data: null);
}
