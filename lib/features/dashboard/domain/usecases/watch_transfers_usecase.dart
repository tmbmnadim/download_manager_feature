import 'package:injectable/injectable.dart';
import 'package:laantech_download_manager/features/dashboard/domain/entities/transfer_entity.dart';
import 'package:laantech_download_manager/features/dashboard/domain/repositories/transfer_repository.dart';

@injectable
class WatchTransfersUseCase {
  final TransferRepository _repository;
  WatchTransfersUseCase(this._repository);

  Stream<List<TransferEntity>> call() => _repository.watchTransfers();
}
