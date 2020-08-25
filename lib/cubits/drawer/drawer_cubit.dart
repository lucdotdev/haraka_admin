import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(DrawerInitial());

  void goTohome() => emit(GoHomePage());
  void goToUsers() => emit(GoToUsers());
}
