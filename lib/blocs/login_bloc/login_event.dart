part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonClicked extends LoginEvent {
  final email;
  final password;

  LoginButtonClicked({@required this.email, @required this.password});
  @override
  List<Object> get props => [email, password];
}
