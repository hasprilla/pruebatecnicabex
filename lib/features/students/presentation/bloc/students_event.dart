part of 'students_bloc.dart';

abstract class StudentsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadStudents extends StudentsEvent {}

class AddStudent extends StudentsEvent {
  final Student student;

  AddStudent(this.student);

  @override
  List<Object> get props => [student];
}

class UpdateStudent extends StudentsEvent {
  final Student student;

  UpdateStudent(this.student);

  @override
  List<Object> get props => [student];
}

class DeleteStudent extends StudentsEvent {
  final int id;

  DeleteStudent(this.id);

  @override
  List<Object> get props => [id];
}