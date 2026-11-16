import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:laantech_download_manager/features/files/domain/usecases/get_files_usecase.dart';
import 'package:laantech_download_manager/features/files/presentation/bloc/files_state.dart';

@injectable
class FilesCubit extends Cubit<FilesState> {
  final GetFilesUseCase _getFilesUseCase;
  FilesCubit(this._getFilesUseCase) : super(FilesInitial());

  Future<void> getFiles() async {
    if (state is FilesInitial ||
        (state is FilesFetched && (state as FilesFetched).files.isEmpty)) {
      emit(FilesLoading());
    }

    final result = await _getFilesUseCase.call();

    result.fold(
      (failure) {
        emit(FilesError(failure.message));
      },
      (files) {
        emit(FilesFetched(files));
      },
    );
  }
}
