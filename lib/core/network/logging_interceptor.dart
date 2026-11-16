import 'dart:developer';
import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  static const _name = 'ApiService';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('================== REQUEST DETAILS ==================', name: _name);
    log('${options.method} ${options.uri}', name: _name);
    log('HEADERS : ${options.headers}', name: _name);
    if (options.queryParameters.isNotEmpty) {
      log('QUERY   : ${options.queryParameters}', name: _name);
    }
    if (options.data != null) {
      log('BODY    : ${_describeBody(options.data)}', name: _name);
    }
    handler.next(options);
  }

  String _describeBody(dynamic data) {
    if (data is! FormData) return data.toString();

    final fields = data.fields.map((e) => '${e.key}: ${e.value}').join(', ');
    final files = data.files
        .map((e) => '${e.key}: ${e.value.filename}')
        .join(', ');
    return 'FormData{fields: {$fields}, files: {$files}}';
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    log('================== RESPONSE DETAILS ==================', name: _name);
    log(
      '${response.requestOptions.method} ${response.requestOptions.uri}',
      name: _name,
    );
    log('STATUS  : ${response.statusCode}', name: _name);
    log('RES BODY: ${response.data}', name: _name);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log(
      '================== RESPONSE DETAILS (ERROR) ==================',
      name: _name,
    );
    log('${err.requestOptions.method} ${err.requestOptions.uri}', name: _name);
    log('STATUS  : ${err.response?.statusCode}', name: _name);
    log('RES BODY: ${err.response?.data ?? err.message}', name: _name);
    handler.next(err);
  }
}
