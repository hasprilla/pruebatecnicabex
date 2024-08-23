import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUser registerUser;
  final LoginUser loginUser;
  final FlutterSecureStorage secureStorage;

  AuthBloc({
    required this.registerUser,
    required this.loginUser,
    required this.secureStorage,
  }) : super(RegistrationInitial()) {
    on<RegisterUserEvent>(_register);
    on<LoginUserEvent>(_login);
    on<CheckSession>(_onCheckSession);
    on<LogoutEvent>(_onLogoutRequested);
  }

  Future<void> _register(
    RegisterUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(Loading());
    final response = await registerUser(event.user);
    response.fold(
      (failure) =>
          emit(AuthError('Error al registrar usuario}')),
      (success) => emit(AuthSuccessWithToken(success.token)),
    );
  }

  Future<void> _login(
    LoginUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(Loading());
    final response = await loginUser(
      UserParams(
        email: event.userParams.email,
        password: event.userParams.password,
      ),
    );

    response.fold(
      (failure) =>
          emit(AuthError('Error al iniciar sesión')),
      (success) async {
        await secureStorage.write(key: 'user_token', value: success!.token);
        try {
          emit(AuthSuccessWithToken(success.token));
        } catch (e) {
          emit(AuthError(
              'Error al almacenar el token. Por favor, intenta nuevamente.'));
        }
      },
    );
  }

  Future<void> _onCheckSession(
    CheckSession event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final token = await secureStorage.read(key: 'user_token');
      if (token != null) {
        emit(AuthSuccessWithToken(token));
      } else {
        emit(AuthNotAuthenticated());
      }
    } catch (e) {
      emit(AuthError(
          'Error al verificar la sesión. Por favor, intenta nuevamente.'));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await secureStorage.delete(key: 'user_token');
      emit(AuthNotAuthenticated());
    } catch (e) {
      emit(AuthError('Error al cerrar sesión. Por favor, intenta nuevamente.'));
    }
  }
}
