import '../../auth.dart';

class UserModel extends User {
  const UserModel({
    required super.fullName,
    required super.email,
    required super.password,
    required super.phone,
    required super.token,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map['full_name'],
      email: map['email'],
      password: map['password'],
      phone: map['phone'],
      token: map['token'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'full_name': fullName,
      'email': email,
      'password': password,
      'phone': phone,
      'token': token,
    };
  }

  UserModel copyWith({
    String? fullName,
    String? email,
    String? password,
    String? phone,
    String? token,
  }) {
    return UserModel(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      token: token ?? this.token,
    );
  }
}
