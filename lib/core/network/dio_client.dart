import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:laantech_download_manager/core/network/logging_interceptor.dart';

@lazySingleton
class ApiService {
  final Dio dio;
  ApiService({required this.dio}) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_token != null) {
            options.headers['Authorization'] = 'Bearer $_token';
          }
          handler.next(options);
        },
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(LoggingInterceptor());
    }
  }

  String? _token;
  Map<String, String> get authHeaders =>
      _token == null ? {} : {'Authorization': 'Bearer $_token'};

  void setAuthToken(String? token) {
    _token = token;
  }
}
