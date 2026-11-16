import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:laantech_download_manager/features/dashboard/domain/entities/transfer_entity.dart';
import 'package:laantech_download_manager/features/dashboard/domain/usecases/cancel_transfer_usecase.dart';
import 'package:laantech_download_manager/features/dashboard/domain/usecases/pause_transfer_usecase.dart';
import 'package:laantech_download_manager/features/dashboard/domain/usecases/resume_transfer_usecase.dart';
import 'package:laantech_download_manager/features/dashboard/domain/usecases/retry_transfer_usecase.dart';
import 'package:laantech_download_manager/features/dashboard/domain/usecases/start_download_usecase.dart';
import 'package:laantech_download_manager/features/dashboard/domain/usecases/watch_transfers_usecase.dart';
import 'package:laantech_download_manager/features/dashboard/presentation/bloc/transfers_event.dart';
import 'package:laantech_download_manager/features/dashboard/presentation/bloc/transfers_state.dart';

@injectable
class TransfersBloc extends Bloc<TransfersEvent, TransfersState> {
  final WatchTransfersUseCase _watchTransfersUseCase;
  final StartDownloadUseCase _startDownloadUseCase;
  final ResumeTransferUseCase _resumeDownloadUseCase;
  final PauseTransferUseCase _pauseDownloadUseCase;
  final CancelTransferUseCase _cancelDownloadUseCase;
  final RetryTransferUseCase _retryDownloadUseCase;
  TransfersBloc({
    required this._watchTransfersUseCase,
    required this._startDownloadUseCase,
    required this._resumeDownloadUseCase,
    required this._pauseDownloadUseCase,
    required this._cancelDownloadUseCase,
    required this._retryDownloadUseCase,
  }) : super(TransfersInitial()) {
    on<WatchTransfersEvent>(_onUpdate);
    on<StartTransferEvent>(_startTransfer);
    on<ResumeTransferEvent>(_handleResumeTransfer);
    on<PauseTransferEvent>(_handlePauseTransfer);
    on<CancelTransferEvent>(_handleCancelTransfer);
    on<RetryTransferEvent>(_handleRetryTransfer);
  }

  void _onUpdate(
    WatchTransfersEvent event,
    Emitter<TransfersState> emit,
  ) async {
    await emit.forEach<List<TransferEntity>>(
      _watchTransfersUseCase(),
      onData: (transfers) => TransfersLoaded(transfers),
    );
  }

  void _startTransfer(
    StartTransferEvent event,
    Emitter<TransfersState> emit,
  ) async {
    final result = await _startDownloadUseCase(event.file);
    result.fold(
      (failure) => emit(TransfersError(failure.message)),
      (_) => null,
    );
  }

  void _handleResumeTransfer(
    ResumeTransferEvent event,
    Emitter<TransfersState> emit,
  ) async {
    final result = await _resumeDownloadUseCase(event.id);
    result.fold(
      (failure) => emit(TransfersError(failure.message)),
      (_) => null,
    );
  }

  void _handlePauseTransfer(
    PauseTransferEvent event,
    Emitter<TransfersState> emit,
  ) async {
    final result = await _pauseDownloadUseCase(event.id);
    result.fold(
      (failure) => emit(TransfersError(failure.message)),
      (_) => null,
    );
  }

  void _handleCancelTransfer(
    CancelTransferEvent event,
    Emitter<TransfersState> emit,
  ) async {
    final result = await _cancelDownloadUseCase(event.id);
    result.fold(
      (failure) => emit(TransfersError(failure.message)),
      (_) => null,
    );
  }

  void _handleRetryTransfer(
    RetryTransferEvent event,
    Emitter<TransfersState> emit,
  ) async {
    final result = await _retryDownloadUseCase(event.id);
    result.fold(
      (failure) => emit(TransfersError(failure.message)),
      (_) => null,
    );
  }
}
