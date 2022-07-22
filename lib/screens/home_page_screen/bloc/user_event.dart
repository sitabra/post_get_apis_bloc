part of 'user_bloc.dart';

class UserEvent extends Equatable {
  final String page;

  const UserEvent(this.page);

  @override
  List<Object> get props => [page];
}