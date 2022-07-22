import 'package:flutter/material.dart';

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
    return Card(
        child: Column(
      children: [
        Row(
          children: [
            Image.network(
              imgUrl,
              height: 100,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Serial No: $serialNo"),
                Text("Id No: $iD"),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name: $name"),
            Text("Email id: $email"),
            Text("Created date: $date"),
            Text("Location: $location"),
          ],
        ),
      ],
    ));
  }
}
