import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../students.dart';

class CreateStudentUseCase implements BaseUseCase<String, Student> {
  final StudentRepository repository;

  CreateStudentUseCase(this.repository);
  @override
  Future<Either<Failure, String>> call(Student param) async {
    return await repository.create(param);
  }
}
