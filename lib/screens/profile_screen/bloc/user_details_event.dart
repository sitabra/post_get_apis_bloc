part of 'user_details_bloc.dart';

class UserDetailsEvent extends Equatable {
  final String id;

  const UserDetailsEvent(this.id);

  @override
  List<Object> get props => [id];
}
