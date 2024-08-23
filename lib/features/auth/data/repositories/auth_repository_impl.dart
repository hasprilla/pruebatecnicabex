import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final LocalAuthenticationDataSource localDataSource;

  AuthRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, User>> register(User user, String token) async {
    try {
      return await localDataSource.register(user, token);
    } catch (e) {
      return Left(DatabaseException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> login(String email, String password) async {
    try {
      return await localDataSource.login(email, password);
    } catch (e) {
      return Left(DatabaseException(e.toString()));
    }
  }
}
