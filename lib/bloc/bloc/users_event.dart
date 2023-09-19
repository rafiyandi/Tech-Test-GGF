part of 'users_bloc.dart';

sealed class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class UserFetchDataUsers extends UsersEvent {}

class UserAddDataUsers extends UsersEvent {
  final UserModel request;

  const UserAddDataUsers({required this.request});

  @override
  List<Object> get props => [request];
}

class UserUpdateDataUser extends UsersEvent {
  final UserModel request;

  const UserUpdateDataUser({required this.request});

  @override
  List<Object> get props => [request];
}

class UserDeleteDataUser extends UsersEvent {
  final UserModel request;

  const UserDeleteDataUser({required this.request});

  @override
  List<Object> get props => [request];
}
