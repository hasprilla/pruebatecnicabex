part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegistrationInitial extends AuthState {}

class Loading extends AuthState {}

class RegistrationSuccess extends AuthState {
  final User user;

  RegistrationSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthSuccess extends AuthState {
  final User user;

  AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthSuccessWithToken extends AuthState {
  final String token;

  AuthSuccessWithToken(this.token);

  @override
  List<Object> get props => [token];
}
class AuthNotAuthenticated extends AuthState {}