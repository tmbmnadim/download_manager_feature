import 'dart:async';

import 'package:background_downloader/background_downloader.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:laantech_download_manager/core/error/failure.dart';
import 'package:laantech_download_manager/features/dashboard/data/datasources/transfers_network_source.dart';
import 'package:laantech_download_manager/features/dashboard/data/models/transfer_model.dart';
import 'package:laantech_download_manager/features/dashboard/domain/entities/transfer_entity.dart';
import 'package:laantech_download_manager/features/dashboard/domain/repositories/transfer_repository.dart';
import 'package:laantech_download_manager/features/files/data/models/file_model.dart';
import 'package:laantech_download_manager/features/files/domain/entities/file_entity.dart';

/// A singleton, because it owns the global list of transfers.
@LazySingleton(as: TransferRepository)
class TransferRepositoryImpl implements TransferRepository {
  final TransfersNetworkSource _source;

  TransferRepositoryImpl(this._source) {
    _source.getTaskUpdateStream().listen(_onUpdate);
    _source.resumeFromBackground();
  }

  final Map<String, TransferModel> _transfers = {};
  final StreamController<List<TransferEntity>> _controller =
      StreamController.broadcast();

  List<TransferEntity> _snapshot() => List.unmodifiable(_transfers.values);

  void _emit() => _controller.add(_snapshot());

  void _onUpdate(TaskUpdate update) {
    final id = update.task.taskId;
    var current = _transfers[id];
    if (current == null) {
      try {
        current = TransferModel.fromTask(update.task);
      } catch (_) {
        return;
      }
    }

    if (update is TaskStatusUpdate) {
      current = current.applyStatus(update);
    } else if (update is TaskProgressUpdate) {
      current = current.applyProgress(update);
    }
    _transfers[id] = current;
    _emit();
  }

  @override
  Stream<List<TransferEntity>> watchTransfers() async* {
    yield _snapshot();
    yield* _controller.stream;
  }

  @override
  Future<Either<Failure, Unit>> startDownload(FileEntity file) async {
    final id = file.id.toString();
    if (_transfers[id]?.isActive ?? false) {
      return left(const Failure('This file is already downloading.'));
    }
    try {
      final task = await _source.downloadFile(FileModel.fromEntity(file));
      _transfers[id] = TransferModel.fromTask(task);
      _emit();
      return right(unit);
    } catch (_) {
      return left(const Failure('Could not start the download.'));
    }
  }

  @override
  Future<Either<Failure, Unit>> pause(String transferId) =>
      _run(() => _source.pause(transferId), 'Could not pause the download.');

  @override
  Future<Either<Failure, Unit>> resume(String transferId) =>
      _run(() => _source.resume(transferId), 'Could not resume the download.');

  @override
  Future<Either<Failure, Unit>> cancel(String transferId) =>
      _run(() => _source.cancel(transferId), 'Could not cancel the download.');

  @override
  Future<Either<Failure, Unit>> retry(String transferId) async {
    final transfer = _transfers[transferId];
    if (transfer == null) return left(const Failure('Transfer not found.'));
    _transfers.remove(transferId);
    return startDownload(transfer.file);
  }

  Future<Either<Failure, Unit>> _run(
    Future<bool> Function() action,
    String errorMessage,
  ) async {
    try {
      final ok = await action();
      return ok ? right(unit) : left(Failure(errorMessage));
    } catch (_) {
      return left(Failure(errorMessage));
    }
  }
}
