part of 'log_in_bloc.dart';

abstract class LogInState extends Equatable {
  const LogInState();

  @override
  List<Object?> get props => [];
}

class LogInStateInitial extends LogInState {

  @override
  List<Object> get props => [];
}

class LogInStateLoading extends LogInState {}

class LogInStateLoaded extends LogInState {
  final LogInResponseModel responseModel;

  const LogInStateLoaded(this.responseModel);
}

class LogInStateError extends LogInState {
  final String? message;

  const LogInStateError(this.message);
}