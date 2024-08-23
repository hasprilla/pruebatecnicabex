import '../../students.dart';

class StudentModel extends Student {
  const StudentModel({
    required super.id,
    required super.name,
    required super.firstGrade,
    required super.secondGrade,
    required super.thirdGrade,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'],
      name: json['name'],
      firstGrade: json['firstGrade'].toDouble(),
      secondGrade: json['secondGrade'].toDouble(),
      thirdGrade: json['thirdGrade'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'firstGrade': firstGrade,
      'secondGrade': secondGrade,
      'thirdGrade': thirdGrade,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map['id'] as int,
      name: map['name'] as String,
      firstGrade: (map['firstGrade'] as num).toDouble(),
      secondGrade: (map['secondGrade'] as num).toDouble(),
      thirdGrade: (map['thirdGrade'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'firstGrade': firstGrade,
      'secondGrade': secondGrade,
      'thirdGrade': thirdGrade,
    };
  }
}
