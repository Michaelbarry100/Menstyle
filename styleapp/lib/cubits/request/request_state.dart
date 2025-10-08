part of 'request_cubit.dart';

abstract class RequestState extends Equatable {
  const RequestState();

  @override
  List<Object> get props => [];
}

class RequestInitiated extends RequestState {}

class RequestLoading extends RequestState {}

class SavingStyle extends RequestState {}

class SavedStyle extends RequestState {}

class RequestFailed extends RequestState {
  final String message;
  const RequestFailed({required this.message});
  @override
  List<Object> get props => [message];
}

class RequestApproved extends RequestState {
  final dynamic data;
  const RequestApproved({required this.data});
  @override
  List<Object> get props => [data];
}
