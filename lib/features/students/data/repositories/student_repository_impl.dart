import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../students.dart';

class StudentRepositoryImpl implements StudentRepository {
  final LocalStudentDataSource localDataSource;

  StudentRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, String>> create(Student student) async {
    try {
      return await localDataSource.create(student);
    } catch (e) {
      return Left(DatabaseException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> delete(int id) async {
    try {
      return await localDataSource.delete(id);
    } catch (e) {
      return Left(DatabaseException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Student>>> list() async {
    try {
      return await localDataSource.list();
    } catch (e) {
      return Left(DatabaseException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> update(Student student) async {
    try {
      return await localDataSource.update(student);
    } catch (e) {
      return Left(DatabaseException(e.toString()));
    }
  }
}
