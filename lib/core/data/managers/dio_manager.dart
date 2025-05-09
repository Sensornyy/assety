import 'dart:io' show SocketException;

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

@singleton
class DioManager {
  final Dio dio;
  final Talker _talker;

  DioManager(
    this.dio,
    this._talker,
  ) {
    dio.interceptors.add(
      TalkerDioLogger(
        talker: _talker,
        settings: TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
          requestFilter: (options) => !options.path.endsWith('pdf'),
          responseFilter: (response) =>
              response.headers.value('content-type') == 'application/json',
        ),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, errorHandler) async {
          try {
            if (_isTimeout(error)) {
              errorHandler.next(
                _ResponseError(
                  message: 'No internet connection',
                  response: error.response,
                  requestOptions: error.requestOptions,
                ),
              );
              return;
            }

            if (error.response == null) {
              errorHandler.next(
                _ResponseError(
                  message: 'Something went wrong',
                  response: error.response,
                  requestOptions: error.requestOptions,
                ),
              );
              return;
            }

            String? errorMessage;
            if (error.response!.statusCode.toString().startsWith('5')) {
              errorMessage = 'Internal server error';
            }

            errorHandler.next(
              _ResponseError(
                message: errorMessage,
                statusCode: error.response?.statusCode,
                response: error.response,
                requestOptions: error.requestOptions,
              ),
            );
          } catch (e) {
            errorHandler.next(
              _ResponseError(
                message: 'Something went wrong',
                requestOptions: error.requestOptions,
              ),
            );
            return;
          }
        },
      ),
    );
  }

  static bool _isTimeout(DioException? err) {
    return err != null &&
        (err.type == DioExceptionType.connectionTimeout ||
            err.type == DioExceptionType.connectionError ||
            err.type == DioExceptionType.receiveTimeout ||
            err.type == DioExceptionType.sendTimeout ||
            err.type == DioExceptionType.unknown && err.error is SocketException);
  }
}

class _ResponseError extends DioException {
  @override
  // ignore: overridden_fields
  final RequestOptions requestOptions;

  @override
  // ignore: overridden_fields
  final String? message;

  @override
  // ignore: overridden_fields
  final Response<dynamic>? response;

  final int? statusCode;

  _ResponseError({
    required this.requestOptions,
    this.message,
    this.response,
    this.statusCode,
  }) : super(
          requestOptions: requestOptions,
          response: response,
        );
}
