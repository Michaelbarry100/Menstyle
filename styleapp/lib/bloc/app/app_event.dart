part of 'app_bloc.dart';

@immutable
abstract class AppEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartApp extends AppEvent {}
