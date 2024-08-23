import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../students.dart';

class UpdateStudentUseCase implements BaseUseCase<String, Student> {
  final StudentRepository repository;
  UpdateStudentUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(Student param) async {
    return await repository.update(param);
  }
}
