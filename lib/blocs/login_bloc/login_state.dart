part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccefful extends LoginState {
  final uid;
  LoginSuccefful({@required this.uid});
  @override
  List<Object> get props => [uid];
}

class LoginFailed extends LoginState {
  final error;
  LoginFailed({@required this.error});
  @override
  List<Object> get props => [error];
}

class LoginLoading extends LoginState {}
