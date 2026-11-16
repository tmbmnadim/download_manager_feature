import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:laantech_download_manager/core/error/failure.dart';
import 'package:laantech_download_manager/features/dashboard/domain/repositories/transfer_repository.dart';

@injectable
class PauseTransferUseCase {
  final TransferRepository _repository;
  PauseTransferUseCase(this._repository);

  Future<Either<Failure, Unit>> call(String transferId) =>
      _repository.pause(transferId);
}
