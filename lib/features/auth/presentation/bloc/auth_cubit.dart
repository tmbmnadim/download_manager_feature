import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:laantech_download_manager/features/auth/domain/usecases/login_usecase.dart';
import 'package:laantech_download_manager/features/auth/domain/usecases/logout_usecase.dart';
import 'package:laantech_download_manager/features/auth/domain/usecases/restore_session_usecase.dart';
import 'package:laantech_download_manager/features/auth/presentation/bloc/auth_states.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase _login;
  final RestoreSessionUseCase _restoreSession;
  final LogoutUseCase _logout;
  AuthCubit(this._login, this._restoreSession, this._logout)
    : super(const AuthInitial());

  Future<void> login(String username, String password) async {
    try {
      emit(AuthLoading());
      final result = await _login.call(username, password);

      result.fold(
        (failure) {
          emit(AuthError(failure.message));
        },
        (user) {
          emit(Authenticated(user));
        },
      );
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> restoreSession() async {
    emit(const AuthLoading());
    final result = await _restoreSession();
    result.fold(
      (failure) =>
          emit(const Unauthenticated()), // unreadable session = logged out
      (user) =>
          emit(user == null ? const Unauthenticated() : Authenticated(user)),
    );
  }

  Future<void> logout() async {
    final result = await _logout();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const Unauthenticated()),
    );
  }
}
