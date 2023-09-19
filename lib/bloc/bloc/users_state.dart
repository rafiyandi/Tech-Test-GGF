part of 'users_bloc.dart';

sealed class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

final class UsersInitial extends UsersState {}

final class UsersLoading extends UsersState {}

final class UsersFailed extends UsersState {
  final String e;

  const UsersFailed(this.e);

  @override
  List<Object> get props => [e];
}

final class UsersSuccess extends UsersState {
  final List<UserModel> users;

  const UsersSuccess({required this.users});

  @override
  List<Object> get props => [users];
}
