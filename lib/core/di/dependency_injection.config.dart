// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

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

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
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
    gh.factory<_i634.AuthRepository>(
      () => _i63.AuthRepositoryImpl(
        remote: gh<_i720.AuthenticationRemoteSource>(),
        local: gh<_i205.AuthenticationLocalSource>(),
      ),
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
