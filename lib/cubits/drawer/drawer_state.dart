part of 'drawer_cubit.dart';

abstract class DrawerState extends Equatable {
  const DrawerState();
  @override
  List<Object> get props => [];
}

class DrawerInitial extends DrawerState {}

class GoHomePage extends DrawerState {}

class GoToUsers extends DrawerState {}
