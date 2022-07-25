part of 'user_details_bloc.dart';

abstract class UserDetailsState extends Equatable {
  const UserDetailsState();

  @override
  List<Object?> get props => [];
}

class UserDetailsStateInitial extends UserDetailsState {

  @override
  List<Object> get props => [];
}

class UserDetailsStateLoading extends UserDetailsState {}

class UserDetailsStateLoaded extends UserDetailsState {
  final UserDetailsResponseModel responseModel;

  const UserDetailsStateLoaded(this.responseModel);
}

class UserDetailsStateError extends UserDetailsState {
  final String? message;

  const UserDetailsStateError(this.message);
}
