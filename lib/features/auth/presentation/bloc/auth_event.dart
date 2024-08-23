part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterUserEvent extends AuthEvent {
  final User user;

  RegisterUserEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class LoginUserEvent extends AuthEvent {
  final UserParams userParams;

  LoginUserEvent(this.userParams);

  @override
  List<Object?> get props => [  userParams];
}

class LogoutUserEvent extends AuthEvent {}  

class CheckSession extends AuthEvent {}

class LogoutEvent extends AuthEvent {}