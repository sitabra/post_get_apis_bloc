import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/log_in_screen/ui/log_in_screen_ui.dart';

mixin LogOut{
  void logOut(BuildContext context) async{
    SharedPreferences logInData = await SharedPreferences.getInstance();
    logInData.remove('login');
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const LogInScreen()
        ));
  }
}