part of 'users_bloc.dart';

sealed class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class UserFetchDataUsers extends UsersEvent {}

class UserAddAndUpdateDataUsers extends UsersEvent {
  final UserModel request;

  const UserAddAndUpdateDataUsers({required this.request});

  @override
  List<Object> get props => [request];
}

class UserDeleteDataUser extends UsersEvent {
  final UserModel request;

  const UserDeleteDataUser({required this.request});

  @override
  List<Object> get props => [request];
}
