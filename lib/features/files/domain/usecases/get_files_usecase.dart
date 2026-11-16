import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:laantech_download_manager/core/error/failure.dart';
import 'package:laantech_download_manager/features/files/domain/entities/file_entity.dart';
import 'package:laantech_download_manager/features/files/domain/repositories/file_repository.dart';

@injectable
class GetFilesUseCase {
  final FileRepository _repository;
  GetFilesUseCase(this._repository);

  Future<Either<Failure, List<FileEntity>>> call() => _repository.getFiles();
}
