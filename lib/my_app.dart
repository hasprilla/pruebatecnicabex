import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/di/injector.dart';
import 'app/theme/theme.dart';
import 'features/auth/auth.dart';
import 'features/home/home.dart';
import 'features/students/presentation/pages/students_page.dart';
import 'features/students/students.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthBloc(
              registerUser: sl(),
              loginUser: sl(),
              secureStorage: sl(),
            )..add(CheckSession()),
          ),
          BlocProvider(
            create: (_) => StudentsBloc(
              listStudentsUseCase: sl(),
              createStudentUseCase: sl(),
              updateStudentUseCase: sl(),
              deleteStudentUseCase: sl(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'NotasBex',
          theme: theme,
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccess || state is AuthSuccessWithToken) {
                return HomePage();
              }

              return LoginScreen();
            },
          ),
          routes: {
            '/home': (context) => HomePage(),
            '/register': (context) => const RegisterPage(),
            '/students': (context) => const StudentsPage(),
          },
        ));
  }
}
