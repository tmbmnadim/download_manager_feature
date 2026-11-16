// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:background_downloader/background_downloader.dart' as _i677;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:laantech_download_manager/core/di/register_module.dart'
    as _i121;
import 'package:laantech_download_manager/core/network/dio_client.dart'
    as _i1003;
import 'package:laantech_download_manager/features/auth/data/datasources/authentication_local_source.dart'
    as _i205;
import 'package:laantech_download_manager/features/auth/data/datasources/authentication_remote_source.dart'
    as _i720;
import 'package:laantech_download_manager/features/auth/data/repositories/auth_repository_impl.dart'
    as _i63;
import 'package:laantech_download_manager/features/auth/domain/repositories/auth_repository.dart'
    as _i634;
import 'package:laantech_download_manager/features/auth/domain/usecases/login_usecase.dart'
    as _i385;
import 'package:laantech_download_manager/features/auth/domain/usecases/logout_usecase.dart'
    as _i276;
import 'package:laantech_download_manager/features/auth/domain/usecases/restore_session_usecase.dart'
    as _i761;
import 'package:laantech_download_manager/features/auth/presentation/bloc/auth_cubit.dart'
    as _i9;
import 'package:laantech_download_manager/features/dashboard/data/datasources/transfers_network_source.dart'
    as _i737;
import 'package:laantech_download_manager/features/dashboard/data/repositories/transfer_repository_impl.dart'
    as _i222;
import 'package:laantech_download_manager/features/dashboard/domain/repositories/transfer_repository.dart'
    as _i37;
import 'package:laantech_download_manager/features/dashboard/domain/usecases/cancel_transfer_usecase.dart'
    as _i231;
import 'package:laantech_download_manager/features/dashboard/domain/usecases/pause_transfer_usecase.dart'
    as _i749;
import 'package:laantech_download_manager/features/dashboard/domain/usecases/resume_transfer_usecase.dart'
    as _i175;
import 'package:laantech_download_manager/features/dashboard/domain/usecases/retry_transfer_usecase.dart'
    as _i643;
import 'package:laantech_download_manager/features/dashboard/domain/usecases/start_download_usecase.dart'
    as _i468;
import 'package:laantech_download_manager/features/dashboard/domain/usecases/watch_transfers_usecase.dart'
    as _i301;
import 'package:laantech_download_manager/features/files/data/datasources/file_remote_source.dart'
    as _i450;
import 'package:laantech_download_manager/features/files/data/repositories/file_repository_impl.dart'
    as _i46;
import 'package:laantech_download_manager/features/files/domain/repositories/file_repository.dart'
    as _i23;
import 'package:laantech_download_manager/features/files/domain/usecases/get_files_usecase.dart'
    as _i642;
import 'package:laantech_download_manager/features/files/presentation/bloc/files_cubit.dart'
    as _i1055;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.singleton<_i677.FileDownloader>(() => registerModule.fileDownloader);
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => registerModule.secureStorage,
    );
    gh.lazySingleton<_i1003.ApiService>(
      () => _i1003.ApiService(dio: gh<_i361.Dio>()),
    );
    gh.factory<_i205.AuthenticationLocalSource>(
      () => _i205.AuthenticationLocalSource(
        storage: gh<_i558.FlutterSecureStorage>(),
      ),
    );
    gh.lazySingleton<_i720.AuthenticationRemoteSource>(
      () =>
          _i720.AuthenticationRemoteSource(apiService: gh<_i1003.ApiService>()),
    );
    gh.factory<_i450.FileRemoteSource>(
      () => _i450.FileRemoteSource(apiService: gh<_i1003.ApiService>()),
    );
    gh.factory<_i737.TransfersNetworkSource>(
      () => _i737.TransfersNetworkSource(
        gh<_i677.FileDownloader>(),
        gh<_i1003.ApiService>(),
      ),
    );
    gh.factory<_i23.FileRepository>(
      () => _i46.FileRepositoryImpl(gh<_i450.FileRemoteSource>()),
    );
    gh.factory<_i634.AuthRepository>(
      () => _i63.AuthRepositoryImpl(
        remote: gh<_i720.AuthenticationRemoteSource>(),
        local: gh<_i205.AuthenticationLocalSource>(),
      ),
    );
    gh.factory<_i642.GetFilesUseCase>(
      () => _i642.GetFilesUseCase(gh<_i23.FileRepository>()),
    );
    gh.lazySingleton<_i37.TransferRepository>(
      () => _i222.TransferRepositoryImpl(gh<_i737.TransfersNetworkSource>()),
    );
    gh.factory<_i1055.FilesCubit>(
      () => _i1055.FilesCubit(gh<_i642.GetFilesUseCase>()),
    );
    gh.factory<_i385.LoginUseCase>(
      () => _i385.LoginUseCase(gh<_i634.AuthRepository>()),
    );
    gh.factory<_i276.LogoutUseCase>(
      () => _i276.LogoutUseCase(gh<_i634.AuthRepository>()),
    );
    gh.factory<_i761.RestoreSessionUseCase>(
      () => _i761.RestoreSessionUseCase(gh<_i634.AuthRepository>()),
    );
    gh.factory<_i231.CancelTransferUseCase>(
      () => _i231.CancelTransferUseCase(gh<_i37.TransferRepository>()),
    );
    gh.factory<_i749.PauseTransferUseCase>(
      () => _i749.PauseTransferUseCase(gh<_i37.TransferRepository>()),
    );
    gh.factory<_i175.ResumeTransferUseCase>(
      () => _i175.ResumeTransferUseCase(gh<_i37.TransferRepository>()),
    );
    gh.factory<_i643.RetryTransferUseCase>(
      () => _i643.RetryTransferUseCase(gh<_i37.TransferRepository>()),
    );
    gh.factory<_i468.StartDownloadUseCase>(
      () => _i468.StartDownloadUseCase(gh<_i37.TransferRepository>()),
    );
    gh.factory<_i301.WatchTransfersUseCase>(
      () => _i301.WatchTransfersUseCase(gh<_i37.TransferRepository>()),
    );
    gh.factory<_i9.AuthCubit>(
      () => _i9.AuthCubit(
        gh<_i385.LoginUseCase>(),
        gh<_i761.RestoreSessionUseCase>(),
        gh<_i276.LogoutUseCase>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i121.RegisterModule {}
