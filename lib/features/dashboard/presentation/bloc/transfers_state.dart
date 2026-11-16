import 'package:equatable/equatable.dart';
import 'package:laantech_download_manager/features/dashboard/domain/entities/transfer_entity.dart';

sealed class TransfersState extends Equatable {
  const TransfersState();

  @override
  List<Object> get props => [];
}

class TransfersInitial extends TransfersState {
  const TransfersInitial();
}

class TransfersLoaded extends TransfersState {
  final List<TransferEntity> transfers;

  const TransfersLoaded(this.transfers);

  @override
  List<Object> get props => [transfers];
}

class TransfersError extends TransfersState {
  final String message;

  const TransfersError(this.message);

  @override
  List<Object> get props => [message];
}