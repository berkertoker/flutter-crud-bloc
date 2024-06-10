part of 'user_list_bloc.dart';

abstract class UserListState{
  List<User> users;
  UserListState({required this.users});
}
class UserListInitial extends UserListState{
  UserListInitial({required List<User> users}):super(users: users);
}
class UserListUpdated extends UserListState{
  UserListUpdated({required List<User> users}):super(users: users);
}