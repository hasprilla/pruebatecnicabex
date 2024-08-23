import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String fullName;
  final String email;
  final String password;
  final String phone;
  final String token;

  const User({
    required this.fullName,
    required this.email,
    required this.password,
    required this.phone,
    required this.token,
  });

  @override
  List<Object?> get props => [fullName, email, password, phone, token];
}
