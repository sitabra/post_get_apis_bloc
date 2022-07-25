import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_details_bloc.dart';
import '../repository/user_details_repository.dart';

class ProfileScreen extends StatefulWidget {
  final String id;
  const ProfileScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserDetailsBloc _userDetailsBloc =
      UserDetailsBloc(UserDetailsRepository());

  @override
  void initState() {
    super.initState();
    _userDetailsBloc.add(UserDetailsEvent(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ID: ${widget.id}"),
      ),
      body: SingleChildScrollView(
        child: BlocProvider<UserDetailsBloc>(
          create: (context) => _userDetailsBloc,
          child: BlocConsumer<UserDetailsBloc, UserDetailsState>(
            listener: (context, state) {
              if (state is UserDetailsStateLoading) {
                const Center(child: CircularProgressIndicator());
              }
              if (state is UserDetailsStateLoaded) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Data Loaded Successfully")));
              }
              if (state is UserDetailsStateError) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message.toString())));
              }
            },
            builder: (context, state) {
              if (state is UserDetailsStateLoaded) {
                var userDetailsData = state.responseModel;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                                userDetailsData.profilepicture.toString(),),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          "ID: ${userDetailsData.iD}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.person),
                          ),
                          Text("Name: ${userDetailsData.name}",
                              style: const TextStyle(
                                fontSize: 18,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.email),
                          ),
                          Text("Email: ${userDetailsData.email}",
                              style: const TextStyle(
                                fontSize: 18,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.location_on_rounded),
                          ),
                          Text("Location: ${userDetailsData.location}",
                              style: const TextStyle(
                                fontSize: 18,
                              )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Create date: ${userDetailsData.createdat}",
                            style: const TextStyle(
                              fontSize: 15,
                            )),
                      ),
                    ],
                  ),
                );
              }
              if (state is UserDetailsStateLoading) {
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
      ),
    );
  }
}
