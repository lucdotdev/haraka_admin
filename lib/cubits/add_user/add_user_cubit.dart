import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:haraka_admin/repositories/add_user_repo.dart';
import 'package:meta/meta.dart';

part 'add_user_state.dart';

class AddUserCubit extends Cubit<AddUserState> {
  final AddUsersRepository addUsersRepository;
  AddUserCubit({@required this.addUsersRepository}) : super(AddUserInitial());

  void addUser(user) async {
    emit(AddUserLoading());
    int result = await addUsersRepository.addMember(user);
    if (result == 1) {
      emit(AddUserSucceded());
    } else {
      emit(AddUserFailed());
    }
  }
}
