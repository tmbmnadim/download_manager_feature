import 'package:laantech_download_manager/features/auth/data/models/user_model.dart';

class LoginResponseModel {
  final UserModel user;
  final String token;
  final String tokenType;
  final int expiresIn;

  const LoginResponseModel({
    required this.user,
    required this.token,
    required this.tokenType,
    required this.expiresIn,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
      tokenType: json['token_type'] as String,
      expiresIn: json['expires_in'] as int,
    );
  }
}
