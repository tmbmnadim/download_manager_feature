import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:laantech_download_manager/core/error/dio_error_mapper.dart';
import 'package:laantech_download_manager/core/error/failure.dart';
import 'package:laantech_download_manager/features/auth/data/datasources/authentication_local_source.dart';
import 'package:laantech_download_manager/features/auth/data/datasources/authentication_remote_source.dart';
import 'package:laantech_download_manager/features/auth/domain/entities/user_entity.dart';
import 'package:laantech_download_manager/features/auth/domain/repositories/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthenticationRemoteSource _remote;
  final AuthenticationLocalSource _local;

  AuthRepositoryImpl({required this._remote, required this._local});

  @override
  Future<Either<Failure, UserEntity>> login(
    String username,
    String password,
  ) async {
    try {
      final result = await _remote.login(username, password);
      await _local.saveToken(result.token, expiresInSeconds: result.expiresIn);
      await _local.saveUser(result.user);
      _remote.setToken(result.token);
      return right(result.user);
    } on DioException catch (e) {
      return left(e.toFailure());
    } on FormatException {
      return left(const Failure('Unexpected response from the server.'));
    } on TypeError {
      return left(const Failure('Unexpected response from the server.'));
    } catch (_) {
      return left(const Failure('Could not save your session.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> restoreSession() async {
    try {
      final token = await _local.getToken();
      final user = await _local.getUser();
      final expiry = await _local.getTokenExpiry();
      if (token == null || user == null || expiry == null) return right(null);
      if (!expiry.isAfter(DateTime.now())) {
        await _local.clear();
        return right(null);
      }
      _remote.setToken(token);
      return right(user);
    } catch (_) {
      return left(const Failure('Could not read your saved session.'));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await _local.clear();
      _remote.setToken(null);
      return right(unit);
    } catch (_) {
      return left(const Failure('Could not log out.'));
    }
  }
}
