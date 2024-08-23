import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class EmptyFailure extends Failure {
  @override
  List<Object> get props => [];
}

class ConnectionFailure extends Failure {
  @override
  List<Object> get props => [];
}

class DatabaseException extends Failure {
  final String message;
  DatabaseException(this.message);

  @override
  List<Object?> get props => [message];
}
