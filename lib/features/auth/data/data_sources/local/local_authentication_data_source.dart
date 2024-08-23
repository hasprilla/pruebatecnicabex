import 'package:dartz/dartz.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../../../../core/core.dart';
import '../../../auth.dart';

abstract class LocalAuthenticationDataSource {
  Future<Either<Failure, User>> register(User user, String token);
  Future<Either<Failure, User?>> login(String email, String password);
}

class LocalAuthenticationDataSourceImpl
    implements LocalAuthenticationDataSource {
  final Database database;

  LocalAuthenticationDataSourceImpl(this.database);

  @override
  Future<Either<Failure, User>> register(User user, String token) async {
    try {
      final userModel = UserModel(
        fullName: user.fullName,
        email: user.email,
        password: user.password,
        phone: user.phone,
        token: token,
      );

      database.execute(
        '''
        INSERT INTO users (full_name, email, password, phone, token) 
        VALUES (?, ?, ?, ?, ?)
        ''',
        [
          userModel.fullName,
          userModel.email,
          userModel.password,
          userModel.phone,
          userModel.token,
        ],
      );

      final insertedUser = database.select(
        'SELECT * FROM users WHERE email = ?',
        [userModel.email],
      ).single;

      final userFromDb = UserModel.fromMap(insertedUser).copyWith(token: token);

      return Right(userFromDb);
    } catch (e) {
      return Left(DatabaseException(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> login(String email, String password) async {
    try {
      final results = database.select(
        'SELECT * FROM users WHERE email = ? AND password = ?',
        [email, password],
      );

      if (results.isEmpty) {
        return Left(DatabaseException(
            'No user found with provided email and password.'));
      }

      final userFromDb = UserModel.fromMap(results.first);

      return Right(userFromDb);
    } catch (e) {
      return Left(DatabaseException(e.toString()));
    }
  }
}
