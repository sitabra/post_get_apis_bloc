import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing_auth_api/constant/log_out.dart';
import 'package:testing_auth_api/screens/log_in_screen/ui/log_in_screen_ui.dart';
class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> with LogOut {
  late SharedPreferences logInData;
  void initial() async {
    logInData = await SharedPreferences.getInstance();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
              logOut(context);
            },
                child: const Text("Log Out"),),
          ],
        ),
      ),
    );
  }
}
