import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:haraka_admin/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;
  LoginBloc({@required this.repository}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonClicked) {
      yield LoginLoading();
      try {
        dynamic response =
            await repository.loginWithEmail(event.email, event.password);
        if (response == 1) {
          yield LoginFailed(error: "utilisateur Introuvable");
        } else if (response == 2) {
          yield LoginFailed(error: "mot de passe incorect");
        } else if (response == 3) {
          yield LoginFailed(error: "erreurs inconues");
        } else {
          yield LoginSuccefful(uid: response);
        }
      } catch (_) {
        print(_);
        yield LoginFailed(error: "erreurs inconues");
      }
    }
  }
}
