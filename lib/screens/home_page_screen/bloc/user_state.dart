part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserStateInitial extends UserState {

  @override
  List<Object> get props => [];
}

class UserStateLoading extends UserState {}

class UserStateLoaded extends UserState {
  final UserResponseModel responseModel;

  const UserStateLoaded(this.responseModel);
}

class UserStateError extends UserState {
  final String? message;

  const UserStateError(this.message);
}