import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:laantech_download_manager/core/error/failure.dart';
import 'package:laantech_download_manager/features/files/domain/entities/file_entity.dart';
import 'package:laantech_download_manager/features/dashboard/domain/repositories/transfer_repository.dart';

@injectable
class StartDownloadUseCase {
  final TransferRepository _repository;
  StartDownloadUseCase(this._repository);

  Future<Either<Failure, Unit>> call(FileEntity file) =>
      _repository.startDownload(file);
}
