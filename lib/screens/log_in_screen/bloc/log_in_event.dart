part of 'log_in_bloc.dart';


class LogInEvent extends Equatable {
  final String email;
  final String password;


  const LogInEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
