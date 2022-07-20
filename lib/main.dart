import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_auth_api/screens/log_in_screen/bloc/log_in_bloc.dart';
import 'package:testing_auth_api/screens/log_in_screen/repository/log_in_repository.dart';
import 'package:testing_auth_api/screens/sign_up_screen/bloc/sign_up_bloc.dart';
import 'package:testing_auth_api/screens/sign_up_screen/repository/registration_repository.dart';
import 'package:testing_auth_api/screens/sign_up_screen/ui/sign_up_screen_ui.dart';
import 'package:testing_auth_api/screens/welcome_screen/welcome_screen_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<LogInBloc>(create: (context) => LogInBloc(LogInRepository())),
      BlocProvider<SignUpBloc>(create: (context) => SignUpBloc(RegistrationRepository())),
    ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: const WelcomeScreen()
    ),);
  }
}

