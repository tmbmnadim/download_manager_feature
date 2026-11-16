import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String username;
  final DateTime createdAt;

  const UserEntity({
    required this.id,
    required this.username,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, username, createdAt];
}
