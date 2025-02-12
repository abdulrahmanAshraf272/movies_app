import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exceptions.freezed.dart';

@freezed
abstract class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;
  const factory NetworkExceptions.unauthorizedRequest(String reason) =
      UnauthorizedRequest;
  const factory NetworkExceptions.badRequest() = BadRequest;
  const factory NetworkExceptions.notFound(String reason) = NotFound;
  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;
  const factory NetworkExceptions.notAcceptable() = NotAcceptable;
  const factory NetworkExceptions.requestTimeout() = RequestTimeout;
  const factory NetworkExceptions.sendTimeout() = SendTimeout;
  const factory NetworkExceptions.unprocessableEntity(String reason) =
      UnprocessableEntity;
  const factory NetworkExceptions.conflict() = Conflict;
  const factory NetworkExceptions.internalServerError() = InternalServerError;
  const factory NetworkExceptions.notImplemented() = NotImplemented;
  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;
  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;
  const factory NetworkExceptions.formatException() = FormatException;
  const factory NetworkExceptions.unableToProcess() = UnableToProcess;
  const factory NetworkExceptions.defaultError(String error) = DefaultError;
  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  /// Handle API response errors based on status codes
  static NetworkExceptions handleResponse(Response? response) {
    final int statusCode = response?.statusCode ?? 0;
    final String errorMessage = response?.data?['message'] ?? 'Unknown error';

    switch (statusCode) {
      case 400:
      case 401:
      case 403:
        return NetworkExceptions.unauthorizedRequest(errorMessage);
      case 404:
        return NetworkExceptions.notFound(errorMessage);
      case 409:
        return const NetworkExceptions.conflict();
      case 408:
        return const NetworkExceptions.requestTimeout();
      case 422:
        return NetworkExceptions.unprocessableEntity(errorMessage);
      case 500:
        return const NetworkExceptions.internalServerError();
      case 503:
        return const NetworkExceptions.serviceUnavailable();
      default:
        return NetworkExceptions.defaultError(
            "Received status code: $statusCode");
    }
  }

  /// Handle Dio exceptions
  static NetworkExceptions getDioException(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.cancel:
          return const NetworkExceptions.requestCancelled();
        case DioExceptionType.connectionTimeout:
          return const NetworkExceptions.requestTimeout();
        case DioExceptionType.connectionError:
          return const NetworkExceptions.noInternetConnection();
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return const NetworkExceptions.sendTimeout();
        case DioExceptionType.badResponse:
          return NetworkExceptions.handleResponse(error.response);
        case DioExceptionType.badCertificate:
          return const NetworkExceptions.unexpectedError();
        case DioExceptionType.unknown:
          return NetworkExceptions.defaultError(
              error.message ?? "Unknown network error");
      }
    } else if (error is SocketException) {
      return const NetworkExceptions.noInternetConnection();
    } else if (error is FormatException) {
      return const NetworkExceptions.formatException();
    } else {
      return NetworkExceptions.defaultError(error.toString());
    }
  }

  /// Get a user-friendly error message
  static String getErrorMessage(NetworkExceptions exception) {
    return exception.when(
      notImplemented: () => "Not Implemented",
      requestCancelled: () => "Request Cancelled",
      internalServerError: () => "Internal Server Error",
      notFound: (reason) => reason,
      serviceUnavailable: () => "Service unavailable",
      methodNotAllowed: () => "Method Not Allowed",
      badRequest: () => "Bad Request",
      unauthorizedRequest: (reason) => reason,
      unprocessableEntity: (reason) => reason,
      unexpectedError: () => "Unexpected error occurred",
      requestTimeout: () => "Request Timeout",
      noInternetConnection: () => "No Internet Connection",
      conflict: () => "Conflict Error",
      sendTimeout: () => "Send Timeout",
      unableToProcess: () => "Unable to Process Data",
      defaultError: (error) => error,
      formatException: () => "Format Exception",
      notAcceptable: () => "Not Acceptable",
    );
  }
}
