import 'package:fpdart/fpdart.dart';
import 'package:laantech_download_manager/core/error/failure.dart';
import 'package:laantech_download_manager/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  /// Logs in, then stores the token and user and applies the token to the API client.
  Future<Either<Failure, UserEntity>> login(String username, String password);

  /// Restores a saved session on app start. `null` means not logged in.
  Future<Either<Failure, UserEntity?>> restoreSession();

  Future<Either<Failure, Unit>> logout();
}
