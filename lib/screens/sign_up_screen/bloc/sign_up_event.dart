part of 'sign_up_bloc.dart';

class SignUpEvent extends Equatable {
  final String email;
  final String name;
  final String password;


  const SignUpEvent(this.email, this.password, this.name);

  @override
  List<Object> get props => [email,name,password];
}
