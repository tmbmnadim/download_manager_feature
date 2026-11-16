import 'package:dio/dio.dart';
import 'package:laantech_download_manager/core/error/failure.dart';

extension DioExceptionToFailure on DioException {
  Failure toFailure() {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return const Failure('The connection timed out. Please try again.');
      case DioExceptionType.connectionError:
        return const Failure('No connection. Check your internet.');
      case DioExceptionType.cancel:
        return const Failure('Cancelled.');
      case DioExceptionType.badResponse:
        final code = response?.statusCode;
        return Failure(
          _serverMessage() ?? 'Server error ($code).',
          statusCode: code,
        );
      case DioExceptionType.badCertificate:
      case DioExceptionType.unknown:
        return const Failure('Something went wrong. Please try again.');
    }
  }

  /// The API replies with `{"success": false, "error": "..."}`.
  String? _serverMessage() {
    final data = response?.data;
    if (data is Map && data['error'] is String) return data['error'] as String;
    return null;
  }
}
