import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:bloc_flutter/models/user.dart';
part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState>{
  UserListBloc() : super(UserListInitial(users: [])){
    on<AddUser>(_adduser);
    on<DeleteUser>(_deleteUser);
    on<UpdateUser>(_updateUser);
  }
  void _adduser (AddUser event, Emitter<UserListState> emit){
    state.users.add(event.user);
    emit(UserListUpdated(users: state.users));
  }
  void _deleteUser (DeleteUser event, Emitter<UserListState> emit){
    state.users.remove(event.user);
    emit(UserListUpdated(users: state.users));
  }
  void _updateUser (UpdateUser event, Emitter<UserListState> emit){
    for(int i=0; i<state.users.length; i++){
      if(event.user.id == state.users[i].id){
        state.users[i] = event.user;
      }     
    }
    emit(UserListUpdated(users: state.users));
  }
}