import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../../core/core.dart';
import '../../features/auth/auth.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/students/students.dart';

final GetIt sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerSingletonAsync<AppDatabase>(() async {
    final appDatabase = await AppDatabase.getDatabase();
    return appDatabase;
  });

  sl.registerLazySingleton(() => const FlutterSecureStorage());

  sl.registerLazySingleton<LocalAuthenticationDataSource>(
      () => LocalAuthenticationDataSourceImpl(
            sl<AppDatabase>().database,
          ));

  sl.registerLazySingleton<LocalStudentDataSource>(
    () => LocalStudentDataSourceImpl(sl<AppDatabase>().database),
  );

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton<StudentRepository>(
    () => StudentRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => LoginUser(sl()));

  sl.registerLazySingleton(() => ListStudentsUseCase(sl()));

  sl.registerLazySingleton(() => CreateStudentUseCase(sl()));
  sl.registerLazySingleton(() => UpdateStudentUseCase(sl()));
  sl.registerLazySingleton(() => DeleteStudentUseCase(sl()));

  sl.registerFactory(() => AuthBloc(
        registerUser: sl(),
        loginUser: sl(),
        secureStorage: sl(),
      ));

  sl.registerFactory(() => StudentsBloc(
        listStudentsUseCase: sl(),
        createStudentUseCase: sl(),
        updateStudentUseCase: sl(),
        deleteStudentUseCase: sl(),
      ));
}
