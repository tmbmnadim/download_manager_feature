import 'dart:convert';

import 'package:background_downloader/background_downloader.dart';
import 'package:laantech_download_manager/features/dashboard/domain/entities/transfer_entity.dart';
import 'package:laantech_download_manager/features/files/data/models/file_model.dart';

class TransferModel extends TransferEntity {
  const TransferModel({
    required super.id,
    required super.file,
    required super.type,
    super.status,
    super.progress,
    super.speed,
    super.timeRemaining,
    super.errorMessage,
  });

  /// Builds a new (queued) transfer from a background task.
  ///
  /// The file is read from `task.metaData`, so create the task with
  /// `metaData: jsonEncode(file.toJson())`.
  factory TransferModel.fromTask(Task task) {
    return TransferModel(
      id: task.taskId,
      file: FileModel.fromJson(jsonDecode(task.metaData)),
      type: task is UploadTask ? TransferType.upload : TransferType.download,
    );
  }

  TransferModel copyWith({
    TransferStatus? status,
    double? progress,
    double? speed,
    Duration? timeRemaining,
    String? errorMessage,
  }) {
    return TransferModel(
      id: id,
      file: file,
      type: type,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      speed: speed ?? this.speed,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  TransferModel applyStatus(TaskStatusUpdate update) {
    switch (update.status) {
      case TaskStatus.enqueued:
      case TaskStatus.waitingToRetry:
        return copyWith(status: TransferStatus.queued);
      case TaskStatus.running:
        return copyWith(status: TransferStatus.running);
      case TaskStatus.paused:
        return copyWith(status: TransferStatus.paused);
      case TaskStatus.complete:
        return copyWith(status: TransferStatus.completed, progress: 1);
      case TaskStatus.canceled:
        return copyWith(status: TransferStatus.canceled);
      case TaskStatus.notFound:
        return copyWith(
          status: TransferStatus.failed,
          errorMessage: 'File not found on the server.',
        );
      case TaskStatus.failed:
        return copyWith(
          status: TransferStatus.failed,
          errorMessage: update.exception?.description ?? 'Transfer failed.',
        );
    }
  }

  TransferModel applyProgress(TaskProgressUpdate update) {
    // Negative values are status codes (failed, canceled, paused...), not progress.
    if (update.progress < 0) return this;
    return copyWith(
      progress: update.progress,
      speed: update.networkSpeed >= 0 ? update.networkSpeed : null,
      timeRemaining: update.timeRemaining.isNegative
          ? null
          : update.timeRemaining,
    );
  }
}
