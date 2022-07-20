import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing_auth_api/screens/home_page_screen/ui/home_page_screen_ui.dart';
import 'package:testing_auth_api/screens/log_in_screen/bloc/log_in_bloc.dart';
import 'package:testing_auth_api/screens/log_in_screen/repository/log_in_repository.dart';
import 'package:testing_auth_api/screens/sign_up_screen/bloc/sign_up_bloc.dart';
import 'package:testing_auth_api/screens/sign_up_screen/repository/registration_repository.dart';
import 'package:testing_auth_api/screens/welcome_screen/welcome_screen_ui.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences? logInData;
  logInData = await SharedPreferences.getInstance();
  bool? myUser = false;
  myUser = (logInData.getBool("login") ?? false);
  runApp( MyApp(myUser: myUser,));
}

class MyApp extends StatelessWidget {
   const MyApp({Key? key, required this.myUser}) : super(key: key);
   final bool myUser;


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
        home: myUser==false? const WelcomeScreen() : const HomePageScreen()
    ),);
  }
}

