import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../students.dart';

class DeleteStudentUseCase implements BaseUseCase<String, Params> {
  final StudentRepository repository;

  DeleteStudentUseCase(this.repository);
  @override
  Future<Either<Failure, String>> call(Params param) async {
    return await repository.delete(param.id);
  }
}

class Params {
  final int id;
  Params({required this.id});
}
