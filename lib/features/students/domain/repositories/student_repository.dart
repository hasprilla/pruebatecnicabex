import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/entities.dart';

abstract class StudentRepository {
  Future<Either<Failure, List<Student>>> list();
  Future<Either<Failure, String>> create(Student student);
  Future<Either<Failure, String>> update(Student student);
  Future<Either<Failure, String>> delete(int id);
}
