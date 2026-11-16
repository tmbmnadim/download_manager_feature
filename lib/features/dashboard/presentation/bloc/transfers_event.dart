import 'package:equatable/equatable.dart';
import 'package:laantech_download_manager/features/files/domain/entities/file_entity.dart';

sealed class TransfersEvent extends Equatable {
  const TransfersEvent();

  @override
  List<Object> get props => [];
}

class WatchTransfersEvent extends TransfersEvent {
  const WatchTransfersEvent();
}

class StartTransferEvent extends TransfersEvent {
  final FileEntity file;
  const StartTransferEvent(this.file);

  @override
  List<Object> get props => [file];
}

class ResumeTransferEvent extends TransfersEvent {
  final String id;
  const ResumeTransferEvent(this.id);

  @override
  List<Object> get props => [id];
}

class PauseTransferEvent extends TransfersEvent {
  final String id;
  const PauseTransferEvent(this.id);

  @override
  List<Object> get props => [id];
}

class CancelTransferEvent extends TransfersEvent {
  final String id;
  const CancelTransferEvent(this.id);

  @override
  List<Object> get props => [id];
}

class RetryTransferEvent extends TransfersEvent {
  final String id;
  const RetryTransferEvent(this.id);

  @override
  List<Object> get props => [id];
}
