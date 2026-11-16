import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:laantech_download_manager/core/network/dio_client.dart';
import 'package:laantech_download_manager/features/auth/data/models/login_response_model.dart';

@lazySingleton
class AuthenticationRemoteSource {
  final ApiService _apiService;
  AuthenticationRemoteSource({required this._apiService});

  Future<LoginResponseModel> login(String username, String password) async {
    final response = await _apiService.dio.post(
      '/token',
      data: {'username': username, 'password': password},
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
    return LoginResponseModel.fromJson(response.data as Map<String, dynamic>);
  }

  void setToken(String? token) => _apiService.setAuthToken(token);
}
