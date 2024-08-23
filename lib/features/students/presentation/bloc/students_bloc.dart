import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../students.dart';

part 'students_event.dart';
part 'students_state.dart';

class StudentsBloc extends Bloc<StudentsEvent, StudentsState> {
  final CreateStudentUseCase createStudentUseCase;
  final DeleteStudentUseCase deleteStudentUseCase;
  final ListStudentsUseCase listStudentsUseCase;
  final UpdateStudentUseCase updateStudentUseCase;

  StudentsBloc({
    required this.createStudentUseCase,
    required this.deleteStudentUseCase,
    required this.listStudentsUseCase,
    required this.updateStudentUseCase,
  }) : super(StudentsInitial()) {
    on<LoadStudents>((event, emit) async {
      final result = await listStudentsUseCase(NoParams());
      emit(result.fold(
        (failure) => StudentsError(failure),
        (students) => StudentsLoaded(students),
      ));
    });

    on<AddStudent>((event, emit) async {
      final result = await createStudentUseCase(event.student);
      emit(result.fold(
        (failure) => StudentsError(failure),
        (message) => StudentOperationSuccess(message),
      ));
      add(LoadStudents()); // Reload students after addition
    });

    on<UpdateStudent>((event, emit) async {
      final result = await updateStudentUseCase(event.student);
      emit(result.fold(
        (failure) => StudentsError(failure),
        (message) => StudentOperationSuccess(message),
      ));
      add(LoadStudents()); // Reload students after update
    });

    on<DeleteStudent>((event, emit) async {
      final result = await deleteStudentUseCase(Params(id: event.id));
      emit(result.fold(
        (failure) => StudentsError(failure),
        (message) => StudentOperationSuccess(message),
      ));
      add(LoadStudents()); // Reload students after deletion
    });
  }
}
