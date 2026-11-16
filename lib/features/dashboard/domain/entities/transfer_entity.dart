import 'package:equatable/equatable.dart';
import 'package:laantech_download_manager/features/files/domain/entities/file_entity.dart';

enum TransferType { download, upload }

enum TransferStatus { queued, running, paused, completed, failed, canceled }

class TransferEntity extends Equatable {
  /// Same as the task id of the underlying background task.
  final String id;
  final FileEntity file;
  final TransferType type;
  final TransferStatus status;

  /// 0.0 to 1.0.
  final double progress;

  /// In MB/s. Null when unknown.
  final double? speed;

  /// Null when unknown.
  final Duration? timeRemaining;

  /// Set when [status] is failed.
  final String? errorMessage;

  const TransferEntity({
    required this.id,
    required this.file,
    required this.type,
    this.status = TransferStatus.queued,
    this.progress = 0,
    this.speed,
    this.timeRemaining,
    this.errorMessage,
  });

  bool get isActive =>
      status == TransferStatus.queued || status == TransferStatus.running;

  bool get isFinished =>
      status == TransferStatus.completed ||
      status == TransferStatus.failed ||
      status == TransferStatus.canceled;

  int get completedBytes => (file.size * progress).round();
  int get remainingBytes => file.size - completedBytes;

  @override
  List<Object?> get props => [
    id,
    file,
    type,
    status,
    progress,
    speed,
    timeRemaining,
    errorMessage,
  ];
}
