import 'package:equatable/equatable.dart';
import 'package:laantech_download_manager/features/files/domain/entities/file_entity.dart';

sealed class FilesState extends Equatable {
  const FilesState();
  @override
  List<Object?> get props => [];
}

class FilesInitial extends FilesState {
  const FilesInitial();
}

class FilesLoading extends FilesState {
  const FilesLoading();
}

class FilesFetched extends FilesState {
  final List<FileEntity> files;
  const FilesFetched(this.files);
  @override
  List<Object?> get props => [files];
}

class FilesError extends FilesState {
  final String message;
  const FilesError(this.message);
  @override
  List<Object?> get props => [message];
}
