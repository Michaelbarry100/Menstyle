import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'app_event.dart';
part 'app_state.dart';

class ApplicationBloc extends Bloc<AppEvent, ApplicationState> {
  final Dio dioInstance;
  ApplicationBloc({ required this.dioInstance}) : super(AppInitial()) {
    on<StartApp>((event, emit) {
      emit(AppStarted());
    });
  }
}
