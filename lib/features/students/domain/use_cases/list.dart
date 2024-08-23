import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../students.dart';

class ListStudentsUseCase implements BaseUseCase<List<Student>, NoParams> {
  final StudentRepository repository;

  ListStudentsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Student>>> call(param) async {
    return await repository.list();
  }
}

class NoParams {}
