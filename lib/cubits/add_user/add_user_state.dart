part of 'add_user_cubit.dart';

abstract class AddUserState extends Equatable {
  const AddUserState();

  @override
  List<Object> get props => [];
}

class AddUserInitial extends AddUserState {}

class AddUserLoading extends AddUserState {}

class AddUserFailed extends AddUserState {}

class AddUserSucceded extends AddUserState {}
