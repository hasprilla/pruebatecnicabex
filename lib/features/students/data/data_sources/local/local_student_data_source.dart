import 'package:dartz/dartz.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../../../../core/core.dart';
import '../../../students.dart';

abstract class LocalStudentDataSource {
  Future<Either<Failure, List<Student>>> list();
  Future<Either<Failure, String>> create(Student student);
  Future<Either<Failure, String>> update(Student student);
  Future<Either<Failure, String>> delete(int id);
}

class LocalStudentDataSourceImpl implements LocalStudentDataSource {
  final Database database;

  LocalStudentDataSourceImpl(this.database);

  @override
  Future<Either<Failure, String>> create(Student student) async {
    try {
      database.execute(
        'INSERT INTO students (id, name, firstGrade, secondGrade, thirdGrade) VALUES (?, ?, ?, ?, ?)',
        [
          student.id,
          student.name,
          student.firstGrade,
          student.secondGrade,
          student.thirdGrade,
        ],
      );
      return const Right('Estudiante creado con éxito');
    } catch (e) {
      return Left(DatabaseException('Error al crear el estudiante: $e'));
    }
  }

  @override
  Future<Either<Failure, String>> delete(int id) async {
    try {
      final result = database.execute(
        'DELETE FROM students WHERE id = ?',
        [id],
      );

      return const Right('Estudiante eliminado con éxito');
    } catch (e) {
      return Left(DatabaseException('Error al eliminar el estudiante: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Student>>> list() async {
    try {
      final results = database.select('SELECT * FROM students');
      final students = results.map((row) {
        return Student(
          id: row['id'] as int,
          name: row['name'] as String,
          firstGrade: row['firstGrade'] as double,
          secondGrade: row['secondGrade'] as double,
          thirdGrade: row['thirdGrade'] as double,
        );
      }).toList();
      return Right(students);
    } catch (e) {
      return Left(
          DatabaseException('Error al obtener la lista de estudiantes: $e'));
    }
  }

  @override
  Future<Either<Failure, String>> update(Student student) async {
    try {
      final result = database.execute(
        'UPDATE students SET name = ?, firstGrade = ?, secondGrade = ?, thirdGrade = ? WHERE id = ?',
        [
          student.name,
          student.firstGrade,
          student.secondGrade,
          student.thirdGrade,
          student.id,
        ],
      );

      return const Right('Estudiante actualizado con éxito');
    } catch (e) {
      return Left(DatabaseException('Error al actualizar el estudiante: $e'));
    }
  }
}
