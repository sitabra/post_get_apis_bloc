import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing_auth_api/screens/log_in_screen/bloc/log_in_bloc.dart';
import 'package:testing_auth_api/screens/log_in_screen/repository/log_in_repository.dart';
import 'package:testing_auth_api/screens/sign_up_screen/ui/sign_up_screen_ui.dart';
import 'package:testing_auth_api/widgets/custom_text_form_field.dart';
import 'package:testing_auth_api/widgets/text_form_filed_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home_page_screen/ui/home_page_screen_ui.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> with Validator {
  final formKey = GlobalKey<FormState>();
  final LogInBloc _logInBloc = LogInBloc(LogInRepository());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late SharedPreferences logInData;
  late bool newUser;

  void setSharedPref(String username, String token)async{
    logInData = await SharedPreferences.getInstance();
    logInData.setBool('login', true);
    logInData.setString('username', username);
    logInData.setString('token', token);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    children: [
                      TextSpan(
                          text: 'Hello!',
                          style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline)),
                      TextSpan(text: '  Welcome '),
                      TextSpan(
                        text: 'back',
                      ),
                      TextSpan(
                        text: ' to',
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 20),
                    children: [
                      TextSpan(
                          text: 'Travelogue', style: TextStyle(fontSize: 30)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 40),
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 25.0, // soften the shadow
                        spreadRadius: 5.0, //extend the shadow
                        offset: Offset(
                          10.0, // Move to right 10  horizontally
                          10.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                  ),
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              CustomTextFormField(
                contentPaddingHorizontal: 10,
                contentPaddingVertical: 10,
                isDense: false,
                controller: emailController,
                labelText: "Email",
                validator: (v) {
                  return validateEmail(v!);
                },
                autoValidateMode: AutovalidateMode.onUserInteraction,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, right: 30, left: 30, bottom: 2),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                        labelText: "Password",
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0.0),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {}, child: const Text("Forgot password?"))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30, left: 30, bottom: 10),
                child: BlocProvider<LogInBloc>(
                  create: (context) => _logInBloc,
                  child: BlocListener<LogInBloc, LogInState>(
                    listener: (context, userLogInState) {
                      if (userLogInState is LogInStateLoaded) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.blue,
                            content: Text(userLogInState.responseModel.message
                                .toString())));
                      }
                      if (userLogInState is LogInStateError) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(userLogInState.message.toString())));
                      }
                    },
                    child: BlocConsumer<LogInBloc, LogInState>(
                      listener: (context, state) {
                        if (state is LogInStateLoaded) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Colors.blue,
                                  content: Text("Logged in successfully")));
                          setSharedPref(state.responseModel.data!.email.toString(), state.responseModel.data!.token.toString());
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => const HomePageScreen()));                          }
                      },
                      builder: (context, state) {
                        if (state is LogInStateLoading) {
                          return SizedBox(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Platform.isAndroid
                                  ? const CircularProgressIndicator(
                                      color: Colors.blue,
                                    )
                                  : const CupertinoActivityIndicator(),
                            ),
                          );
                        }
                        return ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<LogInBloc>(context).add(
                                  LogInEvent(emailController.text.toString(),
                                      passwordController.text.toString()));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.lightBlue,
                              fixedSize: const Size(double.infinity, 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                width: 30,
                              ),
                              const Text('Log In'),
                              Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.blueAccent),
                                  child: Icon(
                                    Icons.arrow_forward_outlined,
                                    color: Colors.lightBlue.shade200,
                                  ))
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Row(children: [
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 30.0, right: 20.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                ),
                const Text("OR"),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 30.0),
                      child: const Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign up',
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const SignUpScreen()
                          ));
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
