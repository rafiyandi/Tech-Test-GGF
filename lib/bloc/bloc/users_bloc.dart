import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tect_ggf/model/user_model.dart';
import 'package:tect_ggf/service/user_service.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitial()) {
    on<UserFetchDataUsers>(_fetchDataUser);
    on<UserAddAndUpdateDataUsers>(_addDataUser);
    on<UserDeleteDataUser>(_deleteDataUser);
  }

  FutureOr<void> _fetchDataUser(event, emit) async {
    emit(UsersLoading());
    final result = await UserService().fetchDataUser();

    result.fold(
        (l) => emit(UsersFailed(l)), (r) => emit(UsersSuccess(users: r)));
  }

  FutureOr<void> _addDataUser(event, emit) async {
    event as UserAddAndUpdateDataUsers;
    var tempList = List<UserModel>.from((state as UsersSuccess).users);
    int index =
        tempList.indexWhere((element) => element.id == event.request.id);
    if (index == -1) {
      final result = await UserService().addDataUser(request: event.request);
      result.fold((l) => emit(UsersFailed(l)), (r) {
        tempList.add(r);
        return emit(UsersSuccess(users: tempList));
      });
    } else {
      final result = await UserService().updateDataUser(request: event.request);

      result.fold((l) => emit(UsersFailed(l)), (r) {
        tempList[index] = r;
        emit(UsersSuccess(users: tempList));
      });
    }
  }

  FutureOr<void> _deleteDataUser(event, emit) async {
    event as UserDeleteDataUser;

    final result = await UserService().deleteDataUser(request: event.request);

    result.fold((l) => emit(UsersFailed(l)), (r) {
      var tempList = List<UserModel>.from((state as UsersSuccess).users);
      int index =
          tempList.indexWhere((element) => element.id == event.request.id);
      tempList.removeAt(index);
      emit(UsersSuccess(users: tempList));
    });
  }
}
