import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:laantech_download_manager/features/auth/data/models/user_model.dart';

@injectable
class AuthenticationLocalSource {
  final FlutterSecureStorage _storage;
  AuthenticationLocalSource({required this._storage});

  static const _userKey = 'user';
  static const _tokenKey = 'token';
  static const _expiryKey = 'token_expires_at';

  Future<void> saveUser(UserModel user) =>
      _storage.write(key: _userKey, value: jsonEncode(user.toJson()));

  Future<UserModel?> getUser() async {
    final data = await _storage.read(key: _userKey);
    if (data == null) return null;
    return UserModel.fromJson(jsonDecode(data) as Map<String, dynamic>);
  }

  Future<void> saveToken(String token, {required int expiresInSeconds}) async {
    final expiresAt = DateTime.now().add(Duration(seconds: expiresInSeconds));
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _expiryKey, value: expiresAt.toIso8601String());
  }

  Future<DateTime?> getTokenExpiry() async {
    final data = await _storage.read(key: _expiryKey);
    return data == null ? null : DateTime.parse(data);
  }

  Future<String?> getToken() => _storage.read(key: _tokenKey);

  Future<void> clear() async {
    await _storage.delete(key: _userKey);
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _expiryKey);
  }
}
