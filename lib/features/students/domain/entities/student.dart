import 'package:equatable/equatable.dart';

class Student extends Equatable {
  final int id;
  final String name;
  final double firstGrade;
  final double secondGrade;
  final double thirdGrade;

  const Student({
    required this.id,
    required this.name,
    required this.firstGrade,
    required this.secondGrade,
    required this.thirdGrade,
  });

  @override
  List<Object?> get props => [id, name, firstGrade, secondGrade, thirdGrade];
}
