part of 'students_bloc.dart';

abstract class StudentsState extends Equatable {
  @override
  List<Object> get props => [];
}

class StudentsInitial extends StudentsState {}

class StudentsLoading extends StudentsState {}

class StudentsLoaded extends StudentsState {
  final List<Student> students;

  StudentsLoaded(this.students);

  @override
  List<Object> get props => [students];
}

class StudentsError extends StudentsState {
  final Failure failure;

  StudentsError(this.failure);

  @override
  List<Object> get props => [failure];
}

class StudentOperationSuccess extends StudentsState {
  final String message;

  StudentOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}