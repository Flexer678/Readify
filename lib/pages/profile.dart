import 'package:flutter/material.dart';

class Person extends StatelessWidget {
  Person({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Center(
          child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 350,
            ),
            Text("readify version 1"),
            SizedBox(
              height: 10,
            ),
            Text(
              "note: this app does not store any data of books and or any user information, it only scrapes off websites and displays the information",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Nothing here \n wait for the following updates for something to show up",
              textAlign: TextAlign.center,
            )
          ],
        ),
      )),
    );
  }
}
