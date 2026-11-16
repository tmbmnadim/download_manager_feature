import 'package:fpdart/fpdart.dart';
import 'package:laantech_download_manager/core/error/failure.dart';
import 'package:laantech_download_manager/features/dashboard/domain/entities/transfer_entity.dart';
import 'package:laantech_download_manager/features/files/domain/entities/file_entity.dart';

abstract class TransferRepository {
  /// Emits the full list of transfers (ongoing and recent) on every change.
  /// The current list is emitted first.
  Stream<List<TransferEntity>> watchTransfers();

  Future<Either<Failure, Unit>> startDownload(FileEntity file);
  Future<Either<Failure, Unit>> pause(String transferId);
  Future<Either<Failure, Unit>> resume(String transferId);
  Future<Either<Failure, Unit>> cancel(String transferId);
  Future<Either<Failure, Unit>> retry(String transferId);
}
