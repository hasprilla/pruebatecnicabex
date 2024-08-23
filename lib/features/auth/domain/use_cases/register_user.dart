import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/use_case/base_use_case.dart';
import '../../../../core/utils/generate_token.dart';
import '../../auth.dart';

class RegisterUser extends BaseUseCase<User, User> {
  final AuthRepository repository;

  RegisterUser(this.repository);

  @override
  Future<Either<Failure, User>> call(User param) async {
    final token = generateToken();
    return await repository.register(param, token);
  }
}
