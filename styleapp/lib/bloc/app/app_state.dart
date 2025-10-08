part of 'app_bloc.dart';

@immutable
abstract class ApplicationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppInitial extends ApplicationState {}

class Loading extends ApplicationState {}

class AppStarted extends ApplicationState {}

class Errored extends ApplicationState {}
