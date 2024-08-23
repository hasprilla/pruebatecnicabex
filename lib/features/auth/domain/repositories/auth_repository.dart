import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> register(User user, String token);
  Future<Either<Failure, User?>> login(String email, String password);
}
