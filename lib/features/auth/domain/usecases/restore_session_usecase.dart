import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:laantech_download_manager/core/error/failure.dart';
import 'package:laantech_download_manager/features/auth/domain/entities/user_entity.dart';
import 'package:laantech_download_manager/features/auth/domain/repositories/auth_repository.dart';

@injectable
class RestoreSessionUseCase {
  final AuthRepository _repository;
  RestoreSessionUseCase(this._repository);

  /// Right(null) means there is no valid saved session.
  Future<Either<Failure, UserEntity?>> call() => _repository.restoreSession();
}
