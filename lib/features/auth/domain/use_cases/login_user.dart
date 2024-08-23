import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../auth.dart';

class LoginUser implements BaseUseCase<User?, UserParams> {
  final AuthRepository repository;

  LoginUser(this.repository);

  @override
  Future<Either<Failure, User?>> call(UserParams param) async {
    return await repository.login(param.email, param.password);
  }
}

class UserParams {
  final String email;
  final String password;

  const UserParams({required this.email, required this.password});
}
