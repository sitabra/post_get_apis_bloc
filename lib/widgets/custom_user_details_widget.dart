import 'package:flutter/material.dart';
import 'package:testing_auth_api/screens/profile_screen/ui/profile_screen_ui.dart';

class CustomUserDetailsWidget extends StatelessWidget {
  final String imgUrl;
  final String name;
  final String email;
  final String date;
  final String serialNo;
  final String id;
  final String iD;
  final String location;
  const CustomUserDetailsWidget(this.imgUrl, this.name, this.email, this.date,
      this.serialNo, this.id, this.iD, this.location,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProfileScreen(id: id,)
            ));
      },
      onLongPress: () {
        showDialog(
          context: context, builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Message"),
            content: const Text("Are you sure ?"),
            actions: [
              TextButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
        );
      },
      child: Card(
          elevation: 2,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        imgUrl,
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Serial No: $serialNo"),
                          Text("Id No: $id"),
                          Text("Name: $name", style: const TextStyle(fontWeight: FontWeight.bold),),
                          Text("Email id: $email", style: const TextStyle(fontWeight: FontWeight.w100),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
