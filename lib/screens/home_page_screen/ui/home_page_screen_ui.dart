import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_auth_api/screens/home_page_screen/bloc/user_bloc.dart';
import '../../../helper/log_out.dart';
import '../../../utils/validator.dart';
import '../../../widgets/custom_user_details_widget.dart';
import '../repository/user_repository.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    with LogOut, Validator {
  TextEditingController idController = TextEditingController();
  final UserBloc _userBloc = UserBloc(UserRepository());

  @override
  void initState() {
    super.initState();
    _userBloc.add(const UserEvent("2"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: const Text("Home Page"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                logOut(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocProvider<UserBloc>(
                create: (context) => _userBloc,
                child: BlocConsumer<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state is UserStateLoading) {
                      const Center(child: CircularProgressIndicator());
                    }
                    if (state is UserStateLoaded) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Data Loaded Successfully")));
                    }
                    if (state is UserStateError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message.toString())));
                    }
                  },
                  builder: (context, state) {
                    if (state is UserStateLoaded) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.responseModel.data?.length,
                          itemBuilder: (BuildContext context, index) {
                            var userData = state.responseModel.data![index];
                            return CustomUserDetailsWidget(
                              userData.profilepicture.toString(),
                              userData.name.toString(),
                              userData.email.toString(),
                              userData.createdat.toString(),
                              (index + 1).toString(),
                              userData.iD.toString(),
                              userData.id.toString(),
                              userData.location.toString(),
                            );
                          });
                    }
                    if (state is UserStateLoading) {
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
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(Icons.add),
                      title: const Text('Add contact'),
                      onTap: () {},
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
